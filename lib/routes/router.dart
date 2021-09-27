import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_todo/providers/base_controller.dart';
import 'package:smart_todo/views/ideas/ideas_page.dart';

import 'package:smart_todo/views/settings/settings_page.dart';
import 'package:smart_todo/views/tasks/task_home.dart';
import 'package:smart_todo/views/timer/timer_page.dart';

const String TASKSROUTE = '/tasks';
const String IDEASROUTE = '/ideas';

const String TIMERROUTE = '/timer';
const String SETTINGSROUTE = '/settings';

final navKey = GlobalKey<NavigatorState>();

Route<dynamic> mainRouteGenerator(
    BuildContext context, RouteSettings settings) {
  print('ROUTING TO ' + settings.name!);
  final base = Provider.of<BaseController>(context, listen: false);

  WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
    //base.setCurrentPageRoute(settings.name!);
  });
  switch (settings.name) {
    case TASKSROUTE:
      base.setCurrentBottomNavIndex(0);
      return MaterialPageRoute(builder: (_) => TaskHome());
    case IDEASROUTE:
      base.setCurrentBottomNavIndex(1);
      return MaterialPageRoute(builder: (_) => IdeasPage());
    case TIMERROUTE:
      base.setCurrentBottomNavIndex(2);
      return MaterialPageRoute(builder: (_) => TimerPage());
    case SETTINGSROUTE:
      base.setCurrentBottomNavIndex(3);
      return MaterialPageRoute(builder: (_) => SettingsPage());
    // case SETTINGS:
    //   //base.currentBottomNavIndex.value = 1;
    //   return MaterialPageRoute(
    //       builder: (_) => PaymentScreen(paymentId: settings.arguments));

    default:
      //base.currentBottomNavIndex.value = 0;
      return MaterialPageRoute(builder: (_) => TaskHome());
  }
}
