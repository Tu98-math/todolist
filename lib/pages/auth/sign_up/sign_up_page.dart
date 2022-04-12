import 'package:flutter/material.dart';
import 'package:to_do_list/routing/app_routes.dart';
import 'package:to_do_list/util/extension/dimens.dart';
import 'package:to_do_list/widgets/auth_switch.dart';
import 'package:to_do_list/widgets/primary_button.dart';
import 'package:to_do_list/widgets/sign_in_content.dart';

import '/base/base_state.dart';
import '/util/ui/common_widget/auth_text_field.dart';
import 'sign_up_provider.dart';
import 'sign_up_vm.dart';

class SignUpPage extends StatefulWidget {
  final ScopedReader watch;

  static Widget instance() {
    return Consumer(builder: (context, watch, _) {
      return SignUpPage._(watch);
    });
  }

  const SignUpPage._(this.watch);

  @override
  State<StatefulWidget> createState() {
    return SignUpState();
  }
}

class SignUpState extends BaseState<SignUpPage, SignUpViewModel> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _fullNameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String _status = '';

  Future<void> _checkSignUp() async {
    if (_formKey.currentState!.validate()) {
      getVm().signUp(_emailController.text, _passwordController.text);
    }
  }

  @override
  void initState() {
    super.initState();
    getVm().bsSignUpStatus.listen((value) {
      switch (value) {
        case SignUpStatus.successfulEmail:
          getVm().createData(_emailController.text, _fullNameController.text);
          break;
        case SignUpStatus.successfulData:
          Get.offAndToNamed(AppRoutes.HOME);
          break;
        default:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: SingleChildScrollView(
          child: buildForm(),
        ),
      ),
    );
  }

  Form buildForm() {
    return Form(
      key: _formKey,
      child: StreamBuilder<SignUpStatus>(
        stream: getVm().bsSignUpStatus,
        builder: (context, snapshot) {
          bool onRunning = (snapshot.data == SignUpStatus.runData) ||
              (snapshot.data == SignUpStatus.runEmail);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 86.w),
              SignInContent(
                title: "Create Account",
                content: "Sign up to continue",
              ),
              AuthTextField(
                controller: _fullNameController,
                label: 'Full Name',
                hint: 'Enter your full name',
                validator: (val) =>
                    val!.length < 6 ? 'Enter more than 6 char' : null,
                enabled: !onRunning,
              ),
              SizedBox(height: 32.w),
              AuthTextField(
                controller: _emailController,
                label: 'username',
                hint: 'enter_your_username',
                validator: (val) => val!.isNotEmpty
                    ? null
                    : StringTranslateExtension('please_enter_a_email_address')
                        .tr(),
                enabled: !onRunning,
              ),
              SizedBox(height: 32.w),
              AuthTextField(
                controller: _passwordController,
                label: 'password',
                hint: 'enter_your_password',
                validator: (val) => val!.length < 6
                    ? StringTranslateExtension('enter_more_than_6_char').tr()
                    : null,
                isPassword: true,
                enabled: !onRunning,
              ),
              SizedBox(height: 60),
              Text(
                "$_status",
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              SizedBox(height: 20),
              PrimaryButton(
                text: "Sign Up",
                press: _checkSignUp,
                disable: !onRunning,
              ),
              SizedBox(height: 20),
              AuthSwitch(
                auth: authCase.toSignIn,
              ),
              SizedBox(height: 20),
            ],
          );
        },
      ),
    );
  }

  @override
  SignUpViewModel getVm() => widget.watch(viewModelProvider).state;
}
