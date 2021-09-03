import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:to_do_list/constants/images.dart';
import 'components/add_new_button.dart';
import 'components/menu_nav/menu_body.dart';
import 'components/my_task_nav/my_task_body.dart';
import 'components/profiles_nav/profiles_body.dart';
import 'components/quick_nav/quick_body.dart';

class WorkListScreen extends StatefulWidget {
  const WorkListScreen({Key? key}) : super(key: key);

  @override
  _WorkListScreenState createState() => _WorkListScreenState();
}

class _WorkListScreenState extends State<WorkListScreen> {
  int _currentIndex = 0;

  void _setCurrentIndex(int index) {
    setState(() {
      if (index != 2) {
        _currentIndex = index;
      }
    });
  }

  List<Widget> tabBottomNav = [
    MyTaskBody(),
    MenuBody(),
    SizedBox(),
    QuickBody(),
    ProfilesBody(),
  ];

  List<String> addTitle = [
    "New Task",
    "Add Note",
    "Add Check List",
  ];

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) {
        return Scaffold(
          body: tabBottomNav[_currentIndex],
          floatingActionButton:
              !isKeyboardVisible ? AddNewButton() : SizedBox(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: buildBottomNavigationBar(
            currenIndex: _currentIndex,
            press: _setCurrentIndex,
          ),
        );
      },
    );
  }

  BottomNavigationBar buildBottomNavigationBar({
    required int currenIndex,
    required Function press,
  }) {
    return BottomNavigationBar(
      selectedIconTheme: IconThemeData(color: Colors.white),
      showSelectedLabels: false,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
      currentIndex: currenIndex,
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
          index: 3,
        ),
        buildBottomNavigationBarItem(
          title: "Profile",
          icon: AppImages.profileIcon,
          index: 4,
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
              color: Colors.white.withOpacity(_currentIndex == index ? 1 : .5),
              width: size.width * .064,
              height: size.width * .064,
            ),
            SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(
                color:
                    Colors.white.withOpacity(_currentIndex == index ? 1 : .5),
              ),
            ),
          ],
        ),
      ),
      label: "",
    );
  }
}
