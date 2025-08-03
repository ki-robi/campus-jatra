import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'bus_model.dart';

class BusProvider with ChangeNotifier {
  List<Bus> _buses = [];
  List<Bus> _filteredBuses = [];
  List<Bus> _recentSearches = [];
  bool _isLoading = false;


  List<Bus> get buses => _buses;
  List<Bus> get filteredBuses => _filteredBuses;
  List<Bus> get recentSearches => _recentSearches;
  bool get isLoading => _isLoading;

  final DatabaseReference _databaseRef = FirebaseDatabase.instance.ref("gps");

  Future<void> loadBuses() async {
    if (_isLoading) return;
    _isLoading = true;
    notifyListeners();

    try {
      // Fetch GPS data from Firebase Realtime Database
      final snapshot = await _databaseRef.get();

      if (snapshot.exists) {
        final data = snapshot.value as Map<dynamic, dynamic>;

        double latitude = data['latitude'];
        double longitude = data['longitude'];

        // Assign GPS coordinates to the bus
        _buses = [
          Bus(
            name: 'Projonmo-1',
            route: 'JnU to Khilgaon',
            latitude: latitude,
            longitude: longitude,
            stoppages: ['Khilgaon', 'Basabo', 'Buddha Mondir', 'Mugda', 'T.T Para', 'Maniknagar', 'Golapbagh', 'Doyaganj', 'JnU'],
          ),
          Bus(
            name: 'Projonmo-2',
            route: 'JnU to Malibagh',
            latitude: latitude,
            longitude: longitude,
            stoppages: ['Malibagh Super Market', 'Police Station', 'Mugda', 'Stadium', 'Maniknagar', 'South Kamalapur', 'Kamalapur', 'Arambagh', 'Madhumita', 'Tikatuli', 'JnU'],
          ),
          Bus(
            name: 'Ulka-1',
            route: 'JnU to Uttara',
            latitude: latitude,
            longitude: longitude,
            stoppages: ['Uttara (Azampur Bus Stand)', 'Kuril Biswaroad', 'Badda', 'Rampura', 'Malibagh', 'Paltan', 'Gulistan', 'JnU'],
          ),
          Bus(
            name: 'Ulka-2',
            route: 'JnU to Tongi',
            latitude: latitude,
            longitude: longitude,
            stoppages: ['Tongi Bridge', 'Airport', 'Banani', 'Mohakhali', 'Nabisko', 'Moghbazar Chowrasta', 'Malibagh', 'Kakrail', 'JnU'],
          ),
          Bus(
            name: 'Arial',
            route: 'JnU to Lohajang',
            latitude: latitude,
            longitude: longitude,
            stoppages: ['Louhajang', 'Holudia', 'Mawaghat Chowrasta', 'Sreenagar', 'Neemtola', 'Chunkuti', 'Babubazar Bridge', 'JnU'],
          ),
          Bus(
            name: 'Rajatrekha',
            route: 'JnU to Munshiganj',
            latitude: latitude,
            longitude: longitude,
            stoppages: ['Munshiganj Sadar', 'Supermarket', 'Ferighat', 'Muktarpur Bridge', 'Hathkhola', 'Panchaboti', 'Majdail', 'Signboard', 'JnU'],
          ),
          Bus(
            name: 'Gomoti',
            route: 'JnU to Cumilla',
            latitude: latitude,
            longitude: longitude,
            stoppages: ['Cumilla Police Lines', 'Cantonment', 'Nimsha', 'Chandina', 'Madaia', 'Eliotganj', 'Gouripur', 'Daudkandi', 'Bhoberchar', 'Meghna', 'Kachpur', 'Signboard', 'Jatrabari', 'JnU'],
          ),
          Bus(
            name: 'Ulka-3',
            route: 'JnU to Uttara Azampur',
            latitude: latitude,
            longitude: longitude,
            stoppages: ['Azampur', 'Airport', 'Khilkhet', 'Banani', 'Mohakhali', 'Tejgaon', 'Shatrasta', 'Moghbazar', 'JnU'],
          ),
          Bus(
            name: 'Anirban-1',
            route: 'JnU to Mirpur-12',
            latitude: latitude,
            longitude: longitude,
            stoppages: ['Mirpur-12', 'Mirpur-11', 'Mirpur-10', 'Kazipara', 'Taltola', 'Agargaon', 'Bijoy Sharani', 'Farmgate', 'Banglamotor', 'Shahbagh', 'Paltan', 'JnU'],
          ),
          Bus(
            name: 'Uttoron',
            route: 'JnU to Mirpur-14',
            latitude: latitude,
            longitude: longitude,
            stoppages: ['Mirpur-14', 'Mirpur-10', 'Mirpur-1', 'Technical', 'Shyamoli', 'Asadgate', 'New Market', 'Azimpur', 'JnU'],
          ),
          Bus(
            name: 'Durjoy',
            route: 'JnU to Kallyanpur',
            latitude: latitude,
            longitude: longitude,
            stoppages: ['Kallyanpur Bus Depo', 'Shyamoli', 'Asadgate', 'Mohammadpur Bus stand', 'Shankar', 'Jigatola', 'City College', 'New Market', 'Azimpur', 'JnU'],
          ),
          Bus(
            name: 'Shwapnil',
            route: 'JnU to Meghna',
            latitude: latitude,
            longitude: longitude,
            stoppages: ['Meghna Ghat', 'Modonpur Chowrasta', 'Kachpur Bridge', 'Chittagong Road', 'Signboard', 'Shonirakhra', 'Dhonia', 'Jatrabari', 'JnU'],
          ),
          Bus(
            name: 'Shwapnochura',
            route: 'JnU to Narayanganj',
            latitude: latitude,
            longitude: longitude,
            stoppages: ['Narayanganj', 'Chashara', 'Fatulla', 'Shyampur', 'Jatrabari', 'Saydabad', 'JnU'],
          ),
          Bus(
            name: 'Bongshi',
            route: 'JnU to Nobinagar',
            latitude: latitude,
            longitude: longitude,
            stoppages: ['Nobinagar', 'Savar Bus Stand', 'Hemayetpur', 'Gabtoli', 'Technical', 'Shyamoli', 'Kalabagan', 'Elephant Road', 'Bata Signal', 'Shabagh', 'Gulistan', 'JnU'],
          ),
          Bus(
            name: 'Chandramukhi-2',
            route: 'JnU to Khamarbari',
            latitude: latitude,
            longitude: longitude,
            stoppages: ['Khamarbari', 'Dhanmondi-27', 'Kalabagan', 'City College', 'Nilkhet', 'Azimpur', 'Polashi', 'Gulistan', 'JnU'],
          ),
          Bus(
            name: 'Oitijjho',
            route: 'JnU to Bhulta',
            latitude: latitude,
            longitude: longitude,
            stoppages: ['Bhulta', 'Borpa', 'Demra Chowrasta', 'Staff Quarter', 'Konapara', 'Jatrabari', 'Dholaikhal', 'JnU'],
          ),
          Bus(
            name: 'Uttoron-2',
            route: 'JnU to Mirpur-2',
            latitude: latitude,
            longitude: longitude,
            stoppages: ['Mirpur-2', 'Mirpur-1', 'Technical', 'Kallyanpur', 'Shyamoli', 'College Gate', 'Kalabagan', 'Science Lab', 'Shahbagh', 'Matsha Bhaban', 'Gulistan', 'JnU'],
          ),
          Bus(
            name: 'Bijoy-1',
            route: 'JnU to New Market',
            latitude: latitude,
            longitude: longitude,
            stoppages: ['New Market South Gate', 'Azimpur', 'Polashi', 'Shahid Minar', 'Gulistan', 'JnU'],
          ),
          Bus(
            name: 'Ulka-4',
            route: 'JnU to Airport',
            latitude: latitude,
            longitude: longitude,
            stoppages: ['Airport', 'Khilkhet', 'M.E.S', 'Banani', 'Mohakhali', 'Nabisko', 'Shatrasta', 'Moghbazar', 'Kakrail', 'Gulistan', 'JnU'],
          ),
          Bus(
            name: 'Dhumketu',
            route: 'JnU to Notun Bazar',
            latitude: latitude,
            longitude: longitude,
            stoppages: ['Notun Bazar', 'Link Road', 'Badda', 'Rampura TV Center', 'Rampura Bazar', 'Abul Hotel', 'Shantinagar', 'Kakrail', 'Gulistan', 'JnU'],
          ),
          Bus(
            name: 'Shwapnochura-2',
            route: 'JnU to Narayanganj',
            latitude: latitude,
            longitude: longitude,
            stoppages: ['Narayanganj(Chashara Shahid Minar)', 'Zilla Parishad', 'Shibu Market', 'Stadium', 'Jalkuri', 'Bhuigor', 'Signboard', 'Jatrabari', 'JnU'],
          ),
          Bus(
            name: 'Anirban',
            route: 'JnU to Mirpur-10',
            latitude: latitude,
            longitude: longitude,
            stoppages: ['Mirpur-10', 'Kazipara', 'Shewrapara', 'Taltola', 'Agargaon', 'Bijoy Sharani', 'Farmgate', 'Karwan Bazar', 'Banglamotor', 'Shahbagh', 'Matsha Bhaban', 'Gulistan', 'JnU'],
          ),
          Bus(
            name: 'Nongor',
            route: 'JnU to Narshingdi',
            latitude: latitude,
            longitude: longitude,
            stoppages: ['Etakhola', 'Bhelanagar', 'Pachdona', 'Madhobdi', 'Bhulta', 'Borpa', 'Tarabo Biswaroad', 'Jatrabari', 'JnU'],
          ),
          Bus(
            name: 'Padma',
            route: 'JnU to Dohar',
            latitude: latitude,
            longitude: longitude,
            stoppages: ['Dohar(Padma College)', 'Muksudpur School', 'Joypara Thana Mor', 'Nawabganj', 'Rohitpur', 'Ramerkanda', 'Kalindi', 'Jony Tower', 'Kadamtoli', 'Babu bazar', 'JnU'],
          ),
          Bus(
            name: 'Turag',
            route: 'JnU to Nobinagar',
            latitude: latitude,
            longitude: longitude,
            stoppages: ['Nobinagar', 'Savar Bus Stand', 'Bank Town', 'Hemayetpur', 'Gabtoli', 'Technical', 'Shyamoli', 'Asadgate', 'Kalabagan', 'New Market', 'Gulistan', 'JnU'],
          ),
          Bus(
            name: 'Kaliganga',
            route: 'JnU to Singair',
            latitude: latitude,
            longitude: longitude,
            stoppages: ['Singair', 'Joy Mandap', 'Bachta', 'Hemayetpur', 'Gabtoli', 'Mohammadpur Beribadh', 'Mohammadpur Bus stand', 'Jigatola', 'City College', 'Nilkhet', 'Gulistan', 'JnU'],
          ),
        ];
        _filteredBuses= List.from(_buses);
      }
    } catch (e) {
      print("Error loading GPS data: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void filterBuses(String query) {
    final filteredBuses = _buses.where((bus) {
      final busLower = bus.name.toLowerCase();
      final queryLower = query.toLowerCase();
      return busLower.contains(queryLower);
    }).toList();

    _filteredBuses = filteredBuses;
    _addRecentSearches(filteredBuses);
    notifyListeners();
  }

  void _addRecentSearches(List<Bus> buses) {
    _recentSearches = buses;
    notifyListeners();
  }
}

