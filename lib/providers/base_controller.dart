import 'package:flutter/cupertino.dart';
import 'package:smart_todo/utils/utils.dart';

class BaseController extends ChangeNotifier {
  int _currentBottomNavIndex = 0;
  String _currentPageRoute = Utils.baseRoute;

  //getter
  int get currentBottomNavIndex => _currentBottomNavIndex;
  String get currentPageRoute => _currentPageRoute;

  //setters
  setCurrentBottomNavIndex(int index) {
    _currentBottomNavIndex = index;
    notifyListeners();
  }

  setCurrentPageRoute(String route) {
    _currentPageRoute = route;
    notifyListeners();
  }
}
