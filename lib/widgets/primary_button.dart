import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/constants/app_colors.dart';
import 'package:to_do_list/util/extension/dimens.dart';
import 'package:to_do_list/util/extension/widget_extension.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    Key? key,
    required this.text,
    required this.press,
    this.backgroundColor = AppColors.kPrimaryColor,
    this.textColor = Colors.white,
    this.disable = true,
    this.width = 327,
    this.height = 48,
  }) : super(key: key);

  final String text;
  final Function press;
  final Color backgroundColor, textColor;
  final bool disable;
  final double width, height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width.w,
      height: height.w,
      decoration: BoxDecoration(
        color: backgroundColor.withOpacity(disable ? 1 : 0.4),
        borderRadius: BorderRadius.circular(5.r),
      ),
      child: text
          .plain()
          .fSize(18.t)
          .lHeight(21.09.t)
          .color(textColor)
          .weight(FontWeight.bold)
          .b()
          .tr()
          .center(),
    ).inkTap(
      onTap: disable ? () => press() : () {},
      borderRadius: BorderRadius.circular(5.r),
    );
  }
}
