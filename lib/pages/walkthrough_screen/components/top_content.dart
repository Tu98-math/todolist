import 'package:flutter/material.dart';

import '/constants/app_colors.dart';
import '/constants/constans.dart';
import '/services/walkthrough_cache.dart';

class TopContent extends StatelessWidget {
  const TopContent({
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
              itemBuilder: (context, index) => Content(indexPage: index),
            ),
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              AppConstants.kLengthWalkthrough,
              (index) => buildDot(index: index),
            ),
          ),
          Spacer(),
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
}

class Content extends StatelessWidget {
  const Content({
    Key? key,
    required this.indexPage,
  }) : super(key: key);
  final int indexPage;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(
            height: size.height * .48,
            child: Image.asset(
              WalkthroughCache.list[indexPage].imageTop,
            ),
          ),
          Text(
            WalkthroughCache.list[indexPage].title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 9),
          Text(
            WalkthroughCache.list[indexPage].content,
            style: TextStyle(
              fontSize: 18,
              color: AppColors.kTextColor.withOpacity(.8),
            ),
          ),
        ],
      ),
    );
  }
}
