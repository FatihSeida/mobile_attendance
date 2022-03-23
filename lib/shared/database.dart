import 'dart:developer';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseSqflite {
  openDB() async {
    try {
      final database = await openDatabase(
        join(await getDatabasesPath(), 'locations.db'),
        onCreate: (db, version) async {
          return await db.execute(
            '''CREATE TABLE locations(
            id INTEGER PRIMARY KEY AUTOINCREMENT, 
          name TEXT, 
          longitude DOUBLE, 
          latitude DOUBLE, 
          nameLocation TEXT, 
          longitudeLocation DOUBLE, 
          latitudeLocation DOUBLE)''',
          );
        },
        version: 1,
      );
      return database;
    } catch (e) {
      log(e.toString());
    }
  }
}
