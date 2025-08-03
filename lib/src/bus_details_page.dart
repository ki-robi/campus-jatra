import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'bus_model.dart';

class BusDetailsPage extends StatefulWidget {
  final Bus bus;
  final bool showMap;

  const BusDetailsPage({super.key, required this.bus, required this.showMap});

  @override
  _BusDetailsPageState createState() => _BusDetailsPageState();
}

class _BusDetailsPageState extends State<BusDetailsPage> {
  Completer<GoogleMapController> _mapController = Completer();
  LatLng _currentPosition = const LatLng(0, 0);
  bool _loading = true;
  StreamSubscription<Position>? _positionStream;
  List<LatLng> _routePoints = [];
  String? _routeError;

  @override
  void initState() {
    super.initState();
    if (widget.showMap) {
      _checkPermissionsAndGetLocation();
    } else {
      setState(() => _loading = false);
    }
  }

  @override
  void dispose() {
    _positionStream?.cancel();
    super.dispose();
  }

  Future<void> _checkPermissionsAndGetLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() => _loading = false);
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() => _loading = false);
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() => _loading = false);
      return;
    }

    await _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
        _loading = false;
      });

      _positionStream = Geolocator.getPositionStream().listen((Position position) {
        if (mounted) {
          setState(() {
            _currentPosition = LatLng(position.latitude, position.longitude);
          });
          _fetchRoute();
        }
      });

      await _fetchRoute();

      final GoogleMapController controller = await _mapController.future;
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(widget.bus.latitude, widget.bus.longitude),
            zoom: 14,
          ),
        ),
      );
    } catch (e) {
      setState(() => _loading = false);
      debugPrint("Error getting location: $e");
    }
  }

  Future<void> _fetchRoute() async {
    final origin = '${_currentPosition.latitude},${_currentPosition.longitude}';
    final destination = '${widget.bus.latitude},${widget.bus.longitude}';
    final apiKey = 'AlzaSyCx10qvRhgY2575ZnLchGC2iTDfS5Airlc'; // Replace with your API key

    debugPrint('Origin: $origin, Destination: $destination');

    final url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=$origin&destination=$destination&mode=driving&key=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        debugPrint('Directions API response: $data');
        if (data['routes'] != null && data['routes'].isNotEmpty) {
          final points = data['routes'][0]['overview_polyline']['points'];
          setState(() {
            _routePoints = _decodePolyline(points);
            _routeError = null;
          });
        } else {
          debugPrint('No routes found in response');
          setState(() {
            _routePoints = [];
            _routeError = 'No route found between your location and the bus.';
          });
        }
      } else {
        debugPrint('Directions API error: ${response.statusCode}');
        setState(() {
          _routeError = 'Directions API error: ${response.statusCode}';
        });
      }
    } catch (e) {
      debugPrint('Error fetching route: $e');
      setState(() {
        _routeError = 'Error fetching route: $e';
      });
    }
  }

  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> poly = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      poly.add(LatLng(lat / 1E5, lng / 1E5));
    }
    return poly;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.bus.name,
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : widget.showMap
          ? _buildMapView(colorScheme)
          : _buildListView(colorScheme),
    );
  }

  Widget _buildMapView(ColorScheme colorScheme) {
    final busLatLng = LatLng(widget.bus.latitude, widget.bus.longitude);

    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition: CameraPosition(
            target: busLatLng,
            zoom: 14,
          ),
          onMapCreated: (controller) {
            _mapController.complete(controller);
          },
          markers: {
            Marker(
              markerId: const MarkerId('bus'),
              position: busLatLng,
              infoWindow: InfoWindow(
                title: widget.bus.name,
                snippet: widget.bus.route,
              ),
            ),
            Marker(
              markerId: const MarkerId('user'),
              position: _currentPosition,
              infoWindow: const InfoWindow(title: 'You'),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
            ),
          },
          polylines: _routePoints.isNotEmpty
              ? {
            Polyline(
              polylineId: const PolylineId('route'),
              color: colorScheme.primary,
              width: 5,
              points: _routePoints,
            ),
          }
              : {},
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
        ),
        if (_routeError != null)
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(12),
              color: Colors.red.withOpacity(0.8),
              child: Text(
                _routeError!,
                style: const TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildListView(ColorScheme colorScheme) {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.bus.route,
            style: GoogleFonts.poppins(
              fontSize: 23,
              fontWeight: FontWeight.w600,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(height: 35),
          Expanded(
            child: ListView.builder(
              itemCount: widget.bus.stoppages.length,
              itemBuilder: (context, index) {
                final isFirst = index == 0;
                final isLast = index == widget.bus.stoppages.length - 1;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: isFirst || isLast
                                  ? colorScheme.primary
                                  : Colors.transparent,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: colorScheme.primary,
                                width: 2,
                              ),
                            ),
                            child: Center(
                              child: Icon(
                                isFirst ? Icons.play_arrow :
                                isLast ? Icons.flag : Icons.circle,
                                size: 12,
                                color: isFirst || isLast
                                    ? Colors.white
                                    : colorScheme.primary,
                              ),
                            ),
                          ),
                          if (!isLast)
                            Container(
                              width: 2,
                              height: 24,
                              color: colorScheme.primary.withOpacity(0.2),
                            ),
                        ],
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.bus.stoppages[index],
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: isFirst || isLast
                                    ? FontWeight.w600
                                    : FontWeight.w500,
                              ),
                            ),
                            if (isFirst || isLast)
                              const SizedBox(height: 4),
                            if (isFirst || isLast)
                              Text(
                                isFirst ? 'Starting point' : 'Final destination',
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: colorScheme.onSurface.withOpacity(0.6),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}