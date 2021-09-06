import 'package:automated_testing_framework/automated_testing_framework.dart';
import 'package:automated_testing_framework_plugin_gps/automated_testing_framework_plugin_gps.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('assert_location_permission', () {
    TestGpsHelper.registerTestSteps();
    var availStep = TestStepRegistry.instance.getAvailableTestStep(
      AssertLocationPermissionStep.id,
    )!;

    expect(availStep.form.runtimeType, AssertLocationPermissionForm);
    expect(
      availStep.help,
      TestGpsTranslations.atf_gps_help_assert_location_permission,
    );
    expect(availStep.id, 'assert_location_permission');
    expect(
      availStep.title,
      TestGpsTranslations.atf_gps_title_assert_location_permission,
    );
    expect(availStep.type, null);
    expect(availStep.widgetless, true);
  });

  test('reset_location', () {
    TestGpsHelper.registerTestSteps();
    var availStep = TestStepRegistry.instance.getAvailableTestStep(
      ResetLocationStep.id,
    )!;

    expect(availStep.form.runtimeType, ResetLocationForm);
    expect(
      availStep.help,
      TestGpsTranslations.atf_gps_help_reset_location,
    );
    expect(availStep.id, 'reset_location');
    expect(
      availStep.title,
      TestGpsTranslations.atf_gps_title_reset_location,
    );
    expect(availStep.type, null);
    expect(availStep.widgetless, true);
  });

  test('set_location', () {
    TestGpsHelper.registerTestSteps();
    var availStep = TestStepRegistry.instance.getAvailableTestStep(
      SetLocationStep.id,
    )!;

    expect(availStep.form.runtimeType, SetLocationForm);
    expect(
      availStep.help,
      TestGpsTranslations.atf_gps_help_set_location,
    );
    expect(availStep.id, 'set_location');
    expect(
      availStep.title,
      TestGpsTranslations.atf_gps_title_set_location,
    );
    expect(availStep.type, null);
    expect(availStep.widgetless, true);
  });

  test('set_location_permission', () {
    TestGpsHelper.registerTestSteps();
    var availStep = TestStepRegistry.instance.getAvailableTestStep(
      SetLocationPermissionStep.id,
    )!;

    expect(availStep.form.runtimeType, SetLocationPermissionForm);
    expect(
      availStep.help,
      TestGpsTranslations.atf_gps_help_set_location_permission,
    );
    expect(availStep.id, 'set_location_permission');
    expect(
      availStep.title,
      TestGpsTranslations.atf_gps_title_set_location_permission,
    );
    expect(availStep.type, null);
    expect(availStep.widgetless, true);
  });
}
