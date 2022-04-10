import 'package:flutter/material.dart';
import 'package:to_do_list/constants/app_colors.dart';

class StatisticCard extends StatelessWidget {
  const StatisticCard({
    Key? key,
    required this.event,
    required this.toDo,
    required this.quickNote,
  }) : super(key: key);

  final double event, toDo, quickNote;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 24,
      ),
      child: Container(
        width: size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              offset: Offset(2, 10),
              blurRadius: 3,
              color: AppColors.kBoxShadow,
            )
          ],
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 16,
        ),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Statistic",
                style: TextStyle(
                  color: AppColors.kText,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StatisticIcon(
                    color: Color(0xFFF96060),
                    text: event.toStringAsFixed(2).substring(2, 4) + "%",
                    title: 'Event',
                  ),
                  StatisticIcon(
                    color: Color(0xFF6074F9),
                    text: toDo.toStringAsFixed(2).substring(2, 4) + "%",
                    title: 'To do',
                  ),
                  StatisticIcon(
                    color: Color(0xFF8560F9),
                    text: quickNote.toStringAsFixed(2).substring(2, 4) + "%",
                    title: 'Quick Note',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StatisticIcon extends StatelessWidget {
  const StatisticIcon({
    Key? key,
    required this.color,
    required this.text,
    required this.title,
  }) : super(key: key);

  final Color color;
  final String text, title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 21, bottom: 14),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              border: Border.all(
                color: Color(0xFFE8E8E8),
                width: 1,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                    color,
                    BlendMode.srcIn,
                  ),
                  image: AssetImage(
                    "assets/images/statistic.png",
                  ),
                ),
              ),
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 14),
          Text(
            title,
            style: TextStyle(
              color: AppColors.kText,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
