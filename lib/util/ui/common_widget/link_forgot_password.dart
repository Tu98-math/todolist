import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/constants/constants.dart';
import '/routing/app_routes.dart';
import '/util/extension/extension.dart';

class LinkForgotPassword extends StatelessWidget {
  const LinkForgotPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        AppStrings.forgotPassword.text18(fontWeight: FontWeight.bold).inkTap(
            onTap: () {
          Get.toNamed(AppRoutes.FORGOT_PASSWORD);
        }).pad(0, 0, 12, 60),
      ],
    );
  }
}
