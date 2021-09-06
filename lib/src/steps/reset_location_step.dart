import 'package:automated_testing_framework/automated_testing_framework.dart';
import 'package:automated_testing_framework_plugin_gps/automated_testing_framework_plugin_gps.dart';

/// Reset's the any overrides in the [GpsPlugin].
class ResetLocationStep extends TestRunnerStep {
  static List<String> get behaviorDrivenDescriptions => List.unmodifiable([
        'reset the location overrrides.',
      ]);

  static const id = 'reset_location';

  @override
  String get stepId => id;

  /// Creates an instance from a JSON-like map structure.  This expects the
  /// following format:
  ///
  /// ```json
  /// {
  /// }
  /// ```
  static ResetLocationStep fromDynamic(dynamic map) {
    ResetLocationStep result;

    if (map == null) {
      throw Exception('[ResetLocationStep.fromDynamic]: map is null');
    } else {
      result = ResetLocationStep();
    }

    return result;
  }

  /// Resets the overrides on the [GpsPlugin].
  @override
  Future<void> execute({
    required CancelToken cancelToken,
    required TestReport report,
    required TestController tester,
  }) async {
    var name = '$id()';

    log(
      name,
      tester: tester,
    );

    GpsPlugin().reset();
  }

  @override
  String getBehaviorDrivenDescription(TestController tester) {
    var result = behaviorDrivenDescriptions[0];

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
  Map<String, dynamic> toJson() => {};
}
