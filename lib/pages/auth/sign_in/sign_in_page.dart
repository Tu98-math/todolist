import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:to_do_list/pages/auth/widgets/auth_text_field.dart';
import 'package:to_do_list/util/extension/dimens.dart';

import '/base/base_state.dart';
import '/routing/app_routes.dart';
import '/util/extension/widget_extension.dart';
import '/widgets/auth_switch.dart';
import '/widgets/sign_in_content.dart';
import '../../../widgets/primary_button.dart';
import '../widgets/link_forgot_password.dart';
import 'sign_in_provider.dart';
import 'sign_in_vm.dart';

class SignInPage extends StatefulWidget {
  final ScopedReader watch;

  static Widget instance() {
    return Consumer(builder: (context, watch, _) {
      return SignInPage._(watch);
    });
  }

  const SignInPage._(this.watch);

  @override
  State<StatefulWidget> createState() {
    return SignInState();
  }
}

class SignInState extends BaseState<SignInPage, SignInViewModel> {
  bool _isHidden = true;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String signInStatusString = '';
  late UserCredential users;
  final _formKey = GlobalKey<FormState>();

  void togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  Future<void> loginClick() async {
    if (_formKey.currentState!.validate()) {
      getVm().login(_emailController.text, _passwordController.text);
    }
  }

  @override
  void initState() {
    super.initState();
    getVm().bsLoginStatus.listen((value) {
      switch (value) {
        case SignInStatus.networkError:
          setState(() {
            signInStatusString = 'Network Error';
          });
          break;
        case SignInStatus.successful:
          Get.offAndToNamed(AppRoutes.HOME);
          break;
        case SignInStatus.userDisabled:
          setState(() {
            signInStatusString = 'Email has been disabled';
          });
          break;
        case SignInStatus.invalidEmail:
          setState(() {
            signInStatusString = 'The email address is not valid.';
          });
          break;
        case SignInStatus.userNotFound:
          setState(() {
            signInStatusString = 'No user found for that email.';
          });
          break;
        case SignInStatus.wrongPassword:
          setState(() {
            signInStatusString = 'Wrong password provided for that user.';
          });
          break;
        default:
          setState(() {
            signInStatusString = '';
          });
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildForm(),
    );
  }

  Widget buildForm() => SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: StreamBuilder<SignInStatus>(
              stream: getVm().bsLoginStatus,
              builder: (context, snapshot) {
                bool onRunning = (snapshot.data == SignInStatus.run);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 86.w),
                    SignInContent(
                      title: StringTranslateExtension('welcome_back').tr(),
                      content:
                          StringTranslateExtension('sign_in_to_continue').tr(),
                    ),
                    AuthTextField(
                      controller: _emailController,
                      label: 'username',
                      hint: 'enter_your_username',
                      validator: (val) => val!.isNotEmpty
                          ? null
                          : StringTranslateExtension(
                                  'please_enter_a_email_address')
                              .tr(),
                      enabled: !onRunning,
                    ),
                    SizedBox(height: 32.w),
                    AuthTextField(
                      controller: _passwordController,
                      label: 'password',
                      hint: 'enter_your_password',
                      validator: (val) => val!.length < 6
                          ? StringTranslateExtension('enter_more_than_6_char')
                              .tr()
                          : null,
                      isPassword: true,
                      enabled: !onRunning,
                    ),
                    LinkForgotPassword().pad(0, 0, 12.w, 60.w),
                    Text(
                      '$signInStatusString',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                    SizedBox(height: 20.w),
                    PrimaryButton(
                      text: StringTranslateExtension('login').tr(),
                      press: loginClick,
                      disable: snapshot.data != SignInStatus.run,
                    ),
                    AuthSwitch(
                      auth: authCase.toSignUp,
                    ).pad(20.w, 0),
                  ],
                );
              }),
        ),
      ).marg(24.w);

  @override
  SignInViewModel getVm() => widget.watch(viewModelProvider).state;
}
