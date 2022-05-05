import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile_attendance/features/attendance_location/controller_attendance_location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';

import '../../repository/database_user_attendance.dart';
import 'model_user_attendance.dart';

class ControllerUserAttendance extends GetxController {
  final userAttendancedatabase =
      UserAttendanceDatabaseSqflite().openUserAttendanceDB();
  final name = TextEditingController();
  var attendanceLocation = Get.find<ControllerAttendanceLocation>();

  RxList<UserAttendance> userAttendance = <UserAttendance>[].obs;
  RxList<Marker> allMarkers =
      Get.find<ControllerAttendanceLocation>().allMarkers;
  RxList<double> distance = <double>[].obs;

  RxString selectedLocation = ''.obs;

  RxInt selectedIndexLocation = 0.obs;

  RxDouble currentLocationLongitude = 0.00.obs;
  RxDouble currentLocationLatitude = 0.00.obs;

  RxBool loading = false.obs;

  @override
  onInit() async {
    super.onInit();
    locations();
    getPermission();
  }

  void clearForm() {
    name.clear();
    currentLocationLatitude.value = 0.00;
    currentLocationLongitude.value = 0.00;
    selectedLocation.value = '';
    selectedIndexLocation.value = 0;
  }

  Future<void> insertLocation({required UserAttendance location}) async {
    try {
      loading(true);
      final Database db = await userAttendancedatabase;
      await db.insert(
        'locations',
        location.toMap(),
      );
      await locations();
      update();
      loading(false);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> locations() async {
    try {
      loading(true);
      final Database db = await userAttendancedatabase;
      final List<Map<String, dynamic>> maps = await db.query('locations');
      userAttendance(RxList<UserAttendance>.generate(
          maps.length,
          (i) => UserAttendance(
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
      update();
      loading(false);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> updateLocation(UserAttendance location) async {
    final db = await userAttendancedatabase;
    await db.update(
      'locations',
      location.toMap(),
      where: "name = ?",
      whereArgs: [location.name],
    );
  }

  Future<void> deleteLocation(String name) async {
    final db = await userAttendancedatabase;
    await db.delete(
      'locations',
      where: "name = ?",
      whereArgs: [name],
    );
  }

  Future<void> manipulateDatabase(UserAttendance locationObject) async {
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

  Future<void> getPermission() async {
    if (await Permission.storage.request().isGranted) {
    } else {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.storage,
      ].request();
      log(statuses[Permission.location].toString());
    }
  }
}
