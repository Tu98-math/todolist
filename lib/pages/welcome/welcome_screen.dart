import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import '/constants/app_colors.dart';
import '/constants/images.dart';
import '/pages/welcome/welcome_provider.dart';
import '/pages/welcome/welcome_vm.dart';
import '/util/extension/widget_extension.dart';
import '../../base/base_state.dart';
import '../../routing/routes.dart';

class WelcomeScreen extends StatefulWidget {
  final ScopedReader watch;

  static Widget instance() {
    return Consumer(builder: (context, watch, _) {
      return WelcomeScreen._(watch);
    });
  }

  const WelcomeScreen._(this.watch);

  @override
  State<StatefulWidget> createState() {
    return WelcomeState();
  }
}

class WelcomeState extends BaseState<WelcomeScreen, WelcomeViewModel> {
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
          Get.offAndToNamed(Routes.walkThroughRoute);
          debugPrint('Get: WALK_THROUGH ');
          break;
        case InitialStatus.home:
          Get.offAndToNamed(Routes.workListScreen);
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
      body: buildWelcome(),
    );
  }

  Container buildWelcome() {
    return Container(
      color: Colors.white,
      width: maxW,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppImages.imgLogo,
            width: maxW * .4,
            fit: BoxFit.fitWidth,
          ),
          SizedBox(
            height: 12,
          ),
          'aking'.trim().plain().fSize(48).weight(FontWeight.bold).fShadow(
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
