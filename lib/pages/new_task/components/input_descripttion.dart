import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:to_do_list/constants/images.dart';

class InputDescription extends StatelessWidget {
  const InputDescription({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Description",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xFF9E9E9E),
            ),
          ),
          SizedBox(height: 12),
          Container(
            width: size.width,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              border: Border.all(
                color: Color(0xFFEAEAEA),
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: controller,
                    maxLines: 1,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Spacer(),
                Container(
                  width: size.width,
                  height: 48,
                  color: Color(0xFFF8F8F8),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: SvgPicture.asset(
                        AppImages.attachIcon,
                        width: 19,
                        height: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
