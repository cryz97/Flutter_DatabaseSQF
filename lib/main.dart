import 'package:flutter/material.dart';
import 'package:flutter_database_sqlite_sqf/models/user.dart';
import 'package:flutter_database_sqlite_sqf/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

void main() async {

  var db = new DatabaseHelper();
  int saveduser = await db.saveUser(new User("Chris", "christian"));

  runApp(new MaterialApp(
    title: 'Database',
    home: new Home(),
  ));

}


class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Database"),
        centerTitle: true,

      ),
    );
  }
}
