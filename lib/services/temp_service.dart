import 'package:flutterapp/connections/repository.dart';
import 'package:flutterapp/model/templates.dart';

class TempService {
  Repository _repository;

  TempService() {
    _repository = Repository();
  }

  saveTemps(Templates temps) async {
    return await _repository.insertData('templates', temps.tempMap());
  }

  readTemps() async{
    return await _repository.readData('templates');
  }
}
