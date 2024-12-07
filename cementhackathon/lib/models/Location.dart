// location.dart
class Location {
  final double longitude;
  final double latitude;
  final String region;

  Location({
    required this.longitude,
    required this.latitude,
    required this.region,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      longitude: json['longitude'].toDouble(),
      latitude: json['latitude'].toDouble(),
      region: json['region'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'longitude': longitude,
      'latitude': latitude,
      'region': region,
    };
  }
}
