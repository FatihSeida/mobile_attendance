import 'dart:convert';

class UserAttendance {
  UserAttendance({
    required this.name,
    required this.longitude,
    required this.latitude,

    required this.nameLocation,
    required this.longitudeLocation,
    required this.latitudeLocation,
  });

  final String name;
  final double longitude;
  final double latitude;
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

  factory UserAttendance.fromMap(Map<String, dynamic> map) {
    return UserAttendance(
      name: map['name'] ?? '',
      longitude: map['longitude']?.toDouble() ?? 0.0,
      latitude: map['latitude']?.toDouble() ?? 0.0,
      nameLocation: map['nameLocation'] ?? '',
      longitudeLocation: map['longitudeLocation']?.toDouble() ?? 0.0,
      latitudeLocation: map['latitudeLocation']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserAttendance.fromJson(String source) =>
      UserAttendance.fromMap(json.decode(source));
}
