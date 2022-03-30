import 'package:flutter/material.dart';
import 'package:to_do_list/constants/app_colors.dart';

class SignInContent extends StatelessWidget {
  const SignInContent({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  final String title, content;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 60),
          Text(
            title,
            style: TextStyle(
              color: AppColors.kTextColor,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12),
          Text(
            content,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xFF9B9B9B),
            ),
          ),
          SizedBox(height: 48),
        ],
      ),
    );
  }
}
