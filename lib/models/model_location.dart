import 'dart:convert';

class Location {
  Location({
    required this.id,
    required this.nameLocation,
    required this.longitude,
    required this.latitude,
  });

  final int id;
  final String nameLocation;
  final double longitude;
  final double latitude;

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'nameLocation': nameLocation});
    result.addAll({'longitude': longitude});
    result.addAll({'latitude': latitude});

    return result;
  }

  @override
  String toString() {
    return '$id,$nameLocation,$longitude,$latitude';
  }

  factory Location.fromMap(Map<String, dynamic> map) {
    return Location(
      id: map['id'] ?? '',
      nameLocation: map['nameLocation'] ?? '',
      longitude: map['longitude']?.toDouble() ?? 0.0,
      latitude: map['latitude']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Location.fromJson(String source) =>
      Location.fromMap(json.decode(source));
}

List<Location> locations = [
  Location(
    id: 0,
    nameLocation: 'BHO',
    longitude: 107.713645,
    latitude: -6.9288032,
  ),
  Location(
    id: 1,
    nameLocation: 'Moal Comel',
    longitude: 107.7172905,
    latitude: -6.926974,
  ),
  Location(
    id: 2,
    nameLocation: 'Kosan Citra KDI',
    longitude: 107.7172949,
    latitude: -6.9267395,
  ),
  Location(
    id: 3,
    nameLocation: 'Ponpes Universal',
    longitude: 107.7168559,
    latitude: -6.9274293,
  ),
  Location(
    id: 4,
    nameLocation: 'Home',
    longitude: 107.7173267,
    latitude: -6.9269761,
  ),
];
