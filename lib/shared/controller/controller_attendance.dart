import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:mobile_attendance/shared/database.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';

import '../../models/model_attendance.dart';

class ControllerAttendance extends GetxController {
  RxList<Attendance> locationAttendance = <Attendance>[].obs;
  final database = DatabaseSqflite().openDB();

  RxInt selectedLocation = 0.obs;
  RxDouble currentLocationLongitude = 0.00.obs;
  RxDouble currentLocationLatitude = 0.00.obs;
  RxList<double> distance = <double>[].obs;
  RxBool loading = false.obs;

  final name = TextEditingController();

  @override
  onInit() async {
    super.onInit();
    DatabaseSqflite().openDB();
    locations();
    getPermission();
  }

  @override
  void dispose() {
    name.dispose();
    Get.delete();
    super.dispose();
  }

  insertLocation({required Attendance location}) async {
    try {
      loading(true);
      final Database db = await database;
      await db.insert(
        'locations',
        location.toMap(),
      );
      update();
      locations();
      loading(false);
    } catch (e) {
      log(e.toString());
    }
  }

  locations() async {
    try {
      loading(true);
      final Database db = await database;
      final List<Map<String, dynamic>> maps = await db.query('locations');
      locationAttendance(RxList<Attendance>.generate(
          maps.length,
          (i) => Attendance(
                // id: maps[i]['id'],
                name: maps[i]['name'],
                longitude: maps[i]['longitude'],
                latitude: maps[i]['latitude'],
                latitudeLocation: maps[i]['latitudeLocation'],
                longitudeLocation: maps[i]['longitudeLocation'],
                nameLocation: maps[i]['nameLocation'],
              )).toList());
      distance(RxList<double>.generate(
          maps.length,
          (i) => GeolocatorPlatform.instance.distanceBetween(
                maps[i]['latitude'],
                maps[i]['longitude'],
                maps[i]['latitudeLocation'],
                maps[i]['longitudeLocation'],
              )).toList());
      loading(false);
      update();
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> updateLocation(Attendance location) async {
    final db = await database;
    await db.update(
      'locations',
      location.toMap(),
      where: "name = ?",
      whereArgs: [location.name],
    );
  }

  Future<void> deleteLocation(String name) async {
    final db = await database;

    await db.delete(
      'locations',
      where: "name = ?",
      whereArgs: [name],
    );
  }

  void manipulateDatabase(Attendance locationObject) async {
    await insertLocation(location: locationObject);
  }

  Future<void> getCurrentPosition() async {
    final hasPermission = await handlePermission();

    if (!hasPermission) {
      return;
    }
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentLocationLatitude.value = position.latitude;
    currentLocationLongitude.value = position.longitude;
  }

  Future<bool> handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    return true;
  }

  getPermission() async {
    if (await Permission.storage.request().isGranted) {
    } else {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.storage,
      ].request();
      log(statuses[Permission.location].toString());
    }
  }
}
