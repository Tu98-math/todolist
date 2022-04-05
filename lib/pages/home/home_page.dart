import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:to_do_list/pages/home/tab/quick_nav/quick_tab.dart';

import '/base/base_state.dart';
import '/constants/images.dart';
import '/util/extension/widget_extension.dart';
import 'home_provider.dart';
import 'home_vm.dart';
import 'tab/my_task/my_task_tab.dart';
import 'widgets/add_new_button.dart';

class HomePage extends StatefulWidget {
  final ScopedReader watch;

  static Widget instance() {
    return Consumer(builder: (context, watch, _) {
      return HomePage._(watch);
    });
  }

  const HomePage._(this.watch);

  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends BaseState<HomePage, HomeViewModel> {
  int currentTab = 0;
  PageController tabController = PageController();

  void logOutClick() {
    getVm().logOut();
  }

  List<Widget> tabWidget = [
    MyTaskTab.instance(),
    SizedBox(
      child: Center(
        child: 'Menu'.desc(),
      ),
    ),
    QuickTab.instance(),
    SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          'Profile'.desc(),
        ],
      ),
    ),
  ];

  void tabClick(int index) {
    if (index > 1) {
      setState(() {
        currentTab = index - 1;
      });
    } else {
      setState(() {
        currentTab = index;
      });
    }
    tabController.animateToPage(
      currentTab,
      duration: Duration(
        milliseconds: 300,
      ),
      curve: Curves.easeIn,
    );
  }

  void goTab(int index) {
    setState(() {
      currentTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(),
      floatingActionButton: AddNewButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: buildBottomNavigationBar(
        currentIndex: currentTab,
        press: tabClick,
      ),
    );
  }

  Container buildBody() {
    return Container(
      width: double.infinity,
      height: maxH,
      child: PageView.builder(
        itemCount: 4,
        onPageChanged: (index) => goTab(index),
        itemBuilder: (context, index) => tabWidget[index],
        controller: tabController,
      ),
    );
  }

  BottomNavigationBar buildBottomNavigationBar({
    required int currentIndex,
    required Function press,
  }) {
    return BottomNavigationBar(
      selectedIconTheme: IconThemeData(color: Colors.white),
      showSelectedLabels: false,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      backgroundColor: Color(0xFF292E4E),
      items: [
        buildBottomNavigationBarItem(
          title: "My Task",
          icon: AppImages.myTaskIcon,
          index: 0,
        ),
        buildBottomNavigationBarItem(
          title: "Menu",
          icon: AppImages.menuIcon,
          index: 1,
        ),
        BottomNavigationBarItem(icon: Container(), label: ""),
        buildBottomNavigationBarItem(
          title: "Quick",
          icon: AppImages.quickIcon,
          index: 2,
        ),
        buildBottomNavigationBarItem(
          title: "Profile",
          icon: AppImages.profileIcon,
          index: 3,
        ),
      ],
      onTap: (index) => press(index),
    );
  }

  BottomNavigationBarItem buildBottomNavigationBarItem({
    required String title,
    required String icon,
    required int index,
  }) {
    Size size = MediaQuery.of(context).size;
    return BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.only(
          top: 4,
        ),
        child: Column(
          children: [
            SvgPicture.asset(
              icon,
              color: Colors.white.withOpacity(currentTab == index ? 1 : .5),
              width: size.width * .064,
              height: size.width * .064,
            ),
            SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(
                color: Colors.white.withOpacity(currentTab == index ? 1 : .5),
              ),
            ),
          ],
        ),
      ),
      label: "",
    );
  }

  @override
  HomeViewModel getVm() => widget.watch(viewModelProvider).state;
}
