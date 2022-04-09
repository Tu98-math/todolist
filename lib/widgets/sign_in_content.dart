import 'package:flutter/material.dart';
import 'package:to_do_list/constants/app_colors.dart';

import '/util/extension/dimens.dart';
import '/util/extension/widget_extension.dart';

class SignInContent extends StatelessWidget {
  const SignInContent({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  final String title, content;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screenWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title
              .plain()
              .fSize(32)
              .weight(FontWeight.bold)
              .lHeight(41)
              .color(AppColors.kText)
              .b(),
          SizedBox(height: 12.w),
          content.plain().fSize(16).lHeight(19.7).color(AppColors.grayText).b(),
          SizedBox(height: 48.w),
        ],
      ),
    );
  }
}
