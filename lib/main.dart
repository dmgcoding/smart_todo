import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_todo/base_widget.dart';
import 'package:smart_todo/providers/base_controller.dart';

import 'controllers/date_picker_controller.dart';
import 'controllers/task_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ListenableProvider<BaseController>(
              create: (context) => BaseController()),
          ListenableProvider<DatePickerController>(
              create: (context) => DatePickerController()),
              ListenableProvider<TaskController>(
              create: (context) => TaskController())
        ],
        child: MaterialApp(
          home: BaseWidget(),
        ));
  }
}
