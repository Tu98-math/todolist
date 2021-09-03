import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChooseColorIcon extends StatelessWidget {
  const ChooseColorIcon({
    Key? key,
    this.tick = false,
    required this.index,
    required this.press,
  }) : super(key: key);
  final bool tick;
  final int index;
  final Function press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<int> _color = [
      0xFF6074F9,
      0xFFE42B6A,
      0xFF5ABB56,
      0xFF3D3A62,
      0xFFF4CA8F,
    ];
    return InkWell(
      onTap: () => press(index),
      child: Container(
        width: size.width * .12,
        height: size.width * .12,
        decoration: BoxDecoration(
            color: Color(_color[index]),
            borderRadius: BorderRadius.circular(5)),
        child: Center(
            child: SvgPicture.asset(
          "assets/icons/tick.svg",
          color: Colors.white.withOpacity(tick ? 1 : 0),
        )),
      ),
    );
  }
}
