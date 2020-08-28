import 'package:flutterapp/connections/database_connection.dart';
import 'package:sqflite/sqflite.dart';


class Repository {
  DatabaseConnection _databaseConnection;

  Repository(){
    _databaseConnection = DatabaseConnection();

  }
  static Database _database;

  Future<Database> get database async{
    if(_database != null) return _database;

    _database = await _databaseConnection.setDatabase();
    return _database;
  }

  insertData(table, data) async{
    var connection = await database;
    return await connection.insert(table, data);
  }

  readData(table) async {
    var connection = await database;
    return await connection.query(table);
  }

  readDatabyDate(table, date) async{
    var connection = await database;
    return await connection.query(table, where: 'date=?', whereArgs: [date]);
  }

  readDatabyId(table, id) async{
    var connection = await database;
    return await connection.query(table, where: 'id=?', whereArgs: [id]);
  }


  deleteData(table, id) async{
    var connection = await database;
    return await connection.rawDelete("DELETE from $table where id = $id");
  }

  updateTodo(table, data) async{
    var connection = await database;
    return await connection.update(table, data, where: 'id=?', whereArgs: [data['id']]);
  }

  updateChecked(table, id, value) async{
    var connection = await database;
    return await connection.rawUpdate("UPDATE $table SET checked = ${value} where id = $id");
  }
}
