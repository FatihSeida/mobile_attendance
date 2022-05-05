import 'dart:convert';

class AttendanceLocation {
  AttendanceLocation({
    
    required this.nameLocation,
    required this.longitude,
    required this.latitude,
  });

  
  final String nameLocation;
  final double longitude;
  final double latitude;

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    result.addAll({'nameLocation': nameLocation});
    result.addAll({'longitude': longitude});
    result.addAll({'latitude': latitude});
    return result;
  }

  @override
  String toString() {
    return '$nameLocation,$longitude,$latitude';
  }

  factory AttendanceLocation.fromMap(Map<String, dynamic> map) {
    return AttendanceLocation(
      
      nameLocation: map['nameLocation'] ?? '',
      longitude: map['longitude']?.toDouble() ?? 0.0,
      latitude: map['latitude']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory AttendanceLocation.fromJson(String source) =>
      AttendanceLocation.fromMap(json.decode(source));
}
