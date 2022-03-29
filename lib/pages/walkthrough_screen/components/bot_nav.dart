import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/constants/app_colors.dart';
import 'package:to_do_list/constants/constans.dart';
import 'package:to_do_list/constants/images.dart';
import 'package:to_do_list/routing/routes.dart';
import 'package:to_do_list/util/extension/widget_extension.dart';

class BotNav extends StatelessWidget {
  const BotNav({Key? key, required this.press, required this.indexPage})
      : super(key: key);

  final Function press;
  final int indexPage;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          left: 0,
          child: Image.asset(
            AppImages.imgWalkthroughBottom,
            height: size.height * 0.32,
            width: size.width,
            fit: BoxFit.fill,
            color: AppColors.kColorWalkthrough[indexPage],
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          height: size.height * 0.3,
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () => press(),
                child: Container(
                  width: 293,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                        AppConstants.kDefaultBorderRadius),
                  ),
                  child: 'get_started'
                      .plain()
                      .fSize(18)
                      .color(AppColors.kTextColor)
                      .weight(FontWeight.bold)
                      .b()
                      .tr()
                      .center(),
                ),
              ),
              SizedBox(height: 32),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, Routes.logInRoute);
                },
                child: 'login'
                    .plain()
                    .fSize(18)
                    .color(Colors.white)
                    .weight(FontWeight.bold)
                    .b()
                    .tr(),
              )
            ],
          ),
        ),
      ],
    );
  }
}