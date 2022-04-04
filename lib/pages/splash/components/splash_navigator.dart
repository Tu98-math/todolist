import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/util/extension/widget_extension.dart';
import '/constants/app_colors.dart';
import '/constants/constants.dart';
import '/constants/images.dart';
import '/routing/app_routes.dart';

class SplashNavigator extends StatelessWidget {
  const SplashNavigator({
    Key? key,
    required this.press,
    required this.indexPage,
  }) : super(key: key);

  final Function press;
  final int indexPage;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height * 0.32,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.imgWalkthroughBottom),
          fit: BoxFit.fill,
          colorFilter: ColorFilter.mode(
            AppColors.kColorWalkthrough[indexPage],
            BlendMode.srcATop,
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.circular(AppConstants.kDefaultBorderRadius),
            ),
            child: 'get_started'
                .plain()
                .fSize(18)
                .color(AppColors.kTextColor)
                .weight(FontWeight.bold)
                .b()
                .tr()
                .pad(13, 98),
          ).inkTap(
            onTap: () => press(),
          ),
          SizedBox(height: 32),
          'login'
              .plain()
              .fSize(18)
              .color(Colors.white)
              .weight(FontWeight.bold)
              .b()
              .tr()
              .inkTap(
                onTap: () => Get.toNamed(AppRoutes.SIGN_IN),
              ),
        ],
      ),
    );
  }
}
