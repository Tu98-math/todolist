import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:to_do_list/constants/images.dart';
import 'package:to_do_list/routing/routes.dart';
import 'package:to_do_list/widgets/sign_in_button.dart';
import 'package:to_do_list/widgets/sign_in_content.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

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
                title: "Reset Password",
                content:
                    "Reset code was sent to your phone. Please enter the code and create new password",
              ),
              TextField(
                style:
                    TextStyle(decorationColor: Colors.black.withOpacity(0.01)),
                decoration: InputDecoration(
                  labelText: "Reset code",
                  hintText: "Enter your number",
                ),
              ),
              SizedBox(height: 32),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  hintText: "Enter your password",
                ),
              ),
              SizedBox(height: 32),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Confirm password",
                  hintText: "Enter your confirm password",
                ),
              ),
              SizedBox(height: 80),
              SignInButton(
                text: "Change password",
                press: () => {
                  Navigator.pushNamed(context, Routes.succesfulScreen),
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
