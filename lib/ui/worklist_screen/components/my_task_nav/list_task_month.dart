import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:to_do_list/constants/app_colors.dart';
import 'package:to_do_list/constants/constans.dart';
import 'package:to_do_list/constants/images.dart';
import 'package:to_do_list/models/to_do_date_model.dart';
import 'date_on_week.dart';

class ListTaskMonth extends StatefulWidget {
  const ListTaskMonth({
    Key? key,
    required this.isFullMonth,
    required this.press,
  }) : super(key: key);

  final bool isFullMonth;
  final Function press;

  @override
  _ListTaskMonthState createState() => _ListTaskMonthState();
}

class _ListTaskMonthState extends State<ListTaskMonth> {
  List<ToDoDate> _listDate = []; 
  final User? user = FirebaseAuth.instance.currentUser;

  Future<void> loadMonth() async {
    DateTime now = DateTime.now();
    int startDay = -1 * now.day - 1;
    DateTime startMonth = DateTime.now().add(Duration(days: startDay));
    bool inMonth = false;
    for (int i = 0; i < 35; i++) {
      if (startMonth.add(Duration(days: i)).day == 1) {
        inMonth = !inMonth;
      }
      bool _isTask = false;
      await FirebaseFirestore.instance
      .collection('project')
      .get()
      .then((snap) {
        for (int j = 0; j < snap.docs.length; j++) {
          final listID = snap.docs.asMap()[j]!['member'];
          listID.add(snap.docs.asMap()[j]!['for']);
          if (listID.contains(user!.uid)) {
            if (startMonth.add(Duration(days: i)).millisecondsSinceEpoch < DateTime.parse(snap.docs.asMap()[j]!['date'].toString()).millisecondsSinceEpoch  &&
              startMonth.add(Duration(days: i)).millisecondsSinceEpoch > DateTime.parse(snap.docs.asMap()[j]!['create'].toString()).millisecondsSinceEpoch)
            _isTask = true;
          } 
        }
      });
      setState(() {
        _listDate.add(new ToDoDate(
          day: startMonth.add(Duration(days: i)).day,
          isMonth: inMonth,
          isTask: _isTask,
        ),
      );
      });
      
    }
    print(startMonth.toString());
  }

  @override
  void initState() {
    loadMonth();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    DateTime now = DateTime.now();
    
    
    return Container(
      width: size.width,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          offset: Offset(0, 5),
          color: AppColors.kBoxShadow,
        )
      ]),
      child: Column(
        children: [
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${AppConstants.kMonthHeader[now.month - 1]} ${now.year}".toUpperCase(),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () => widget.press(!widget.isFullMonth),
                icon: SvgPicture.asset(
                  widget.isFullMonth ? AppImages.upIcon : AppImages.downIcon,
                ),
              ),
            ],
          ),
          Container(
            width: size.width,
            height: 25,
            child: ListView.builder(
              itemCount: 7,
              itemBuilder: (context, index) => MonthItem(
                text: AppConstants.kWeekHeader[index],
                isHeader: true,
              ),
              scrollDirection: Axis.horizontal,
            ),
          ),
          SizedBox(height: 10),
          _listDate.length == 35 ? 
            Column(
              children: [
                if (widget.isFullMonth)
                    DateOnWeek(
                      toDoDate: _listDate,
                      week: 1,
                    )
                  else
                    for (int i = 0; i < 5; i++) DateOnWeek(
                      toDoDate: _listDate,
                      week: i,
                      ),
                  SizedBox(height: 20)
              ],
            )
          : Container(
              color: Colors.white,
              child: Center(
                child: Image.asset("assets/images/loader.gif"),
              ),
            ),
        ],
      ),
    );
  }
}
