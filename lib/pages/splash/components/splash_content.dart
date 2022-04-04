import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '/constants/app_colors.dart';
import '/constants/constants.dart';
import '/util/extension/widget_extension.dart';
import '/constants/images.dart';

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
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: size.height * .6,
            child: PageView.builder(
              controller: pageController,
              onPageChanged: (value) => press(value),
              itemCount: AppConstants.kLengthWalkthrough,
              itemBuilder: (context, index) => buildContent(context),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              AppConstants.kLengthWalkthrough,
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

  Widget buildContent(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(
            height: size.height * .48,
            child: Image.asset(
              AppImages.imgWalkThrough[indexPage],
            ),
          ),
          AppConstants.kWalkThroughTitle[indexPage]
              .tr()
              .plain()
              .fSize(24)
              .weight(FontWeight.bold)
              .b(),
          SizedBox(height: 9),
          AppConstants.kWalkThroughDescript[indexPage]
              .tr()
              .plain()
              .fSize(18)
              .color(AppColors.kTextColor80)
              .b(),
        ],
      ),
    );
  }
}
