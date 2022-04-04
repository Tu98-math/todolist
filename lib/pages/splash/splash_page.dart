import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import '/base/base_state.dart';
import '/routing/app_routes.dart';
import '/util/extension/widget_extension.dart';
import 'components/splash_navigator.dart';
import 'components/splash_content.dart';
import 'splash_provider.dart';
import 'splash_vm.dart';

class SplashPage extends StatefulWidget {
  final ScopedReader watch;

  static Widget instance() {
    return Consumer(builder: (context, watch, _) {
      return SplashPage._(watch);
    });
  }

  const SplashPage._(this.watch);

  @override
  State<StatefulWidget> createState() {
    return SplashState();
  }
}

class SplashState
    extends BaseState<SplashPage, SplashViewModel> {
  int currentSplash = 0;
  final PageController pageController = PageController(initialPage: 0);

  void toNextPage() {
    setState(() {
      if (currentSplash < 2) {
        currentSplash++;
        pageController.animateToPage(
          currentSplash,
          duration: Duration(
            milliseconds: 300,
          ),
          curve: Curves.easeIn,
        );
      } else {
        Get.offAndToNamed(AppRoutes.logInRoute);
      }
    });
  }

  void setCurrentPage(index) {
    setState(() {
      currentSplash = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: maxH,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildContent(),
            buildNavigator(),
          ],
        ),
      ),
    );
  }

  Widget buildContent() {
    return SizedBox(
      height: maxH * .67,
      child: SplashContent(
        indexPage: currentSplash,
        press: setCurrentPage,
        pageController: pageController,
      ),
    );
  }

  Widget buildNavigator() {
    return SizedBox(
      height: maxH * 0.32,
      child: SplashNavigator(
        indexPage: currentSplash,
        press: toNextPage,
      ),
    );
  }

  @override
  SplashViewModel getVm() => widget.watch(viewModelProvider).state;
}
