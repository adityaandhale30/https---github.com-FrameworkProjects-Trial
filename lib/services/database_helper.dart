
import 'package:path/path.dart' as paths;

import 'package:sqflite/sqflite.dart';
import 'package:sqlite_trial/model/time_table_model.dart';

class DatabaseHelper {
static const _databaseName = 'my_database.db';
static const _databaseVersion = 1;

DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;
   // Open the database
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = paths.join(dbPath, _databaseName);

    return await openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE timeTable(
        subjectName TEXT NOT NULL,
        date TEXT NOT NULL,
        time TEXT NOT NULL
      )
    ''');
  }
  // Insert an item
  Future<int> insert(TimetableModel tt) async {
    Database db = await instance.database;
    return await db.insert("timeTable", tt.timeMap());
  }



}
