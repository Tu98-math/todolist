import 'package:flutter/material.dart';
import 'package:to_do_list/constants/app_colors.dart';

class SignInContent extends StatelessWidget {
  const SignInContent({
    Key? key,
    required this.title,
    required this.content,
    this.succesful = false,
  }) : super(key: key);

  final String title, content;
  final bool succesful;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      child: Column(
        crossAxisAlignment:
            succesful ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          SizedBox(height: succesful ? 40 : 60),
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
            textAlign: succesful ? TextAlign.center : TextAlign.start,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: succesful ? AppColors.kTextColor : Color(0xFF9B9B9B),
            ),
          ),
          SizedBox(height: 48),
        ],
      ),
    );
  }
}
