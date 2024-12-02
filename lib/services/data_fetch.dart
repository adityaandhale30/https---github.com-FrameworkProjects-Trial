import 'package:sqlite_trial/model/time_table_model.dart';
import 'package:sqlite_trial/services/database_helper.dart';

Future<List<TimetableModel>> getTTData() async {
  final localDB = await DatabaseHelper.instance.database;

  List<Map<String, dynamic>> listTT = await localDB.query('timeTable');

  return List.generate(listTT.length, (i) {
    return TimetableModel(
      subjectName: listTT[i]['subjectName'],
      time: listTT[i]['time'],
      date: listTT[i]['date'],
    );
  });
}

List<TimetableModel> ttList = [];
