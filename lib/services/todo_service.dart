import 'package:flutterapp/connections/repository.dart';
import 'package:flutterapp/model/todo.dart';

class TodoService{
  Repository _repository;

  TodoService(){
    _repository = Repository();
  }

  saveTodo(Todo todo) async{
    return await _repository.insertData('todos', todo.todoMap());
}

  readTodo(String date) async{
    return await _repository.readData('todos');
  }

  readTodoByDate(date) async {
    return await _repository.readDatabyDate('todos', date);
  }


  readTodoById(id) async {
    return await _repository.readDatabyId('todos', id);
  }

  updateTodo(Todo todo) async {
    return await _repository.updateTodo('todos', todo.todoMap());
  }

  deleteTodo(id) async {
    return await _repository.deleteData('todos', id);
  }

  updateChecked(id, value) async {
    return await _repository.updateChecked('todos', id, value);
  }
}
