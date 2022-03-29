import 'package:flutter/material.dart';

class WorkListNav extends StatelessWidget {
  const WorkListNav({
    Key? key,
    required this.isToDay,
    required this.press,
  }) : super(key: key);

  final bool isToDay;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        WorkListNavItem(
          text: "Today",
          isTarget: isToDay ? true : false,
          press: press,
        ),
        WorkListNavItem(
          text: "Month",
          isTarget: !isToDay ? true : false,
          press: press,
        ),
      ],
    );
  }
}

class WorkListNavItem extends StatelessWidget {
  const WorkListNavItem({
    Key? key,
    required this.text,
    this.isTarget = false,
    required this.press,
  }) : super(key: key);

  final String text;
  final bool isTarget;
  final Function press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () => press(text),
      child: Container(
        width: size.width * .5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              text,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                  color: Colors.white.withOpacity(isTarget ? 1 : .5)),
            ),
            SizedBox(height: 14),
            Container(
              width: 96,
              height: 3,
              color: Colors.white.withOpacity(isTarget ? 1 : 0),
            )
          ],
        ),
      ),
    );
  }
}
