import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaskController extends ChangeNotifier {
  List<Task> _tasks = [];
  List<Task> _tasksOfDay = [];

  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  //getters
  List<Task> get tasks => _tasks;
  List<Task> get tasksOfDay => _tasksOfDay;
}

class Task {
  final String id;
  String title;
  String? description;
  List<CategoryModel> categories;
  DateTime startDate;
  TimeOfDay startTime;
  DateTime? endDate;
  TimeOfDay? endTime;
  final Color color;

  Task(
      {required this.id,
      required this.title,
      this.description,
      required this.categories,
      required this.startDate,
      required this.startTime,
      this.endDate,
      this.endTime,
      required this.color});
}

class CategoryModel {
  final int id;
  final String name;
  final Color color;

  CategoryModel({required this.id, required this.name, required this.color});
}
