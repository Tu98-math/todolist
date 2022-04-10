import 'package:flutter/material.dart';
import 'package:to_do_list/constants/app_colors.dart';
import 'package:to_do_list/constants/constants.dart';

class ListCountTaskCard extends StatelessWidget {
  const ListCountTaskCard({
    Key? key,
    required this.event,
    required this.task,
    required this.quickNote,
  }) : super(key: key);

  final int event, task, quickNote;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        height: 110,
        child: ListView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            CountTaskCard(
              title: "Events",
              task: event,
              backgroundColor: Color(0xFFF96060),
            ),
            CountTaskCard(
              title: "To do Task",
              task: task,
              backgroundColor: Color(0xFF6074F9),
            ),
            CountTaskCard(
              title: "Quick Notes Task",
              task: quickNote,
              backgroundColor: Color(0xFF8560F9),
            ),
          ],
        ),
      ),
    );
  }
}

class CountTaskCard extends StatelessWidget {
  const CountTaskCard({
    Key? key,
    required this.title,
    required this.task,
    required this.backgroundColor,
  }) : super(key: key);

  final String title;
  final int task;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        width: 180,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 24,
            left: 24,
          ),
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'AvenirNextRoundedPro',
                color: Colors.white,
              ),
              children: [
                TextSpan(
                  text: "$title\n",
                ),
                TextSpan(
                  text: "$task Tasks",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(5),
          boxShadow: AppConstants.kBoxShadow,
        ),
      ),
    );
  }
}
