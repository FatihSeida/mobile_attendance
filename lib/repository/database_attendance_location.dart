import 'dart:developer';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AttendanceLocationDatabaseSqflite {
    openAttendanceLocationDB() async {
    try {
      final database = await openDatabase(
        join(await getDatabasesPath(), 'attendance_locations.db'),
        onCreate: (db, version) async {
          return await db.execute(
            '''CREATE TABLE attendance_locations(
            id INTEGER PRIMARY KEY AUTOINCREMENT, 
          nameLocation TEXT, 
          longitude DOUBLE, 
          latitude DOUBLE)''',
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
