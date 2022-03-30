import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:to_do_list/constants/app_colors.dart';
import 'package:to_do_list/constants/images.dart';
import 'package:to_do_list/pages/sign_up_screen/sign_up_vm.dart';
import 'package:to_do_list/routing/routes.dart';
import 'package:to_do_list/widgets/nav_to_login.dart';
import 'package:to_do_list/widgets/sign_in_button.dart';
import 'package:to_do_list/widgets/sign_in_content.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../base/base_state.dart';
import 'sign_up_provider.dart';

class SignUpScreen extends StatefulWidget {
  final ScopedReader watch;

  static Widget instance() {
    return Consumer(builder: (context, watch, _) {
      return SignUpScreen._(watch);
    });
  }

  const SignUpScreen._(this.watch);

  @override
  State<StatefulWidget> createState() {
    return SignUpState();
  }
}

class SignUpState extends BaseState<SignUpScreen, SignUpViewModel> {
  bool _isHidden = true;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _fullNameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String _status = '';

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

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
        case SignUpStatus.successfulEmail:
          Get.offAndToNamed(Routes.workListScreen);
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
      appBar: buildAppBar(),
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
              SignInContent(
                title: "Create Account",
                content: "Sign up to continue",
              ),
              TextFormField(
                enabled: !onRunning,
                controller: _fullNameController,
                validator: (val) =>
                    val!.length < 6 ? 'Enter more than 6 char' : null,
                style: TextStyle(
                  decorationColor: Colors.black.withOpacity(0.01),
                ),
                decoration: InputDecoration(
                  labelText: "Full Name",
                  hintText: "Enter your full name",
                ),
              ),
              SizedBox(height: 22),
              TextFormField(
                enabled: !onRunning,
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
              SizedBox(height: 22),
              TextFormField(
                enabled: !onRunning,
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
              SizedBox(height: 60),
              Text(
                "$_status",
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              SizedBox(height: 20),
              SignInButton(
                text: "Sign Up",
                press: _checkSignUp,
                disable: !onRunning,
              ),
              SizedBox(height: 20),
              NavToLogin(
                isLogin: true,
              ),
              SizedBox(height: 20),
            ],
          );
        },
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
              Get.back();
            },
          );
        },
      ),
    );
  }

  @override
  SignUpViewModel getVm() => widget.watch(viewModelProvider).state;
}
