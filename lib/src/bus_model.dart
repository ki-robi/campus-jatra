// bus_model.dart
class Bus {
  final String name;
  final String route;
  final double latitude;
  final double longitude;
  final List<String> stoppages;

  Bus({
    required this.name,
    required this.route,
    required this.latitude,
    required this.longitude,
    required this.stoppages,
  });

  factory Bus.fromMap(Map<String, dynamic> data) {
    return Bus(
      name: data['name'] ?? '',
      route: data['route'] ?? '',
      latitude: data['latitude'] ?? 0.0,
      longitude: data['longitude'] ?? 0.0,
      stoppages: List<String>.from(data['stoppages'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'route': route,
      'latitude': latitude,
      'longitude': longitude,
      'stoppages': stoppages,
    };
  }
}