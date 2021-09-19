import 'dart:async';

import 'package:automated_testing_framework/automated_testing_framework.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

/// Plugin that allows for the simulation of testing with different locations
/// without having to actually move the device.  This also allows testing on
/// devices where a GPS chip may not exist.
///
/// This is a singleton.  All "new" instances are the same object reference.
class GpsPlugin with WidgetsBindingObserver {
  factory GpsPlugin() => _singleton;
  GpsPlugin._internal();

  static final GpsPlugin _singleton = GpsPlugin._internal();

  bool _initialized = false;
  StreamController<Position>? _locationStreamController =
      StreamController<Position>.broadcast();
  StreamSubscription? _locationSubscription;
  Position? _overriddenLocation;
  LocationPermission? _overriddenLocationPermission;
  TestController? _testController;

  /// Returns the current devices's position.  If overridden, this will return
  /// the overriden value.  Otherwise, it will return the value from the
  /// [Geolocator].
  Future<Position> get currentLocation => overriddenLocation == null
      ? Geolocator.getCurrentPosition()
      : Future.value(overriddenLocation);

  /// Returns whether the current permission state for the device.
  Future<LocationPermission> get locationPermission =>
      _overriddenLocationPermission == null
          ? Geolocator.checkPermission()
          : Future.value(_overriddenLocationPermission);

  /// Returns the overridden location.  If the location has not been overridden
  /// then this will return `null`.
  Position? get overriddenLocation => _overriddenLocation;

  /// Returns the stream that will fire with new positions whenever the device's
  /// location changes.
  Stream<Position> get onLocationChanged => _locationStreamController!.stream;

  /// Sets the overridden location.  Set to `null` to reset back to using the
  /// value from the device.
  set overriddenLocation(Position? location) {
    if (_testController == null && location != null) {
      throw Exception(
        'The location may not be overridden unless the plugin was initialized with a TestController.',
      );
    }
    _overriddenLocation = location;

    if (_overriddenLocation == null) {
      _overriddenLocationPermission = null;
    } else {
      _overriddenLocationPermission ??= LocationPermission.whileInUse;

      _locationStreamController?.add(_overriddenLocation!);
    }

    refresh();
  }

  set overriddenLocationPermission(LocationPermission? permission) {
    if (_testController == null && permission != null) {
      throw Exception(
        'The location permission may not be overridden unless the plugin was initialized with a TestController.',
      );
    }

    _overriddenLocationPermission = permission;
  }

  /// Called by the framework when the application launch state changes.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      refresh();
    }
  }

  /// Disposes the plugin, stops all streams, and stops all listeners.  Once
  /// disposed, this plugin cannot be used again until the application fully
  /// restarts.
  void dispose() {
    _overriddenLocation = null;
    _overriddenLocationPermission = null;

    _locationSubscription?.cancel();
    _locationSubscription = null;

    _locationStreamController?.close();
    _locationStreamController = null;

    _testController = null;
  }

  /// Initializes the plugin with an optional [TestController].  If the
  /// [TestController] is not set then this acts as nothing more than a wrapper
  /// to the [Geolocator].
  Future<void> initialize({
    TestController? testController,
  }) async {
    if (_initialized != true) {
      _testController = testController;
      _initialized = true;

      _locationStreamController!.onListen = () {
        if (_locationSubscription == null && _overriddenLocation == null) {
          _locationSubscription =
              Geolocator.getPositionStream().listen((position) {
            if (_overriddenLocation != null) {
              _locationStreamController?.add(position);
            }
          });
        }
      };

      _locationStreamController!.onCancel = () {
        if (_locationStreamController?.hasListener != true) {
          _locationSubscription?.cancel();
          _locationSubscription = null;
        }
      };

      await refresh();
    }
  }

  /// Returns the permission enum value for the given [value] string.
  LocationPermission getPermissionForString(String value) {
    LocationPermission result;

    switch (value) {
      case 'always':
        result = LocationPermission.always;
        break;

      case 'denied':
        result = LocationPermission.denied;
        break;

      case 'deniedForever':
        result = LocationPermission.deniedForever;
        break;

      case 'whileInUse':
        result = LocationPermission.whileInUse;
        break;

      default:
        throw Exception('Unknown expected permission string: $value');
    }
    return result;
  }

  /// Returns the permission string value for the given [value] permission.
  String getPermissionString(LocationPermission value) {
    String result;

    switch (value) {
      case LocationPermission.always:
        result = 'always';
        break;

      case LocationPermission.denied:
        result = 'denied';
        break;

      case LocationPermission.deniedForever:
        result = 'deniedForever';
        break;

      case LocationPermission.whileInUse:
        result = 'whileInUse';
        break;

      default:
        throw Exception('Unknown expected permission: $value');
    }
    return result;
  }

  Future<void> refresh() async {
    await _locationSubscription?.cancel();

    _locationSubscription = Geolocator.getPositionStream().listen((position) {
      if (_overriddenLocation != null) {
        _locationStreamController?.add(position);
      }
    });
  }

  void reset() {
    _overriddenLocation = null;
    _overriddenLocationPermission = null;
  }

  Future<LocationPermission> requestPermission() async {
    LocationPermission result;
    if (_overriddenLocationPermission == null) {
      result = await Geolocator.requestPermission();
    } else {
      result = _overriddenLocationPermission!;
    }

    return result;
  }
}
