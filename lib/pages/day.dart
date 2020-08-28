import 'package:flutter/material.dart';
import 'package:flutterapp/model/todo.dart';
import 'package:flutterapp/services/todo_service.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class TimeBlockList extends StatefulWidget {
  @override
  _TimeBlockListState createState() => _TimeBlockListState();
}

class _TimeBlockListState extends State<TimeBlockList> {
  DateTime now = DateTime.now();

  var _todoService = TodoService();
  List<Todo> _todolist = List<Todo>();

  var check;

  Timer _timer;
  int _start = 100;

  Widget _timerIcon = Icon(Icons.timer, color: Colors.red);

  @override
  void initState() {
    super.initState();
    getAllTodo();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) => setState(() {
        _timerIcon = Container(
            child: Text(
          '${_start ~/ 60} : ${_start % 60}',
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(color: Colors.white),
        ));
        if (_start < 1) {
          timer.cancel();
        } else {
          _start = _start - 1;
        }
      }),
    );
  }

  Widget _getTile(BuildContext context, int index) {
    return Card(
      elevation: 5,
        child: GestureDetector(
            child: ListTile(
      leading: _todolist[index].checked == 0
          ? Icon(Icons.check_box_outline_blank)
          : Icon(Icons.check_box),
      title: _todolist[index].checked == 0
          ? Text(_todolist[index].task)
          : Text(
              _todolist[index].task,
              style: TextStyle(
                decoration: TextDecoration.lineThrough,
              ),
            ),
      subtitle: _todolist[index].priority == 'High'
          ? Text(
              _todolist[index].priority,
              style: TextStyle(color: Colors.red),
            )
          : _todolist[index].priority == 'Medium'
              ? Text(
                  _todolist[index].priority,
                  style: TextStyle(color: Colors.orange),
                )
              : _todolist[index].priority == 'Low'
                  ? Text(_todolist[index].priority,
                      style: TextStyle(color: Colors.yellow))
                  : null,
      trailing: _todolist[index].startTime != null
          ? GestureDetector(
              onTap: () {
                startTimer();
              },
              child: Icon(Icons.timer),
            )
          : null,
      onTap: () async {
        print(_todolist[index].checked);
        print(_todolist[index]
            .endTime
            .compareTo((DateFormat.Hm().format(DateTime.now())).toString()));
        check = await _todoService.updateChecked(
            _todolist[index].id,
            _todolist[index].checked == 0
                ? _todolist[index].checked = 1
                : _todolist[index].checked = 0);
        print(_todolist[index].checked);
        setState(() {});
      },
    )));
  }

  getAllTodo() async {
    _todolist = List<Todo>();
    var todos = await _todoService
        .readTodoByDate(DateFormat("dd-MM-yyyy").format(now).toString());
    todos.forEach((todo) {
      setState(() {
        var todoModel = Todo();
        todoModel.date = todo['date'];
        todoModel.task = todo['task'];
        todoModel.startTime = todo['start_Time'];
        todoModel.endTime = todo['end_Time'];
        todoModel.priority = todo['priority'];
        todoModel.id = todo['id'];
        todoModel.checked = todo['checked'];
        _todolist.add(todoModel);
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
//    print(DateFormat.Hm().format(DateTime.now()));
    return Scaffold(
        body: ListView.builder(
          itemCount: _todolist.length,
          itemBuilder: _getTile,
        )
    );
  }
}

