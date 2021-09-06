import 'package:automated_testing_framework/automated_testing_framework.dart';
import 'package:automated_testing_framework_plugin_gps/automated_testing_framework_plugin_gps.dart';

class TestGpsHelper {
  /// Registers the test steps to the optional [registry].  If not set, the
  /// default [TestStepRegistry] will be used.
  static void registerTestSteps([TestStepRegistry? registry]) {
    (registry ?? TestStepRegistry.instance).registerCustomSteps([
      TestStepBuilder(
        availableTestStep: AvailableTestStep(
          form: AssertLocationPermissionForm(),
          help: TestGpsTranslations.atf_gps_help_assert_location_permission,
          id: AssertLocationPermissionStep.id,
          keys: const {'permission'},
          quickAddValues: {'permission': 'whileInUse'},
          title: TestGpsTranslations.atf_gps_title_assert_location_permission,
          widgetless: true,
          type: null,
        ),
        testRunnerStepBuilder: AssertLocationPermissionStep.fromDynamic,
      ),
      TestStepBuilder(
        availableTestStep: AvailableTestStep(
          form: ResetLocationForm(),
          help: TestGpsTranslations.atf_gps_help_reset_location,
          id: ResetLocationStep.id,
          keys: const {},
          quickAddValues: {},
          title: TestGpsTranslations.atf_gps_title_reset_location,
          widgetless: true,
          type: null,
        ),
        testRunnerStepBuilder: ResetLocationStep.fromDynamic,
      ),
      TestStepBuilder(
        availableTestStep: AvailableTestStep(
          form: SetLocationForm(),
          help: TestGpsTranslations.atf_gps_help_set_location,
          id: SetLocationStep.id,
          keys: const {
            'latitude',
            'longitude',
          },
          quickAddValues: null,
          title: TestGpsTranslations.atf_gps_title_set_location,
          widgetless: true,
          type: null,
        ),
        testRunnerStepBuilder: SetLocationStep.fromDynamic,
      ),
      TestStepBuilder(
        availableTestStep: AvailableTestStep(
          form: SetLocationPermissionForm(),
          help: TestGpsTranslations.atf_gps_help_set_location_permission,
          id: SetLocationPermissionStep.id,
          keys: const {'permission'},
          quickAddValues: {'permission': 'whileInUse'},
          title: TestGpsTranslations.atf_gps_title_set_location_permission,
          widgetless: true,
          type: null,
        ),
        testRunnerStepBuilder: SetLocationPermissionStep.fromDynamic,
      ),
    ]);
  }
}
