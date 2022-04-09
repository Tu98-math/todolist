import 'package:flutter/material.dart';
import 'package:to_do_list/constants/app_colors.dart';
import 'package:to_do_list/util/extension/dimens.dart';

class CheckItem extends StatelessWidget {
  const CheckItem({
    Key? key,
    required this.index,
    required this.controller,
  }) : super(key: key);

  final int index;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 20.w,
            height: 20.w,
            decoration: BoxDecoration(
              color: AppColors.kGrayBack,
              borderRadius: BorderRadius.circular(3.r),
              border: Border.all(
                color: AppColors.kInnerBorder,
              ),
            ),
          ),
          SizedBox(width: 14),
          Expanded(
            child: TextFormField(
              controller: controller,
              validator: (val) =>
                  val!.isNotEmpty ? null : "Please enter list item",
              decoration: InputDecoration(
                hintText: "List Item ${index + 1}",
                hintStyle: TextStyle(
                  color: AppColors.kGrayText,
                ),
                border: InputBorder.none,
              ),
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}
