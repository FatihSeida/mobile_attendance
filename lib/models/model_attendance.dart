import 'dart:convert';

class Attendance {
  Attendance({
    required this.name,
    required this.longitude,
    required this.latitude,
    // required this.attendanceLocation,
    // required this.id,
    required this.nameLocation,
    required this.longitudeLocation,
    required this.latitudeLocation,
  });

  // final int id;
  final String name;
  final double longitude;
  final double latitude;
  // final Location attendanceLocation;
  final String nameLocation;
  final double longitudeLocation;
  final double latitudeLocation;
  


  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'name': name});
    result.addAll({'longitude': longitude});
    result.addAll({'latitude': latitude});
    result.addAll({'nameLocation': nameLocation});
    result.addAll({'longitudeLocation': longitudeLocation});
    result.addAll({'latitudeLocation': latitudeLocation});
  
    return result;
  }

  factory Attendance.fromMap(Map<String, dynamic> map) {
    return Attendance(
      name: map['name'] ?? '',
      longitude: map['longitude']?.toDouble() ?? 0.0,
      latitude: map['latitude']?.toDouble() ?? 0.0,
      nameLocation: map['nameLocation'] ?? '',
      longitudeLocation: map['longitudeLocation']?.toDouble() ?? 0.0,
      latitudeLocation: map['latitudeLocation']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Attendance.fromJson(String source) =>
      Attendance.fromMap(json.decode(source));
}
