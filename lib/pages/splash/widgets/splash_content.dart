import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '/constants/app_colors.dart';
import '/constants/constants.dart';
import '/constants/images.dart';
import '/util/extension/dimens.dart';
import '/util/extension/widget_extension.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key? key,
    required this.indexPage,
    required this.press,
    required this.pageController,
  }) : super(key: key);

  final int indexPage;
  final Function press;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 453.w,
            child: PageView.builder(
              controller: pageController,
              onPageChanged: (value) => press(value),
              itemCount: AppConstants.kLengthSplash,
              itemBuilder: (context, index) => buildContent(),
            ),
          ).pad(0, 0, 0, 48.w),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              AppConstants.kLengthSplash,
              (index) => buildDot(index: index),
            ),
          ),
        ],
      ),
    );
  }

  AnimatedContainer buildDot({required int index}) {
    return AnimatedContainer(
      duration: AppConstants.kAnimationDuration,
      margin: EdgeInsets.only(right: 8),
      height: 8,
      width: 8,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(index != indexPage ? .2 : 1),
        shape: BoxShape.circle,
      ),
    );
  }

  Widget buildContent() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            height: 231.w,
            child: Image.asset(
              AppImages.imgSplash[indexPage],
            ),
          ).pad(0, 0, 0, 53.w),
          AppConstants.kSplashTitle[indexPage]
              .tr()
              .plain()
              .fSize(24.t)
              .weight(FontWeight.bold)
              .b(),
          SizedBox(height: 9.w),
          AppConstants.kSplashDescription[indexPage]
              .tr()
              .plain()
              .fSize(18.t)
              .color(AppColors.kText80)
              .b(),
        ],
      ),
    );
  }
}
