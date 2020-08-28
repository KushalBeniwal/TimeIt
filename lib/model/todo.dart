class Todo{
  int id;
  String date;
  String task;
  String startTime;
  String endTime;
  String priority;
  int checked;

  todoMap(){
    var mapping = Map<String, dynamic>();
    mapping['id'] = id;
    mapping['date'] = date;
    mapping['task'] = task;
    mapping['start_Time'] = startTime;
    mapping['end_Time'] = endTime;
    mapping['priority'] = priority;
    mapping['checked'] = checked;
    return mapping;
  }

}

