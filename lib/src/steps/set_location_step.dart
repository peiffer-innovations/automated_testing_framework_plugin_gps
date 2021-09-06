import 'package:automated_testing_framework/automated_testing_framework.dart';
import 'package:automated_testing_framework_plugin_gps/automated_testing_framework_plugin_gps.dart';
import 'package:geolocator/geolocator.dart';
import 'package:json_class/json_class.dart';

/// Set's the device's location status.  As a note, this will not actually
/// change the location as reported by the device.  Instead, it sets the value
/// on the [GpsPlugin].  Applications would need to use that plugin to allow
/// for location based testing.
class SetLocationStep extends TestRunnerStep {
  SetLocationStep({
    required this.latitude,
    required this.longitude,
  }) : assert(latitude.isNotEmpty == true);

  static const id = 'set_location';

  static List<String> get behaviorDrivenDescriptions => List.unmodifiable([
        "set the device's location override to `[{{latitude}}, {{longitude}}]`.",
      ]);

  final String latitude;
  final String longitude;

  @override
  String get stepId => id;

  /// Creates an instance from a JSON-like map structure.  This expects the
  /// following format:
  ///
  /// ```json
  /// {
  ///   "latitude": <double>,
  ///   "longitude": <double>
  /// }
  /// ```
  static SetLocationStep fromDynamic(dynamic map) {
    SetLocationStep result;

    if (map == null) {
      throw Exception('[SetLocationStep.fromDynamic]: map is null');
    } else {
      result = SetLocationStep(
        latitude: map['latitude']!.toString(),
        longitude: map['longitude']!.toString(),
      );
    }

    return result;
  }

  /// Sets the location value to the [GpsPlugin].
  @override
  Future<void> execute({
    required CancelToken cancelToken,
    required TestReport report,
    required TestController tester,
  }) async {
    var latitude =
        JsonClass.parseDouble(tester.resolveVariable(this.latitude))!;
    var longitude =
        JsonClass.parseDouble(tester.resolveVariable(this.longitude))!;

    var name = "$id('$latitude, $longitude')";

    log(
      name,
      tester: tester,
    );

    GpsPlugin().overriddenLocation = Position(
      latitude: latitude,
      longitude: longitude,
      timestamp: DateTime.now(),
      accuracy: 1.0,
      altitude: 1.0,
      heading: 0.0,
      speed: 0.0,
      speedAccuracy: 0.0,
    );
  }

  @override
  String getBehaviorDrivenDescription(TestController tester) {
    var result = behaviorDrivenDescriptions[0];

    result = result.replaceAll('{{latitude}}', latitude);
    result = result.replaceAll('{{longitude}}', longitude);

    return result;
  }

  /// Overidden to ignore the delay
  @override
  Future<void> preStepSleep(Duration duration) async {}

  /// Overidden to ignore the delay
  @override
  Future<void> postStepSleep(Duration duration) async {}

  /// Converts this to a JSON compatible map.  For a description of the format,
  /// see [fromDynamic].
  @override
  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
      };
}
