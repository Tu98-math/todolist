import 'package:flutter/material.dart';
import 'package:to_do_list/constants/app_colors.dart';
import 'package:to_do_list/models/to_do_date_model.dart';

class DateOnWeek extends StatelessWidget {
  const DateOnWeek({
    Key? key,
    required this.week,
    required this.toDoDate,
  }) : super(key: key);
  final int week;
  final List<ToDoDateModel> toDoDate;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 40,
      child: ListView.builder(
        itemCount: 7,
        itemBuilder: (context, index) => MonthItem(
          text: toDoDate[index + week * 7].day.toString(),
          isTask: toDoDate[index + week * 7].isTask,
          isMonth: toDoDate[index + week * 7].isMonth,
        ),
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}

class MonthItem extends StatelessWidget {
  const MonthItem({
    Key? key,
    required this.text,
    this.isHeader = false,
    this.isTask = false,
    this.isMonth = true,
  }) : super(key: key);

  final String text;
  final bool isHeader, isTask, isMonth;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * .14,
      height: isHeader ? 25 : 40,
      child: Center(
        child: Column(
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: isHeader || !isMonth
                    ? AppColors.kDarkText
                    : AppColors.kText,
              ),
            ),
            isHeader
                ? SizedBox(height: 5)
                : Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      width: 5,
                      height: 5,
                      decoration: BoxDecoration(
                        color: isTask ? AppColors.kPrimaryColor : Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
