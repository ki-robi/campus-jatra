// bus_service.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'bus_model.dart';

class BusService {
  final DatabaseReference _database = FirebaseDatabase.instance.ref().child('gps');

  Stream<List<Bus>> fetchBuses() {
    return _database.onValue.map((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>;
      return data.values.map((value) => Bus.fromMap(value as Map<String, dynamic>)).toList();
    });
  }

  Stream<Map<String, Map<String, double>>> fetchAllBusLocations() {
    return _database.onValue.map((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>;
      return data.map((key, value) {
        final gpsData = value['gps'] as Map<dynamic, dynamic>;
        return MapEntry(key as String, {
          'latitude': gpsData['latitude'] as double,
          'longitude': gpsData['longitude'] as double,
        });
      });
    });
  }
}