import 'package:flutter/material.dart';
import 'package:to_do_list/constants/app_colors.dart';
import 'package:to_do_list/routing/app_routes.dart';

class LinkForgotPassword extends StatelessWidget {
  const LinkForgotPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Spacer(),
        InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              AppRoutes.forgotPasswordRoute,
            );
          },
          child: Text(
            "Forgot password",
            style: TextStyle(
                color: AppColors.kTextColor,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
