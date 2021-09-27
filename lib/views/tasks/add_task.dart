import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:smart_todo/controllers/task_controller.dart';
import 'package:uuid/uuid.dart';

class CreateTask extends StatefulWidget {
  const CreateTask({Key? key}) : super(key: key);

  @override
  _CreateTaskState createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  late DateTime startDate;
  DateTime? endDate;
  late TimeOfDay startTime;
  TimeOfDay? endTime;

  final _titleController = new TextEditingController();
  final _categoryController = new TextEditingController();
  final _descController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    startDate = DateTime.now();
    startTime = TimeOfDay(hour: startDate.hour, minute: startDate.minute);
  }

  String getStartDateTime() {
    return "${startDate.year}/${startDate.month}/${startDate.day} - ${startTime.hour}:${startTime.minute}";
  }

  String getEndDateTime() {
    if (endDate == null || endTime == null) {
      return "click to set time";
    } else {
      return "${endDate!.year}/${endDate!.month}/${endDate!.day} - ${endTime!.hour}:${endTime!.minute}";
    }
  }

  void pickStartDateTime() async {
    final newDate = await showDatePicker(
        context: context,
        initialDate: startDate,
        firstDate: DateTime(startDate.year - 5),
        lastDate: DateTime(startDate.year + 5));

    if (newDate != null) startDate = newDate;

    final newTime =
        await showTimePicker(context: context, initialTime: startTime);

    if (newTime != null) startTime = newTime;

    setState(() {
      //
    });
  }

  void pickEndDateTime() async {
    final newDate = await showDatePicker(
        context: context,
        initialDate: startDate,
        firstDate: DateTime(startDate.year - 5),
        lastDate: DateTime(startDate.year + 5));

    if (newDate != null) endDate = newDate;

    final newTime =
        await showTimePicker(context: context, initialTime: startTime);

    if (newTime != null) endTime = newTime;

    setState(() {
      //
    });
  }

  void submit() {
    //create task object
    //pass it to the function
    final newTask = Task(
        id: Uuid().v4(),
        title: _titleController.text,
        description: _descController.text,
        categories: [],
        startDate: startDate,
        startTime: startTime,
        endDate: endDate,
        endTime: endTime,
        color: getRandomColor());

    final taskCtrl = Provider.of<TaskController>(context, listen: false);
    taskCtrl.addTask(newTask);
    Navigator.pop(context);
  }

  Color getRandomColor() {
    return Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.transparent,
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Spacer(),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.close)),
                  SizedBox(
                    width: 10,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Create Task",
                    style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Text(
                "Task title",
                style: GoogleFonts.roboto(
                    textStyle:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 15),
              Container(
                child: TextFormField(
                  controller: _titleController,
                  style: GoogleFonts.roboto(
                      textStyle:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  cursorColor: Colors.grey,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.redAccent),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.redAccent),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Category",
                style: GoogleFonts.roboto(
                    textStyle:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 10),
              Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.start,
                spacing: 10,
                children: [
                  CategoryCard(color: Colors.blue),
                  CategoryCard(color: Colors.pink),
                  CategoryCard(color: Colors.green),
                  CategoryCard(color: Colors.orange),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      width: 200,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: TextField(
                        controller: _categoryController,
                        decoration: InputDecoration(
                          hintText: "add new category",
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        "Add new category",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                            textStyle:
                                TextStyle(fontSize: 12, color: Colors.white)),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Starts",
                              style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                            ),
                            SizedBox(height: 10),
                            GestureDetector(
                              onTap: () {
                                pickStartDateTime();
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.only(right: 5),
                                width: 180,
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                        color: Colors.grey,
                                        width: 1,
                                        style: BorderStyle.solid)),
                                child: Text(
                                  getStartDateTime(),
                                  style: GoogleFonts.roboto(
                                      textStyle: TextStyle(
                                    fontSize: 16,
                                  )),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                  Expanded(
                      flex: 1,
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Ends",
                              style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                            ),
                            SizedBox(height: 10),
                            GestureDetector(
                              onTap: () {
                                pickEndDateTime();
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.only(left: 5),
                                width: 180,
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                        color: Colors.grey,
                                        width: 1,
                                        style: BorderStyle.solid)),
                                child: Text(
                                  getEndDateTime(),
                                  style: GoogleFonts.roboto(
                                      textStyle: TextStyle(
                                    fontSize: 16,
                                  )),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ))
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Description",
                style: GoogleFonts.roboto(
                    textStyle:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                child: TextFormField(
                  style: GoogleFonts.roboto(
                      textStyle:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  cursorColor: Colors.grey,
                  controller: _descController,
                  minLines: 3,
                  maxLines: 10,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.redAccent),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.redAccent),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    submit();
                  },
                  child: Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      "Create Task",
                      style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          )),
        ),
      ),
    );
  }
}

class CategoryCard extends StatefulWidget {
  CategoryCard({
    Key? key,
    required this.color,
  }) : super(key: key);

  final Color color;

  @override
  _CategoryCardState createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  bool tapped = false;

  ontap() {
    setState(() {
      tapped = !tapped;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ontap();
      },
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: tapped ? Colors.transparent : widget.color.withOpacity(0.4),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
                color: Colors.purple, width: 1, style: BorderStyle.solid)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset("assets/categories/creative.svg",
                height: 15, color: Colors.black87),
            Text(
              "All",
              style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                fontSize: 12,
              )),
            ),
          ],
        ),
      ),
    );
  }
}
