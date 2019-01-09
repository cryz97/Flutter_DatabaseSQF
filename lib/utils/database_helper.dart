
import 'dart:async';
import 'dart:io';

import 'package:flutter_database_sqlite_sqf/models/user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {

  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  static Database _db;

  final String tableUser = "userTable";
  final String columnId = "id";
  final String columnUsername = "username";
  final String columnPassword = "password";


  Future<Database> get db async {
    if(_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "maindb.db");

    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDb;

  }

  getApplicationDocumentsDirectory() async {

  }

  void _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE $tableUser($columnId INTEGER PRIMARY KEY,$columnUsername TEXT,$columnPassword TEXT)");
  }

  Future<int> saveUser(User user) async {
    var dbClient = await db;
    int res = await dbClient.insert("$tableUser", user.toMap());

    return res;
  }

  Future<List> getAllUsers() async {
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM $tableUser");

    return result.toList();
  }

  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(
      await dbClient.rawQuery("SELECT COUNT(*) FROM $tableUser"));
  }

  Future<User> getUser(int id) async {
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM $tableUser WHERE $columnId = $id");
    if(result.length == 0)
      return null;
    else
      return new User.fromMap(result.first);
  }

}