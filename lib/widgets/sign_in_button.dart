import 'package:flutter/material.dart';
import 'package:to_do_list/constants/app_colors.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({
    Key? key,
    required this.text,
    required this.press,
    this.width = -1,
    this.color = AppColors.kPrimaryColor,
    this.disable = true,
  }) : super(key: key);

  final String text;
  final Function press;
  final double width;
  final Color color;
  final bool disable;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: disable ? () => press() : () {},
      child: Container(
        width: width == -1 ? size.width : width,
        decoration: BoxDecoration(
          color: color.withOpacity(disable ? 1 : 0.4),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 13,
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontFamily: 'AvenirNextRoundedPro',
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
