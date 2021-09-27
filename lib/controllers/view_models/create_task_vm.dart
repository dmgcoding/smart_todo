import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_todo/controllers/task_controller.dart';

class CreateTaskVM extends ChangeNotifier {
  List<CategoryModel> _cats = [];

  void addCategory(CategoryModel cat) {
    //later should update categories controller/provider
    //all categories should be in a single class
    _cats.add(cat);
    notifyListeners();
  }

  //getters
  List<CategoryModel> get cats => _cats;
}
