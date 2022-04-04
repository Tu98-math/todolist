import 'package:flutter/material.dart';

import '/util/extension/widget_extension.dart';

class ToDaySwitch extends StatelessWidget {
  const ToDaySwitch({
    Key? key,
    this.isToDay = true,
    required this.press,
  }) : super(key: key);

  final bool isToDay;
  final Function press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        buildItem(size: size, text: 'To Day', isChoose: isToDay)
            .inkTap(onTap: () => press(true)),
        buildItem(size: size, text: 'Month', isChoose: !isToDay)
            .inkTap(onTap: () => press(false)),
      ],
    );
  }

  Container buildItem({
    required Size size,
    required String text,
    required bool isChoose,
  }) {
    return Container(
      width: size.width * .5,
      child: Column(
        children: [
          text
              .plain()
              .fSize(18)
              .color(Colors.white.withOpacity(isChoose ? 1 : .5))
              .weight(FontWeight.bold)
              .b()
              .pad(0, 0, 17, 14),
          Container(
            width: size.width * .256,
            height: 3,
            color: isChoose ? Colors.white : Colors.transparent,
          ),
        ],
      ),
    );
  }
}
