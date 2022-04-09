import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/constants/app_colors.dart';
import '/routing/app_routes.dart';
import '/util/extension/widget_extension.dart';

enum authCase { toSignIn, toSignUp }

class AuthSwitch extends StatelessWidget {
  const AuthSwitch({
    Key? key,
    required this.auth,
  }) : super(key: key);

  final authCase auth;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        (auth == authCase.toSignIn
                ? 'Already have an account?'
                : "Don’t have an account?")
            .plain()
            .fSize(15)
            .color(AppColors.kText)
            .b(),
        (auth == authCase.toSignIn ? ' Sign In' : " Sign Up")
            .plain()
            .fSize(15)
            .weight(FontWeight.bold)
            .color(AppColors.kPrimaryColor)
            .b()
            .inkTap(
          onTap: () {
            Get.offAndToNamed(
              auth == authCase.toSignIn ? AppRoutes.SIGN_IN : AppRoutes.SIGN_UP,
            );
          },
        ),
      ],
    );
  }
}
