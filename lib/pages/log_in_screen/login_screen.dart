import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '/constants/app_colors.dart';
import '/constants/images.dart';
import '/pages/log_in_screen/components/link_forgot_password.dart';
import '/pages/log_in_screen/login_vm.dart';
import '/routing/routes.dart';
import '/widgets/nav_to_login.dart';
import '/widgets/sign_in_button.dart';
import '/widgets/sign_in_content.dart';
import '../../base/base_state.dart';
import 'login_provider.dart';

class LoginScreen extends StatefulWidget {
  final ScopedReader watch;

  static Widget instance() {
    return Consumer(builder: (context, watch, _) {
      return LoginScreen._(watch);
    });
  }

  const LoginScreen._(this.watch);

  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends BaseState<LoginScreen, LoginViewModel> {
  bool _isHidden = true;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String _status = '';
  late UserCredential users;
  final _formKey = GlobalKey<FormState>();

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  Future<void> _checkLogin() async {
    if (_formKey.currentState!.validate()) {
      print('Email ${_emailController.text}');
      print('Pass ${_passwordController.text}');
      setState(() {
        _status = 'loading...';
      });
      users = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      setState(() {
        _status = '';
      });
    }
    if (users.user != null) {
      Navigator.pushNamed(context, Routes.workListScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SignInContent(
                  title: "Welcome back",
                  content: "Sign in to continue",
                ),
                TextFormField(
                  controller: _emailController,
                  validator: (val) =>
                      val!.isNotEmpty ? null : 'Please enter a email address',
                  style: TextStyle(
                    decorationColor: Colors.black.withOpacity(0.01),
                  ),
                  decoration: InputDecoration(
                    labelText: "Email",
                    hintText: "Enter your email",
                  ),
                ),
                SizedBox(height: 32),
                TextFormField(
                  controller: _passwordController,
                  validator: (val) =>
                      val!.length < 6 ? 'Enter more than 6 char' : null,
                  obscureText: _isHidden,
                  obscuringCharacter: '●',
                  decoration: InputDecoration(
                    labelText: "Password",
                    hintText: "Enter your password",
                    suffix: InkWell(
                      onTap: _togglePasswordView,
                      child: Icon(
                        Icons.visibility_outlined,
                        color: AppColors.kLightTextColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12),
                LinkForgotPassword(),
                SizedBox(height: 60),
                Text(
                  "$_status",
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
                SizedBox(height: 20),
                SignInButton(
                  text: "Log In",
                  press: _checkLogin,
                ),
                SizedBox(height: 20),
                NavToLogin(
                  isLogin: false,
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      elevation: 0,
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: SvgPicture.asset(
              AppImages.prevIcon,
            ), // Put icon of your preference.
            onPressed: () {
              Navigator.pop(context);
            },
          );
        },
      ),
    );
  }

  @override
  LoginViewModel getVm() => widget.watch(viewModelProvider).state;
}
