import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_stack/image_stack.dart';
import 'package:intl/intl.dart';
import 'package:smart_todo/controllers/task_controller.dart';

class TaskCard extends StatelessWidget {
  TaskCard({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;
  final List<Widget> imgWidgets = [
    SvgPicture.asset("assets/categories/creative.svg",
        height: 20, color: Colors.black87),
    SvgPicture.asset("assets/categories/edu.svg",
        height: 20, color: Colors.black87),
    SvgPicture.asset("assets/categories/ent.svg",
        height: 20, color: Colors.black87),
    SvgPicture.asset("assets/categories/sports.svg",
        height: 20, color: Colors.black87),
    SvgPicture.asset("assets/categories/work.svg",
        height: 20, color: Colors.black87)
  ];

  String getStartTime(DateTime date, TimeOfDay time) {
    final dt =
        DateTime(date.year, date.month, date.day, time.hour, time.minute);
    final format = DateFormat.jm(); //"6:00 AM"
    return format.format(dt);
  }

  String getEndTime(DateTime? date, TimeOfDay? time) {
    if (date != null && time != null) {
      final dt =
          DateTime(date.year, date.month, date.day, time.hour, time.minute);
      final format = DateFormat.jm(); //"6:00 AM"
      return format.format(dt);
    }
    return "...";
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Container(
        margin: EdgeInsets.only(top: 15),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: task.color.withOpacity(0.4),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  flex: 6,
                  child: Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${task.title}",
                          style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ),
                        Container(
                          child: Text(
                            "${task.description}",
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(fontSize: 16)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                            width: 50,
                            height: 50,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.purple,
                            ),
                            child: Icon(
                              Icons.note,
                              color: Colors.white,
                              size: 30,
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Divider(),
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Row(
                    //mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/clock.svg",
                        height: 20,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "${getStartTime(task.startDate, task.startTime)} - ${getEndTime(task.endDate, task.endTime)}",
                        style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    //mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ImageStack.widgets(
                        children: imgWidgets,
                        totalCount: imgWidgets.length,
                        widgetCount: 3,
                        backgroundColor: task.color,
                        widgetBorderColor: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
