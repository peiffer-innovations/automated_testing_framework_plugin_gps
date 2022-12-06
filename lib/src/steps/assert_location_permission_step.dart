import 'package:automated_testing_framework/automated_testing_framework.dart';
import 'package:automated_testing_framework_plugin_gps/automated_testing_framework_plugin_gps.dart';

/// Test step that asserts that the value within [variableName] equals (or does
/// not equal) a specific [value].
class AssertLocationPermissionStep extends TestRunnerStep {
  AssertLocationPermissionStep({
    required this.permission,
  }) : assert(permission.isNotEmpty == true);

  static const id = 'assert_location_permission';

  static List<String> get behaviorDrivenDescriptions => List.unmodifiable([
        'assert that the location permission for the device is `{{permission}}`.',
      ]);

  /// The permission for accessing the device's location.  Acceptable values are
  /// "always", "denied", "deniedAlways", "whileInUse".
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
  static AssertLocationPermissionStep fromDynamic(dynamic map) {
    AssertLocationPermissionStep result;

    if (map == null) {
      throw Exception(
        '[AssertLocationPermissionStep.fromDynamic]: map is null',
      );
    } else {
      result = AssertLocationPermissionStep(
        permission: map['permission']!.toString(),
      );
    }

    return result;
  }

  /// Executes the step.  This will
  @override
  Future<void> execute({
    required CancelToken cancelToken,
    required TestReport report,
    required TestController tester,
  }) async {
    final permission = tester.resolveVariable(this.permission);
    final name = "$id('${permission}')";
    log(
      name,
      tester: tester,
    );

    final realPermission = await GpsPlugin().locationPermission;

    final expectedPermission = GpsPlugin().getPermissionForString(permission);
    if (realPermission != expectedPermission) {
      throw Exception(
        'permission: actualValue: [${GpsPlugin().getPermissionString(realPermission)}], expected: [$permission].',
      );
    }
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
  Map<String, dynamic> toJson() => {'permission': permission};
}
