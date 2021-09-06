import 'package:automated_testing_framework/automated_testing_framework.dart';
import 'package:automated_testing_framework_plugin_gps/automated_testing_framework_plugin_gps.dart';

/// Set's the device's location permission status.  As a note, this will not
/// actually change the permission.  Instead, it sets the value on the
/// [GpsPlugin].  Applications would need to use that plugin to allow for
/// location testing.
class SetLocationPermissionStep extends TestRunnerStep {
  SetLocationPermissionStep({
    required this.permission,
  }) : assert(permission.isNotEmpty == true);

  static const id = 'set_location_permission';

  static List<String> get behaviorDrivenDescriptions => List.unmodifiable([
        "set the device's location permission to `{{permission}}`.",
      ]);

  final String permission;

  @override
  String get stepId => id;

  /// Creates an instance from a JSON-like map structure.  This expects the
  /// following format:
  ///
  /// ```json
  /// {
  ///   "permission": <String>
  /// }
  /// ```
  static SetLocationPermissionStep fromDynamic(dynamic map) {
    SetLocationPermissionStep result;

    if (map == null) {
      throw Exception('[SetLocationPermissionStep.fromDynamic]: map is null');
    } else {
      result = SetLocationPermissionStep(
        permission: map['permission']!.toString(),
      );
    }

    return result;
  }

  /// Sets the location permission value to the [GpsPlugin].
  @override
  Future<void> execute({
    required CancelToken cancelToken,
    required TestReport report,
    required TestController tester,
  }) async {
    var permission =
        (tester.resolveVariable(this.permission)?.toString() ?? 'whileInUse');

    var name = "$id('$permission')";

    log(
      name,
      tester: tester,
    );

    GpsPlugin().overriddenLocationPermission =
        GpsPlugin().getPermissionForString(permission);
  }

  @override
  String getBehaviorDrivenDescription(TestController tester) {
    var result = behaviorDrivenDescriptions[0];

    result = result.replaceAll('{{permission}}', permission);

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
        'permission': permission,
      };
}
