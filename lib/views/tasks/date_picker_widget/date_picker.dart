import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;

import 'package:smart_todo/controllers/date_picker_controller.dart';

class DatePickerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRect(
        child: BackdropFilter(
            filter: ui.ImageFilter.blur(
              sigmaX: 5.0,
              sigmaY: 5.0,
            ),
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          //
                          final controller = Provider.of<DatePickerController>(
                              context,
                              listen: false);
                          controller.pickDate(context);
                        },
                        child: Consumer<DatePickerController>(
                            builder: (context, ctrl, widget) {
                          return Text(
                            "${ctrl.selectedMonth}",
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold)),
                          );
                        }),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Container(
                          child: SvgPicture.asset("assets/icons/arrow_down.svg",
                              height: 30)),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Consumer<DatePickerController>(
                    builder: (context, ctrl, widget) {
                      final listOfDates = ctrl.listOfDates;
                      return Container(
                          height: 70,
                          width: 400,
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemExtent: 70,
                              scrollDirection: Axis.horizontal,
                              itemCount: listOfDates.length,
                              itemBuilder: (context, index) {
                                return DatePickerDateItem(
                                  date: listOfDates[index],
                                );
                              }));
                    },
                  ),
                ],
              ),
            )));
  }
}

class DatePickerDateItem extends StatelessWidget {
  const DatePickerDateItem({Key? key, required this.date}) : super(key: key);

  final int date;

  @override
  Widget build(BuildContext context) {
    return Consumer<DatePickerController>(builder: (context, ctrl, widget) {
      final selectedDay = ctrl.selectedDay;
      return GestureDetector(
        onTap: () {
          Provider.of<DatePickerController>(context, listen: false)
              .onDateTap(date);
        },
        child: Container(
          decoration: BoxDecoration(
            color: selectedDay == date ? Colors.blueAccent : Colors.transparent,
            borderRadius: BorderRadius.circular(15),
          ),
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.all(5),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              "Day",
              style: GoogleFonts.roboto(
                  textStyle:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            Text(
              "${date.toString()}",
              style: GoogleFonts.roboto(textStyle: TextStyle(fontSize: 14)),
            ),
          ]),
        ),
      );
    });
  }
}
