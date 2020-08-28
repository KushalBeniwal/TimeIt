import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseConnection {
  setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    print('db path: '+directory.path);
    var path = join(directory.path, 'todos.db');
    var database = await openDatabase(path, version: 1, onCreate: _onCreatingDatabase);

    return database;
  }

  _onCreatingDatabase(Database database, int version) async {

    await database.execute('CREATE TABLE todos(id INTEGER PRIMARY KEY, date TEXT, task TEXT, start_Time TEXT, end_Time TEXT, priority TEXT, checked INTEGER)');

    await database.execute('CREATE TABLE templates(id INTEGER PRIMARY KEY, temps TEXT)');

  }
}
