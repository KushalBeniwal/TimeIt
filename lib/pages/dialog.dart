import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/model/templates.dart';
import 'package:flutterapp/model/todo.dart';
import 'package:flutterapp/pages/details.dart';
import 'package:flutterapp/services/temp_service.dart';
import 'package:flutterapp/services/todo_service.dart';
import 'package:dropdownfield/dropdownfield.dart';


class DialogScreen extends StatefulWidget {
  final String date;

  const DialogScreen(this.date, {Key key}) : super(key: key);

  @override
  _DialogScreenState createState() => _DialogScreenState();
}

class _DialogScreenState extends State<DialogScreen> {

  String myTask;
  TimeOfDay _time = TimeOfDay.now();
  TimeOfDay picked;

  var _todoService = TodoService();
  var _tempService = TempService();

  var _taskController = TextEditingController();
  var _eventController1 = TextEditingController();
  var _eventController2 = TextEditingController();

  int selectedRadio;
  var dropdownValue = 'Select';
  var priority = ['Select', 'High', 'Medium', 'Low'];
  int ind = 1;

  List<Todo> _todolist = List<Todo>();
  List<String> _templist = ['Homework', 'Workout', 'Project Work', 'Class', 'Session', 'Reading', 'Meditation', 'Cooking'];
  //List <String> templates = ['Homework', 'Workout', 'Project Work', 'Class', 'Session', 'Reading', 'Meditation', 'Cooking'];

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

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

  getAllTemp() async {
    _templist = List<String>();
    var temps = await _tempService.readTemps();
    temps.forEach((temp) {
      setState(() {
        var tempModel = Templates();
        tempModel.temps = temp['temps'];
        _templist.add(tempModel.temps);
      });
    });
  }


  Widget myRadio({String title, int value, Function onChanged}) {
    return RadioListTile(
      value: value,
      groupValue: selectedRadio,
      onChanged: onChanged,
      title: Text(title),
      activeColor: Colors.blue,
    );
  }

  Future<TimeOfDayFormat> selectStartTime(BuildContext context) async {
    picked = await showTimePicker(context: context, initialTime: _time);
    _eventController1.text = picked.toString().substring(10, 15);
    //_editeventController1.text = picked.toString().substring(10, 15);

    setState(() {
      _time = picked;
      print(_time);
    });
  }

  Future<TimeOfDayFormat> selectEndTime(BuildContext context) async {
    picked = await showTimePicker(context: context, initialTime: _time);
    _eventController2.text = picked.toString().substring(10, 15);
   // _editeventController2.text = picked.toString().substring(10, 15);

    setState(() {
      _time = picked;
      print(_time);
    });
  }



  @override
  void initState(){
    super.initState();
    selectedRadio = 0;
    myTask = '';
    getAllTemp();
    print(_templist);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Task"),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context, true);
            Navigator.push(
                context, MaterialPageRoute(
              builder: (context) => Details(widget.date),
            )
            );
          },
          child: Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Container(
                  child: DropDownField(
                    controller: _taskController,
                    itemsVisibleInDropdown: 3,
                    value: myTask,
                    required: true,
                    strict: false,
                    labelText: 'Task',
                    items: _templist,
                  ),

                ),
              ),
            ),

            myRadio(
                title: 'Any Time',
                value: 1,
                onChanged: (val) {
                  setSelectedRadio(val);
                }

            ),
            myRadio(
              title: 'Preferred Time',
              value: 0,
              onChanged: (val) {
                setSelectedRadio(val);
              },
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    height: 50,
                    width: 110,
                    child: TextField(
                      controller: _eventController1,
                      decoration: InputDecoration(
                        labelText: "Start Time",
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.blue)),
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
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    height: 50,
                    width: 110,
                    child: TextField(
                      controller: _eventController2,
                      decoration: InputDecoration(
                        labelText: "End Time",
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.blue)),
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
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    "Priority Level:",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                DropdownButton(
                    value: ind,
                    items: [
                      DropdownMenuItem(
                        child: Text("High"),
                        value: 1,
                      ),
                      DropdownMenuItem(
                        child: Text("Medium"),
                        value: 2,
                      ),
                      DropdownMenuItem(child: Text("Low"), value: 3),
                    ],
                    onChanged: (value) {
                      setState(() {
                        ind = value;
                      });
                    }),
              ],
            ),
            SizedBox(height: 15,),
            Center(
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(22.0),
                    child: RaisedButton(
                      child: Text("Save",
                          style: TextStyle(color: Colors.white)),
                      color: Colors.blue,
                      onPressed: () async {
                        var tempObject = Templates();
                        tempObject.temps = _taskController.text;

                        var todoObject = Todo();
                        todoObject.date = widget.date;
                        todoObject.task = _taskController.text;
                        todoObject.startTime =
                            _eventController1.value.text;
                        todoObject.endTime =
                            _eventController2.value.text;
                        todoObject.priority = priority[ind];
                        todoObject.checked = 0;

                        var result =
                        await _todoService.saveTodo(todoObject);

                        var result2 = await _tempService.saveTemps(tempObject);
                        print(result);
                        print(result2);

                        Navigator.pop(context, true);
                        Navigator.push(
                            context, MaterialPageRoute(
                          builder: (context) => Details(widget.date.toString()),
                        )
                        );

//                         Navigator.of(context, rootNavigator: true).pop();
//                         Navigator.of(context).pop(new MaterialPageRoute(builder: (context) =>))
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(22.0),
                    child: RaisedButton(
                      child: Text(
                        "Cancel",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.blue,
                      onPressed: () {
                        Navigator.pop(context, true);
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

