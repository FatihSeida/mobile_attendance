import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sqflite/sqflite.dart';

import '../../repository/database_attendance_location.dart';
import 'model_attendance_location.dart';

class ControllerAttendanceLocation extends GetxController {
  final attendanceLocationDatabase =
      AttendanceLocationDatabaseSqflite().openAttendanceLocationDB();

  Rx<Completer> mapsController = Completer().obs;
  RxList<Marker> allMarkers = <Marker>[].obs;
  RxList<String> markerName = <String>[].obs;
  RxBool loading = false.obs;
  RxInt selectedMarkerIndex = 0.obs;

  Rx<CameraPosition> kGooglePlex = const CameraPosition(
    target: LatLng(-6.9673128, 107.6671095),
    zoom: 14.4746,
  ).obs;

  final locationName = TextEditingController();

  @override
  onInit() async {
    super.onInit();
    await getCurrentMyPosition();
    getAttendancelocations();
  }

  @override
  void dispose() {
    locationName.dispose();
    super.dispose();
  }

  Future<void> getCurrentMyPosition() async {
    loading(true);
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    kGooglePlex = CameraPosition(
      target: LatLng(position.latitude, position.longitude),
      zoom: 14.4746,
    ).obs;
    loading(false);
  }

  Future<void> insertAttendanceLocation(
      {required AttendanceLocation location}) async {
    try {
      loading(true);
      final Database db = await attendanceLocationDatabase;
      await db.insert(
        'attendance_locations',
        location.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      getAttendancelocations();
      update();
      loading(false);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> getAttendancelocations() async {
    try {
      loading(true);
      final Database db = await attendanceLocationDatabase;
      final List<Map<String, dynamic>> maps =
          await db.query('attendance_locations');
      allMarkers(RxList<Marker>.generate(
              maps.length,
              (i) => Marker(
                  onTap: () {
                    selectedMarkerIndex.value = i;
                  },
                  markerId: MarkerId('${maps[i]['id']}'),
                  position: LatLng(maps[i]['latitude'], maps[i]['longitude']),
                  infoWindow: InfoWindow(title: maps[i]['nameLocation'])))
          .toList());
      markerName(RxList<String>.generate(allMarkers.length,
          (index) => allMarkers[index].infoWindow.title!)).toList();
      loading(false);
      update();
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> updateAttendanceLocation(AttendanceLocation location) async {
    final db = await attendanceLocationDatabase;
    await db.update(
      'attendance_locations',
      location.toMap(),
      where: "name = ?",
      whereArgs: [location.nameLocation],
    );
  }

  Future<void> deleteAttendanceLocation(String name) async {
    final db = await attendanceLocationDatabase;

    await db.delete(
      'attendance_locations',
      where: "nameLocation = ?",
      whereArgs: [name],
    );
  }

  Future<void> manipulateAttendanceLocationDatabase(
      AttendanceLocation locationObject) async {
    await insertAttendanceLocation(location: locationObject);
  }
}
