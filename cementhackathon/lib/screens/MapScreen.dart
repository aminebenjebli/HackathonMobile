import 'dart:math';

import 'package:cement_flutter/components/SideBar.dart';
import 'package:cement_flutter/core/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cement',
              style: TextStyle(fontSize: 24)), // Title of the application
        ),
        drawer: Drawer(
          width: MediaQuery.of(context).size.width * 0.6,
          child: const Sidebar(
            avatarUrl: 'assets/images/logo.png',
            cityName: 'Tunis',
            userName: 'Habib',
          ),
        ),
        body: const SmartBinsMap(),
      ),
    );
  }
}

class SmartBinsMap extends StatefulWidget {
  const SmartBinsMap({super.key});

  @override
  _SmartBinsMapState createState() => _SmartBinsMapState();
}

class _SmartBinsMapState extends State<SmartBinsMap> {
  LatLng userLocation = const LatLng(36.7783, -119.4179);

  final int numBins = 10;
  final double radiusInKm = 2.0;
  List<Marker> binMarkers = [];

  LocationData? _currentLocation;
  final Location _locationService = Location();
  late MapController _mapController;
  bool isMapInitialized = false;

  // Updated data with status field
  final List<Map<String, dynamic>> tunisiaEntities = [
    {'region': 'Tunis', 'lat': 36.8065, 'long': 10.1815, 'status': 'active'},
    {'region': 'Sfax', 'lat': 34.7406, 'long': 10.7603, 'status': 'inactive'},
    {'region': 'Sousse', 'lat': 35.8256, 'long': 10.6084, 'status': 'active'},
    {'region': 'Bizerte', 'lat': 37.2767, 'long': 9.8739, 'status': 'inactive'},
    {'region': 'Nabeul', 'lat': 36.4566, 'long': 10.7387, 'status': 'active'},
    // Add more places with status here
  ];

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _getLocation().then((locationData) {
      if (locationData != null) {
        setState(() {
          userLocation =
              LatLng(locationData.latitude!, locationData.longitude!);
          binMarkers = generateEntityMarkers(tunisiaEntities);
        });
        if (isMapInitialized) {
          _mapController.move(userLocation, 13.0);
        }
      }
    });
  }

  Future<LocationData?> _getLocation() async {
    try {
      bool serviceEnabled;
      PermissionStatus permissionGranted;

      serviceEnabled = await _locationService.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await _locationService.requestService();
        if (!serviceEnabled) throw Exception("Location services are disabled.");
      }

      permissionGranted = await _locationService.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await _locationService.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          throw Exception("Location permissions are denied.");
        }
      }

      _currentLocation = await _locationService.getLocation();
      return _currentLocation;
    } catch (e) {
      return null;
    }
  }

  List<Marker> generateEntityMarkers(List<Map<String, dynamic>> entities) {
    final markers = <Marker>[];

    for (var entity in entities) {
      Color markerColor =
          entity['status'] == 'active' ? Colors.blue : Colors.grey;

      markers.add(
        Marker(
          width: 50.0,
          height: 50.0,
          point: LatLng(entity['lat'], entity['long']),
          child: GestureDetector(
            onTap: () {
              // Action when marker is tapped
              Navigator.pushNamed(context, Routes.CreateVisitPage);
            },
            child: Icon(
              Icons.location_on,
              color: markerColor,
              size: 30,
            ),
          ),
        ),
      );
    }

    return markers;
  }

  List<Marker> generateRandomBinMarkers(
      LatLng center, int count, double radiusKm) {
    final random = Random();
    final markers = <Marker>[];

    for (int i = 0; i < count; i++) {
      final angle = random.nextDouble() * 2 * pi;
      final distance = random.nextDouble() * radiusKm;

      final latOffset = distance / 110.574;
      final lonOffset = distance / (111.32 * cos(center.latitude * pi / 180));

      final randomLat = center.latitude + latOffset * cos(angle);
      final randomLon = center.longitude + lonOffset * sin(angle);

      markers.add(
        Marker(
          width: 50.0,
          height: 50.0,
          point: LatLng(randomLat, randomLon),
          child: GestureDetector(
            onTap: () {
              // Action when bin marker is tapped
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text('Tapped on Bin'),
                  content: Text(
                      'You tapped on a bin marker at ($randomLat, $randomLon)'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Close'),
                    ),
                  ],
                ),
              );
            },
            child: const Icon(
              Icons.delete,
              color: Colors.red,
              size: 30,
            ),
          ),
        ),
      );
    }

    return markers;
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        onMapReady: () {
          isMapInitialized = true;
          _mapController.move(userLocation, 13.0);
        },
        initialCenter: userLocation,
        initialZoom: 13.0,
      ),
      children: [
        TileLayer(
          urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
          userAgentPackageName: 'com.example.app',
        ),
        MarkerLayer(
          markers: binMarkers,
        ),
      ],
    );
  }
}
