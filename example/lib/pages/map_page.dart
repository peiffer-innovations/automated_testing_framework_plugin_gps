import 'dart:math';

import 'package:automated_testing_framework/automated_testing_framework.dart';
import 'package:automated_testing_framework_plugin_gps/automated_testing_framework_plugin_gps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class MapPage extends StatefulWidget {
  MapPage({
    Key? key,
  }) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final MapController _mapController = MapController();
  Position? _currentPosition;

  Future<void> _moveToMyLocation() async {
    var plugin = GpsPlugin();
    var permission = await plugin.requestPermission();

    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      var position = await plugin.currentLocation;

      _currentPosition = position;
      _mapController.move(
        LatLng(
          position.latitude,
          position.longitude,
        ),
        _mapController.zoom,
      );
    }
  }

  List<CircleMarker> _buildCurrentLocationMarkers() {
    var markers = <CircleMarker>[];

    if (_currentPosition != null) {
      var latLng = LatLng(
        _currentPosition!.latitude,
        _currentPosition!.longitude,
      );

      const radius = 6.0;
      markers.add(CircleMarker(
        color: Colors.blue.withAlpha(50),
        point: latLng,
        radius: _currentPosition!.accuracy,
        useRadiusInMeter: true,
      ));
      markers.add(CircleMarker(
        color: Colors.white,
        point: latLng,
        radius: radius + 2,
      ));
      markers.add(CircleMarker(
        color: Colors.blue,
        point: latLng,
        radius: radius,
      ));
    }

    return markers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map'),
      ),
      body: Stack(
        children: <Widget>[
          Testable(
            id: 'map',
            onRequestValue: () => [
              _currentPosition?.latitude,
              _currentPosition?.longitude,
            ],
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                center: LatLng(28.375891, -81.549410),
                zoom: 15.0,
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: [
                    'a',
                    'b',
                    'c',
                  ],
                ),
                CircleLayer(
                  circles: [
                    ..._buildCurrentLocationMarkers(),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 16.0,
            left: 16.0,
            child: Material(
              borderRadius: BorderRadius.circular(48.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Testable(
                    id: 'button_zoom_in',
                    child: IconButton(
                      onPressed: () => _mapController.move(
                        _mapController.center,
                        min(
                          18.0,
                          (_mapController.zoom + 1.0).toInt().toDouble(),
                        ),
                      ),
                      icon: Icon(
                        Icons.zoom_in,
                      ),
                    ),
                  ),
                  Testable(
                    id: 'button_zoom_out',
                    child: IconButton(
                      onPressed: () => _mapController.move(
                        _mapController.center,
                        max(
                          1.0,
                          (_mapController.zoom - 1.0).toInt().toDouble(),
                        ),
                      ),
                      icon: Icon(
                        Icons.zoom_out,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Testable(
        id: 'button_my_location',
        child: FloatingActionButton(
          onPressed: () => _moveToMyLocation(),
          child: Icon(
            Icons.my_location,
          ),
        ),
      ),
    );
  }
}
