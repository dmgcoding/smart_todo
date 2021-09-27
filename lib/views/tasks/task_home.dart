import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_todo/controllers/date_picker_controller.dart';
import 'package:smart_todo/controllers/task_controller.dart';

import 'task_card.dart';

class TaskHome extends StatelessWidget {
  const TaskHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Consumer<DatePickerController>(
            builder: (context, ctrl, child) {
              final sDate = ctrl.selectedDate;
              return Consumer<TaskController>(
                builder: (context, ctrl, child) {
                  final List<Task> tasks = ctrl.tasks;

                  List<Task> filteredTasks = [];
                  tasks.forEach((task) {
                    if (task.startDate.year == sDate.year &&
                        task.startDate.month == sDate.month &&
                        task.startDate.day == sDate.day) {
                      filteredTasks.add(task);
                    }
                  });
                  print(filteredTasks.length);

                  return Padding(
                    padding: EdgeInsets.all(15),
                    child: ListView.builder(
                      shrinkWrap: true,
                      //physics: NeverScrollableScrollPhysics(),
                      itemCount: filteredTasks.length,
                      itemBuilder: (context, index) {
                        return TaskCard(
                          task: filteredTasks[index],
                        );
                      },
                    ),
                  );
                },
              );
            },
          ),
          DatePickerWidget()
        ],
      ),
    );
  }
}
