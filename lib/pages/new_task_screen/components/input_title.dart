import 'package:flutter/material.dart';
import 'package:to_do_list/constants/app_colors.dart';

class InputTitle extends StatelessWidget {
  const InputTitle({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 66,
      color: Color(0xFFF4F4F4),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          top: 10,
        ),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: "Title",
            hintStyle: TextStyle(
              color: AppColors.kTextColor,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
