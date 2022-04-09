import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list/constants/constants.dart';
import 'package:to_do_list/widgets/primary_button.dart';

import '/constants/app_colors.dart';
import '/constants/images.dart';
import '/routing/app_routes.dart';
import '/util/extension/dimens.dart';
import '/util/extension/widget_extension.dart';

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
    return Container(
      width: screenWidth,
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
          PrimaryButton(
            text: 'get_started',
            press: () => press(),
            textColor: AppColors.kText,
            backgroundColor: Colors.white,
          ),
          SizedBox(height: 22.w),
          'login'
              .plain()
              .fSize(18.t)
              .color(Colors.white)
              .weight(FontWeight.bold)
              .b()
              .tr()
              .pad(10, 30)
              .inkTap(
                onTap: () => Get.toNamed(AppRoutes.SIGN_IN),
                borderRadius:
                    BorderRadius.circular(AppConstants.kDefaultBorderRadius.r),
              ),
        ],
      ),
    );
  }
}
