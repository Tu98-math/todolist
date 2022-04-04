import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import '/constants/app_colors.dart';
import '/routing/app_routes.dart';
import '/util/extension/widget_extension.dart';
import '/widgets/nav_to_login.dart';
import '/widgets/sign_in_button.dart';
import '/widgets/sign_in_content.dart';
import '/base/base_state.dart';
import 'components/link_forgot_password.dart';
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
        case LoginStatus.run:
          setState(() {
            signInStatusString = '';
          });
          break;
        case LoginStatus.successful:
          Get.offAndToNamed(AppRoutes.workListScreen);
          break;
        case LoginStatus.userDisabled:
          setState(() {
            signInStatusString = 'Email has been disabled';
          });
          break;
        case LoginStatus.invalidEmail:
          setState(() {
            signInStatusString = 'The email address is not valid.';
          });
          break;
        case LoginStatus.userNotFound:
          setState(() {
            signInStatusString = 'No user found for that email.';
          });
          break;
        case LoginStatus.wrongPassword:
          setState(() {
            signInStatusString = 'Wrong password provided for that user.';
          });
          break;
        default:
          setState(() {
            signInStatusString = 'Network Error';
          });
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SignInContent(
                title: StringTranslateExtension('welcome_back').tr(),
                content: StringTranslateExtension('sign_in_to_continue').tr(),
              ).pad(0, 0, 20),
              TextFormField(
                controller: _emailController,
                validator: (val) => val!.isNotEmpty
                    ? null
                    : StringTranslateExtension('please_enter_a_email_address')
                        .tr(),
                style: TextStyle(
                  decorationColor: AppColors.kTextColor10,
                ),
                decoration: InputDecoration(
                  labelText: StringTranslateExtension('email').tr(),
                  hintText: StringTranslateExtension('enter_your_email').tr(),
                ),
              ),
              SizedBox(height: 32),
              TextFormField(
                controller: _passwordController,
                validator: (val) => val!.length < 6
                    ? StringTranslateExtension('enter_more_than_6_char').tr()
                    : null,
                obscureText: _isHidden,
                obscuringCharacter: '●',
                decoration: InputDecoration(
                  labelText: StringTranslateExtension('password').tr(),
                  hintText:
                      StringTranslateExtension('enter_your_password').tr(),
                  suffix: InkWell(
                    onTap: togglePasswordView,
                    child: Icon(
                      Icons.visibility_outlined,
                      color: AppColors.kLightTextColor,
                    ),
                  ),
                ),
              ),
              LinkForgotPassword().pad(0, 0, 12, 60),
              Text(
                '$signInStatusString',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              SizedBox(height: 20),
              StreamBuilder<LoginStatus>(
                stream: getVm().bsLoginStatus,
                builder: (context, snapshot) {
                  return SignInButton(
                    text: StringTranslateExtension('login').tr(),
                    press: loginClick,
                    disable: snapshot.data != LoginStatus.run,
                  );
                },
              ),
              NavToLogin(
                isLogin: false,
              ).pad(20, 0),
            ],
          ),
        ),
      ).pad(24),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      elevation: 0,
      leading: SizedBox(),
    );
  }

  @override
  SignInViewModel getVm() => widget.watch(viewModelProvider).state;
}
