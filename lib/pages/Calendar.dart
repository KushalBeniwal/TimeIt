import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutterapp/model/todo.dart';
//import 'package:flutterapp/services/todo_service.dart';
import 'package:flutterapp/pages/details.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';


class Calendar extends StatefulWidget{

  @override

  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  CalendarController _controller;
  //var _todoService = TodoService();


  @override

  initState() {
    super.initState();
    _controller = CalendarController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TableCalendar(
                //events: _todoList,
                headerStyle: HeaderStyle(
                  centerHeaderTitle: true,
                  formatButtonShowsNext: false,
                  formatButtonDecoration:
                  BoxDecoration(color: Colors.deepOrangeAccent),
                  formatButtonTextStyle: TextStyle(color: Colors.white),
                ),
                startingDayOfWeek: StartingDayOfWeek.monday,
                onDaySelected: (date, events) {
                  Navigator.push(
                    context, MaterialPageRoute(
                      builder: (context) => Details(DateFormat("dd-MM-yyyy").format(date).toString()),
                  )
                  );
                },


               builders: CalendarBuilders(
                  selectedDayBuilder: (context, date, events){
                      return Container(
                          margin: const EdgeInsets.all(4.0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.orange, shape: BoxShape.circle),
                          child: Text(date.day.toString(),
                              style: TextStyle(color: Colors.white)),

                      );},
                  todayDayBuilder: (context, date, events) =>
                      Container(
                          margin: const EdgeInsets.all(4.0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.indigo, shape: BoxShape.circle),
                          child: Text(date.day.toString(),
                            style: TextStyle(color: Colors.white),
                          )),
                ),
                calendarController: _controller,
              ),
            ],
          ),
        ),
    );
  }
}
