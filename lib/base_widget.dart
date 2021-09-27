import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:smart_todo/providers/base_controller.dart';
import 'package:smart_todo/routes/router.dart';
import 'package:smart_todo/utils/utils.dart';
import 'package:smart_todo/views/tasks/add_task.dart';

class BaseWidget extends StatelessWidget {
  BaseWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Container(
        child: Navigator(
          key: navKey,
          onGenerateRoute: (RouteSettings settings) =>
              mainRouteGenerator(context, settings),
          initialRoute: Utils.baseRoute,
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: CustomBottomNavBar(),
        backgroundColor: Colors.blue,
        elevation: 2,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

//custom nav bar

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int currentIndex =
        Provider.of<BaseController>(context).currentBottomNavIndex;
    return Container(
      decoration: BoxDecoration(
        //color: Colors.white.withOpacity(0.4),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          BottomNavIcon(
            icon: "assets/icons/tasks.svg",
            color: currentIndex == 0 ? Colors.black87 : Colors.white,
            route: TASKSROUTE,
          ),
          BottomNavIcon(
            icon: "assets/icons/idea.svg",
            color: currentIndex == 1 ? Colors.black87 : Colors.white,
            route: IDEASROUTE,
          ),
          OpenContainer(
            transitionType: ContainerTransitionType.fade,
            transitionDuration: const Duration(seconds: 1),
            openBuilder: (context, _) => const CreateTask(),
            closedElevation: 0,
            closedShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
                side: const BorderSide(width: 0, color: Colors.transparent)),
            closedColor: Colors.purple,
            closedBuilder: (context, openContainer) => Container(
              margin: EdgeInsets.all(10),
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.purple,
              ),
              child: Icon(Icons.add),
            ),
          ),
          BottomNavIcon(
            icon: "assets/icons/clock.svg",
            color: currentIndex == 2 ? Colors.black87 : Colors.white,
            route: TIMERROUTE,
          ),
          BottomNavIcon(
            icon: "assets/icons/settings.svg",
            color: currentIndex == 3 ? Colors.black87 : Colors.white,
            route: SETTINGSROUTE,
          ),
        ],
      ),
    );
  }
}

class BottomNavIcon extends StatelessWidget {
  final String icon;
  final Color color;
  final String route;
  const BottomNavIcon({
    Key? key,
    required this.icon,
    required this.color,
    required this.route,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navKey.currentState!.pushReplacementNamed(route);
      },
      child: Container(
          margin: EdgeInsets.all(10),
          width: 20,
          height: 20,
          child: SvgPicture.asset(
            icon,
            color: color,
          )),
    );
  }
}
