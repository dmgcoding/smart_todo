import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;

//WHAT'S IN HERE
//HOW TO SHOW DATEPICKER AND SET VALUES
//HOW TO GET TOTAL DAYS IN A MONTH

class DatePickerController extends ChangeNotifier {
  late DateTime _selectedDate;
  List<int> _listOfDates = [];
  int? _selectedDay;

  DatePickerController() {
    _selectedDate = DateTime.now();
    print(_selectedDate.day);
  }

  void pickDate(BuildContext context) async {
    ////HOW TO SHOW DATEPICKER AND SET VALUES
    final newDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(//date range to show in calendar
            _selectedDate.year - 5), //start date is 5 years before selDate;
        lastDate: DateTime(_selectedDate.year + 5)); //5 years after

    if (newDate != null)
      setSelectedDate(newDate); //if cancel newDate can be null. so check that

    int totalDays = _daysInMonth(_selectedDate);

    final listOfDates = new List<int>.generate(totalDays, (i) => i + 1);
    setListOfDays(listOfDates);
  }

  //HOW TO GET TOTAL DAYS IN A MONTH
  int _daysInMonth(DateTime date) {
    var firstDayThisMonth = new DateTime(date.year, date.month, date.day);
    var firstDayNextMonth = new DateTime(firstDayThisMonth.year,
        firstDayThisMonth.month + 1, firstDayThisMonth.day);
    return firstDayNextMonth
        .difference(firstDayThisMonth)
        .inDays; //DIFFERENCE BETWEEN 2 DATES IN DAYS
  }

  void onDateTap(int day) {
    final cdate = _selectedDate;
    final month = cdate.month;
    final year = cdate.year;

    final newDate = DateTime(year, month, day);
    setSelectedDate(newDate);
    setSelectedDay(newDate.day.toInt());

    // if (newDate.day.toInt() == day) {
    //   print("newDate.day.toInt(): ${newDate.day.toInt()}");
    // }
  }

  //setter
  void setSelectedDate(DateTime newDate) {
    _selectedDate = newDate;
    setSelectedDay(_selectedDate.day.toInt());
    notifyListeners();
  }

  void setListOfDays(List<int> listOfDays) {
    _listOfDates = listOfDays;
    notifyListeners();
  }

  void setSelectedDay(int day) {
    _selectedDay = day;

    notifyListeners();
  }

  ///getters
  DateTime get selectedDate => _selectedDate;
  List<int> get listOfDates => _listOfDates;
  int get selectedDay {
    if (_selectedDay == null) {
      _selectedDay = _selectedDate.day.toInt();
    }
    return _selectedDay!;
  }

  String get selectedMonth {
    return DateFormat.MMMM().format(_selectedDate);
  }
}

class DatePickerWidget extends StatelessWidget {
  // late DateTime selectedDate;
  // List<int> listOfDates = [];

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
