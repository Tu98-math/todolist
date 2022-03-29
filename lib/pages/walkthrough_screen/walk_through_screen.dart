import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import '/base/base_state.dart';
import '/routing/routes.dart';
import 'components/bot_nav.dart';
import 'components/top_content.dart';
import 'walk_through_provider.dart';
import 'walk_through_vm.dart';

class WalkThroughScreen extends StatefulWidget {
  final ScopedReader watch;

  static Widget instance() {
    return Consumer(builder: (context, watch, _) {
      return WalkThroughScreen._(watch);
    });
  }

  const WalkThroughScreen._(this.watch);

  @override
  State<StatefulWidget> createState() {
    return WalkThroughState();
  }
}

class WalkThroughState
    extends BaseState<WalkThroughScreen, WalkThroughViewModel> {
  int indexWalkThrough = 0;
  final PageController _pageController = PageController(initialPage: 0);

  void _nextPage() {
    setState(() {
      if (indexWalkThrough < 2) {
        indexWalkThrough++;
        _pageController.animateToPage(
          indexWalkThrough,
          duration: Duration(
            milliseconds: 300,
          ),
          curve: Curves.easeIn,
        );
      } else {
        Get.toNamed(Routes.logInRoute);
      }
    });
  }

  void _setIndexPage(index) {
    setState(() {
      indexWalkThrough = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildContent(size),
            Spacer(),
            buildNav(size),
          ],
        ),
      ),
    );
  }

  Widget buildContent(Size _size) {
    return SizedBox(
      height: _size.height * .67,
      child: TopContent(
        indexPage: indexWalkThrough,
        press: _setIndexPage,
        pageController: _pageController,
      ),
    );
  }

  Widget buildNav(Size _size) {
    return SizedBox(
      height: _size.height * 0.32,
      child: BotNav(
        indexPage: indexWalkThrough,
        press: _nextPage,
      ),
    );
  }

  @override
  WalkThroughViewModel getVm() => widget.watch(viewModelProvider).state;
}
