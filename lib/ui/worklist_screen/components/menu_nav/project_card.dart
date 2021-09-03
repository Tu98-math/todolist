import 'package:flutter/material.dart';
import 'package:to_do_list/constants/app_colors.dart';

class ProjectCard extends StatelessWidget {
  const ProjectCard({
    Key? key, 
    required this.task, 
    required this.title, 
    required this.press, 
    required this.indexColor,
  }) : super(key: key);

  final int task;
  final String title;
  final Function press;
  final int indexColor;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 6,
            vertical: 12
          ),
          child: InkWell(
            onTap: ()=> press(),
            child: Container (
              width: size.width * .5 - 22,
              height: size.height * .22,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(2,10),
                    color: Color(0xFFE3E3E3).withOpacity(.5),
                    blurRadius: 3
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 26,
                      height: 26,
                      decoration: BoxDecoration(
                        color: AppColors.kColorNote[indexColor].withOpacity(.3),
                        shape: BoxShape.circle
                      ),
                      child: Center(
                        child: Container(
                          width: 14,
                          height: 14,
                          decoration: BoxDecoration(
                            color: AppColors.kColorNote[indexColor],
                            shape: BoxShape.circle
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    SizedBox(height: 16),
                    Text("$task Task")
                  ],
                ),
              ),
            ),
          ),
        ),  
      ],
    );
  }
}