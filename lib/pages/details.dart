import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterapp/model/todo.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutterapp/pages/Calendar.dart';
import 'package:flutterapp/pages/dialog.dart';
import 'package:flutterapp/pages/pg2.dart';
import 'package:flutterapp/services/todo_service.dart';

class Details extends StatefulWidget {
  final String date;

  const Details(this.date, {Key key}) : super(key: key);

  @override
  DetailsState createState() => DetailsState();
}

class DetailsState extends State<Details> {
  TimeOfDay _time = TimeOfDay.now();
  TimeOfDay picked;
//  int selectedRadio;
//  var dropdownValue = 'Select';
//  var priority = ['Select', 'High', 'Medium', 'Low'];
//  int ind = 1;
  var _todoService = TodoService();
  var _todo = Todo();

//  var _taskController = TextEditingController();
  var _eventController1 = TextEditingController();
  var _eventController2 = TextEditingController();

  var _edittaskController = TextEditingController();
  var _editeventController1 = TextEditingController();
  var _editeventController2 = TextEditingController();

  var todo;
  List<Todo> _todolist = List<Todo>();

  Future<TimeOfDayFormat> selectStartTime(BuildContext context) async {
    picked = await showTimePicker(context: context, initialTime: _time);
    _eventController1.text = picked.toString().substring(10, 15);
    _editeventController1.text = picked.toString().substring(10, 15);

    setState(() {
      _time = picked;
      print(_time);
    });
  }

  Future<TimeOfDayFormat> selectEndTime(BuildContext context) async {
    picked = await showTimePicker(context: context, initialTime: _time);
    _eventController2.text = picked.toString().substring(10, 15);
    _editeventController2.text = picked.toString().substring(10, 15);

    setState(() {
      _time = picked;
      print(_time);
    });
  }

//  _showDialog(BuildContext context) async {
//    return showDialog(
//        context: context,
//        builder: (BuildContext buildContext) {
//          return Dialog(
//            shape:
//                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//            child: Container(
//              height: 500,
//              child: Padding(
//                padding: const EdgeInsets.all(8.0),
//                child: SingleChildScrollView(
//                  child: Column(
//                    children: <Widget>[
//                      Padding(
//                        padding: const EdgeInsets.all(20.0),
//                        child: TextFormField(
//                          controller: _taskController,
//                          decoration: InputDecoration(
//                              labelText: "Task",
//                              enabledBorder: OutlineInputBorder(
//                                borderSide: BorderSide(
//                                  color: Colors.blue,
//                                ),
//                              ),
//                              border: OutlineInputBorder(
//                                  borderRadius: BorderRadius.circular(10),
//                                  borderSide: BorderSide(color: Colors.blue))),
//                        ),
//                      ),
//                      myRadio(
//                          title: 'Any Time',
//                          value: 1,
//                          onChanged: (val) {
//                            setSelectedRadio(val);
//                          }
//                          //activeColor: Colors.blue,
//                          ),
//                      myRadio(
//                        title: 'Preferred Time',
////                              activeColor: Colors.blue,
//                        value: 0,
//
//                        onChanged: (val) {
//                          setSelectedRadio(val);
//                        },
//                      ),
//                      Row(
//                        children: <Widget>[
//                          Padding(
//                            padding: const EdgeInsets.all(10.0),
//                            child: Container(
//                              height: 50,
//                              width: 110,
//                              child: TextField(
//                                controller: _eventController1,
//                                decoration: InputDecoration(
//                                  labelText: "Start Time",
//                                  enabledBorder: OutlineInputBorder(
//                                      borderSide:
//                                          BorderSide(color: Colors.blue)),
//                                  border: OutlineInputBorder(
//                                    borderRadius: BorderRadius.circular(10.0),
//                                  ),
//                                ),
//                                onTap: () {
//                                  FocusScope.of(context)
//                                      .requestFocus(new FocusNode());
//
//                                  selectStartTime(context);
//                                },
//                              ),
//                            ),
//                          ),
//                          Padding(
//                            padding: const EdgeInsets.all(10.0),
//                            child: Container(
//                              height: 50,
//                              width: 110,
//                              child: TextField(
//                                controller: _eventController2,
//                                decoration: InputDecoration(
//                                  labelText: "End Time",
//                                  enabledBorder: OutlineInputBorder(
//                                      borderSide:
//                                          BorderSide(color: Colors.blue)),
//                                  border: OutlineInputBorder(
//                                    borderRadius: BorderRadius.circular(10.0),
//                                  ),
//                                ),
//                                onTap: () {
//                                  FocusScope.of(context)
//                                      .requestFocus(new FocusNode());
//
//                                  selectEndTime(context);
//                                },
//                              ),
//                            ),
//                          ),
//                        ],
//                      ),
//                      Row(
//                        children: <Widget>[
//                          Padding(
//                            padding: const EdgeInsets.all(8.0),
//                            child: Text(
//                              "Priority Level:",
//                              style: TextStyle(fontSize: 20),
//                            ),
//                          ),
//                          DropdownButton(
//                              value: ind,
//                              items: [
//                                DropdownMenuItem(
//                                  child: Text("High"),
//                                  value: 1,
//                                ),
//                                DropdownMenuItem(
//                                  child: Text("Medium"),
//                                  value: 2,
//                                ),
//                                DropdownMenuItem(child: Text("Low"), value: 3),
//                              ],
//                              onChanged: (value) {
//                                setState(() {
//                                  ind = value;
//                                });
//                              }),
//                        ],
//                      ),
//                      Center(
//                        child: Row(
//                          children: <Widget>[
//                            Padding(
//                              padding: const EdgeInsets.all(22.0),
//                              child: RaisedButton(
//                                child: Text("Save",
//                                    style: TextStyle(color: Colors.white)),
//                                color: Colors.blue,
//                                onPressed: () async {
//                                  var todoObject = Todo();
//                                  todoObject.date = widget.date;
//                                  todoObject.task = _taskController.text;
//                                  todoObject.startTime =
//                                      _eventController1.value.text;
//                                  todoObject.endTime =
//                                      _eventController2.value.text;
//                                  todoObject.priority = priority[ind];
//
//                                  var result =
//                                      await _todoService.saveTodo(todoObject);
//                                  print(result);
//
//                                  Navigator.of(context, rootNavigator: true)
//                                      .pop();
//                                  Fluttertoast.showToast(
//                                    msg: "Saved Successfully",
//                                    toastLength: Toast.LENGTH_SHORT,
//                                    gravity: ToastGravity.CENTER,
//                                  );
////                                          Navigator.of(context).pop(new MaterialPageRoute(builder: (context) =>))
//                                },
//                              ),
//                            ),
//                            Padding(
//                              padding: const EdgeInsets.all(22.0),
//                              child: RaisedButton(
//                                child: Text(
//                                  "Cancel",
//                                  style: TextStyle(color: Colors.white),
//                                ),
//                                color: Colors.blue,
//                                onPressed: () {
//                                  Navigator.of(context, rootNavigator: true)
//                                      .pop();
//                                },
//                              ),
//                            )
//                          ],
//                        ),
//                      ),
//                    ],
//                  ),
//                ),
//              ),
//            ),
//          );
//        }).then((value) => getAllTodo());
//  }

  @override
  void initState() {
    super.initState();

//    selectedRadio = 0;
    getAllTodo();

  }

//  setSelectedRadio(int val) {
//    setState(() {
//      selectedRadio = val;
//    });
//  }

  getAllTodo() async {
    _todolist = List<Todo>();
    var todos = await _todoService.readTodoByDate(widget.date);
    todos.forEach((todo) {
      setState(() {
        var todoModel = Todo();
        todoModel.date = todo['date'];
        todoModel.task = todo['task'];
        todoModel.startTime = todo['start_Time'];
        todoModel.endTime = todo['end_Time'];
        todoModel.priority = todo['priority'];
        todoModel.id = todo['id'];
        _todolist.add(todoModel);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Events"),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context, true);
              Navigator.push(
                  context, MaterialPageRoute(
                  builder: (context) => pg2(),
              )
              );
            },
            child: Icon(Icons.arrow_back),
          ),
        ),
        body: ListView.builder(
            itemCount: _todolist.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 8,
                child: Slidable(
                  delegate: SlidableDrawerDelegate(),
                  actionExtentRatio: 0.4,
                  child: Column(
                    children: <Widget>[
                      ListTile(
                leading: Icon(Icons.edit),

                        title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(_todolist[index].task),
                              Row(
                                children: [
                                  Text(_todolist[index].startTime.toString()), Text(" - "),
                                  Text(_todolist[index].endTime)
                                ],
                              )]
                      ),

                       subtitle: _todolist[index].priority == 'High' ? Text(_todolist[index].priority, style: TextStyle(color: Colors.red),)
                        : _todolist[index].priority == 'Medium' ? Text(_todolist[index].priority, style: TextStyle(color: Colors.orange),) :
                       _todolist[index].priority == 'Low' ? Text(_todolist[index].priority, style: TextStyle(color: Colors.yellow)) : null,
                      ),]

                  ),
                  secondaryActions: <Widget>[
                    IconSlideAction(
                      caption: 'Edit',
                      color: Colors.indigo,
                      icon: Icons.edit,
                      onTap: () {
                        editTodo(context, _todolist[index].id);
                      },
                    ),
                    IconSlideAction(
                      caption: 'Delete',
                      color: Colors.blue,
                      icon: Icons.delete,
                      onTap: () {
                        deleteDialog(context, _todolist[index].id);
                      },
                    ),
                  ],
                ),
              );
            }),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: (){
            Navigator.pop(context, true);
            Navigator.push(
                context, MaterialPageRoute(
                builder: (context) => DialogScreen(widget.date.toString()),
            )
            );
          }

        ));
  }

//  Widget myRadio({String title, int value, Function onChanged}) {
//    return RadioListTile(
//      value: value,
//      groupValue: selectedRadio,
//      onChanged: onChanged,
//      title: Text(title),
//      activeColor: Colors.blue,
//    );
//  }

  editTodo(BuildContext context, id) async {
    todo = await _todoService.readTodoById(id);
    setState(() {
      _edittaskController.text = todo[0]['task'] ?? 'No Task';
      _editeventController1.text = todo[0]['start_Time'] ?? 'No start time';
      _editeventController2.text = todo[0]['end_Time'] ?? 'No end time';
    });
    editDialog(context);
  }

  editDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: <Widget>[
              FlatButton(
                onPressed: () =>
                    Navigator.of(context, rootNavigator: true).pop(),
                child: Text('Cancel'),
              ),
              FlatButton(
                onPressed: () async {
                  _todo.id = todo[0]['id'];
                  _todo.date = widget.date;
                  _todo.task = _edittaskController.text;
                  _todo.startTime = _editeventController1.text;
                  _todo.endTime = _editeventController2.text;

                  var result = await _todoService.updateTodo(_todo);

                  if (result > 0) {
                    print(result);
                    Navigator.of(context, rootNavigator: true).pop();
                    getAllTodo();

                  }
                },
                child: Text("Save"),
              )
            ],
            title: Text("Edit Task"),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 100,
                    child: TextField(
                      controller: _edittaskController,
                      decoration: InputDecoration(labelText: 'Task'),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          height: 50,
                          width: 105,
                          child: TextField(
                            controller: _editeventController1,
                            decoration: InputDecoration(
                              labelText: "Start Time",
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue)),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            onTap: () {
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());

                              selectStartTime(context);
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          height: 50,
                          width: 105,
                          child: TextField(
                            controller: _editeventController2,
                            decoration: InputDecoration(
                              labelText: "End Time",
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue)),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            onTap: () {
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());

                              selectEndTime(context);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  deleteDialog(BuildContext context, id) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: <Widget>[
              FlatButton(
//              onPressed: ()=> Navigator.pop(context),
                onPressed: () =>
                    Navigator.of(context, rootNavigator: true).pop(),
                child: Text('Cancel'),
              ),
              FlatButton(
                onPressed: () async {
                  var result = await _todoService.deleteTodo(id);

                  if (result > 0) {
                    Navigator.of(context, rootNavigator: true).pop();
                    getAllTodo();
                  }
                },
                child: Text('Delete'),
              )
            ],
            title: Text("Are you sure to delete this task?"),
          );
        });
  }
}

