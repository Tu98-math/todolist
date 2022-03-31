import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:to_do_list/constants/images.dart';
import 'package:to_do_list/routing/app_routes.dart';
import 'package:to_do_list/widgets/sign_in_button.dart';
import 'package:to_do_list/widgets/sign_in_content.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController _forgotPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SignInContent(
                title: "Forgot Password",
                content:
                    "Please enter your email below to receive your password reset instructions",
              ),
              TextFormField(
                controller: _forgotPassword,
                style:
                    TextStyle(decorationColor: Colors.black.withOpacity(0.01)),
                decoration: InputDecoration(
                  labelText: "Username",
                  hintText: "Enter your username",
                ),
              ),
              SizedBox(height: 32),
              SignInButton(
                text: "Send Request",
                press: () async {
                  Navigator.pushNamed(context, AppRoutes.resetPasswordRoute);
                },
              ),
              SizedBox(height: 20),
            ],
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
