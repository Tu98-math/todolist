import 'package:flutter/material.dart';
import 'package:to_do_list/constants/app_colors.dart';
import 'package:to_do_list/routing/routes.dart';

class NavToLogin extends StatelessWidget {
  const NavToLogin({
    Key? key,
    this.isLogin = true,
  }) : super(key: key);

  final bool isLogin;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          isLogin ? 'Already have an account?' : "Don’t have an account?",
          style: TextStyle(
            color: Color(0xFF485068),
            fontSize: 15,
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.pushNamed(
                context, isLogin ? Routes.logInRoute : Routes.signUpRoutes);
          },
          child: Text(
            isLogin ? ' Login' : " Sign Up",
            style: TextStyle(
              color: AppColors.kPrimaryColor,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
        ),
      ],
    );
  }
}
