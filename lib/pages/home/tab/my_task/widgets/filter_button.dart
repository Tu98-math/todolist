import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:to_do_list/constants/app_colors.dart';
import 'package:to_do_list/constants/images.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return IconButton(
      //onPressed: () => showFilterDialog(context, size),
      onPressed: () {},
      icon: SvgPicture.asset(AppImages.filterIcon),
    );
  }

  void showFilterDialog(BuildContext context, Size size) => showGeneralDialog(
        barrierColor: AppColors.kBarrierColor,
        barrierDismissible: false,
        context: context,
        pageBuilder: (_, __, ___) {
          return Align(
            alignment: Alignment.topRight,
            child: Container(
              width: 300,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Text("Hihi"),
            ),
          );
        },
      );
}

class FilterItem extends StatelessWidget {
  const FilterItem({
    Key? key,
    required this.text,
    this.tick = false,
  }) : super(key: key);

  final String text;
  final bool tick;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 228,
      height: 43,
      child: Center(
        child: Row(
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
            Spacer(),
            SvgPicture.asset(
              AppImages.tickIcon,
              color: Color(0xFF7ED321).withOpacity(tick ? 1 : 0),
            )
          ],
        ),
      ),
    );
  }
}
