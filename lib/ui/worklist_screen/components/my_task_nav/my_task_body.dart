import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'filter_button.dart';
import 'list_task_date.dart';
import 'list_task_month.dart';
import 'work_list_nav.dart';

class MyTaskBody extends StatefulWidget {
  const MyTaskBody({Key? key}) : super(key: key);

  @override
  _MyTaskBodyState createState() => _MyTaskBodyState();
}

class _MyTaskBodyState extends State<MyTaskBody> {
  bool _isToDay = true;
  bool _isFullMonth = false;
  void _targetToday(String taget) {
    setState(() {
      if (taget == "Today") {
        _isToDay = true;
      } else {
        _isToDay = false;
      }
    });
  }

  void _setFullMonth(bool isFullMonth) {
    setState(() {
      _isFullMonth = isFullMonth;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildMainAppBar(),
      body: Scaffold(
        appBar: AppBar(automaticallyImplyLeading: false, actions: [
          WorkListNav(
            isToDay: _isToDay,
            press: _targetToday,
          ),
        ]),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!_isToDay)
                ListTaskMonth(
                  isFullMonth: _isFullMonth,
                  press: _setFullMonth,
                ),
              ListTaskDate(),
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildMainAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(
        "Work List",
      ),
      actions: [
        FilterButton(),
      ],
    );
  }
}
