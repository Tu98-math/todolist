import 'package:flutter/material.dart';
import 'package:to_do_list/routing/routes.dart';
import 'package:to_do_list/ui/walkthrough_screen/components/bot_nav.dart';
import 'package:to_do_list/ui/walkthrough_screen/components/top_content.dart';

class WalkthroughScreen extends StatefulWidget {
  const WalkthroughScreen({Key? key}) : super(key: key);

  @override
  _WalkthroughScreenState createState() => _WalkthroughScreenState();
}

class _WalkthroughScreenState extends State<WalkthroughScreen> {
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
        Navigator.pushNamed(context, Routes.logInRoute);
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
            SizedBox(
              height: size.height * .67,
              child: TopContent(
                indexPage: indexWalkThrough,
                press: _setIndexPage,
                pageController: _pageController,
              ),
            ),
            Spacer(),
            SizedBox(
              height: size.height * 0.32,
              child: BotNav(
                indexPage: indexWalkThrough,
                press: _nextPage,
              ),
            )
          ],
        ),
      ),
    );
  }
}
