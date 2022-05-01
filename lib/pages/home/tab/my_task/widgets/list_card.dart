import 'package:flutter/material.dart';
import '/models/task_model.dart';

import '/constants/constants.dart';
import '/util/extension/extension.dart';
import '/util/ui/common_widget/task_card.dart';

class ListCard extends StatelessWidget {
  const ListCard({Key? key, required this.data}) : super(key: key);

  final List<TaskModel> data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < data.length; i++)
          if (i == 0 ||
              data[i - 1].dueDate.year != data[i].dueDate.year ||
              data[i - 1].dueDate.month != data[i].dueDate.month ||
              data[i - 1].dueDate.day != data[i].dueDate.day)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                toDateString(data[i].dueDate)
                    .plain()
                    .color(AppColors.kGrayTextA)
                    .b()
                    .pad(20, 0, 24, 10),
                TaskCard(task: data[i]),
              ],
            )
          else
            TaskCard(task: data[i]),
      ],
    );
  }
}
