import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import '/base/base_state.dart';
import '/constants/app_colors.dart';
import '/constants/images.dart';
import '/pages/welcome/welcome_provider.dart';
import '/pages/welcome/welcome_vm.dart';
import '/routing/app_routes.dart';
import '/util/extension/dimens.dart';
import '/util/extension/widget_extension.dart';

class WelcomePage extends StatefulWidget {
  final ScopedReader watch;

  static Widget instance() {
    return Consumer(builder: (context, watch, _) {
      return WelcomePage._(watch);
    });
  }

  const WelcomePage._(this.watch);

  @override
  State<StatefulWidget> createState() {
    return WelcomeState();
  }
}

class WelcomeState extends BaseState<WelcomePage, WelcomeViewModel> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    await Future.delayed(const Duration(seconds: 2));
    getVm().bsInitSate.listen((value) {
      switch (value) {
        case InitialStatus.onBoarding:
          Get.offAndToNamed(AppRoutes.SPLASH);
          debugPrint('Get: SPLASH ');
          break;
        case InitialStatus.home:
          Get.offAndToNamed(AppRoutes.HOME);
          debugPrint('Get: HOME');
          break;
        default:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(),
    );
  }

  Container buildBody() {
    return Container(
      color: Colors.white,
      width: screenWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppImages.imgLogo,
            width: 149.w,
            fit: BoxFit.fitWidth,
          ),
          SizedBox(
            height: 12.w,
          ),
          'aking'.trim().plain().fSize(48.t).weight(FontWeight.bold).fShadow(
            [
              BoxShadow(
                offset: Offset(0, 4),
                color: AppColors.shadowColor,
                blurRadius: 8,
              ),
              BoxShadow(
                offset: Offset(4, 0),
                color: AppColors.shadowColor,
                blurRadius: 8,
              ),
            ],
          ).b(),
        ],
      ),
    );
  }

  @override
  WelcomeViewModel getVm() => widget.watch(viewModelProvider).state;
}
