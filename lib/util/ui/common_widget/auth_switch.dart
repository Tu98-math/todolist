import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/constants/constants.dart';
import '/routing/app_routes.dart';
import '/util/extension/extension.dart';

enum AuthCase { toSignIn, toSignUp }

class AuthSwitch extends StatelessWidget {
  const AuthSwitch({
    Key? key,
    required this.auth,
  }) : super(key: key);

  final AuthCase auth;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        (auth == AuthCase.toSignIn
                ? AppStrings.alreadyHaveAnAccount
                : AppStrings.doNotHaveAnAccount)
            .plain()
            .fSize(15)
            .b()
            .tr(),
        SizedBox(width: 3.w),
        (auth == AuthCase.toSignIn ? AppStrings.signIn : AppStrings.signUp)
            .plain()
            .fSize(15)
            .weight(FontWeight.bold)
            .color(AppColors.kPrimaryColor)
            .b()
            .tr()
            .inkTap(
          onTap: () {
            Get.offAndToNamed(
              auth == AuthCase.toSignIn ? AppRoutes.SIGN_IN : AppRoutes.SIGN_UP,
            );
          },
        ),
      ],
    );
  }
}
