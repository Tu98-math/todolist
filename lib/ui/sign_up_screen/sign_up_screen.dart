import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/constants/app_colors.dart';
import 'package:to_do_list/constants/images.dart';
import 'package:to_do_list/routing/routes.dart';
import 'package:to_do_list/widgets/nav_to_login.dart';
import 'package:to_do_list/widgets/sign_in_button.dart';
import 'package:to_do_list/widgets/sign_in_content.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isHidden = true;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _fullNameController = TextEditingController();
  String _status = '';
  final _formKey = GlobalKey<FormState>();

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  Future<void> _checkSignUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _status = '';
      });
      print('Email ${_emailController.text}');
      print('Pass ${_passwordController.text}');
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        if (userCredential.user != null) {
          userCredential.user!
              // ignore: deprecated_member_use
              .updateProfile(displayName: _fullNameController.text);
          FirebaseFirestore.instance
              .collection('users')
              .doc(userCredential.user!.uid)
              .set({
            'avatar': '',
            'email': _emailController.text,
            'name': _fullNameController.text,
            'uid': userCredential.user!.uid,
          });
          Navigator.pushNamed(context, Routes.workListScreen);
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
          setState(() {
            _status = 'The password provided is too weak.';
          });
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
          setState(() {
            _status = 'The account already exists for that email.';
          });
        }
      } catch (e) {
        print(e);
      }
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
                  title: "Create Account",
                  content: "Sign up to continue",
                ),
                TextFormField(
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
                ),
                SizedBox(height: 20),
                NavToLogin(
                  isLogin: true,
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
}
