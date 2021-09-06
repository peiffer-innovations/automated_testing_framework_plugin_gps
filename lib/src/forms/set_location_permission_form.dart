import 'package:automated_testing_framework/automated_testing_framework.dart';
import 'package:automated_testing_framework_plugin_gps/automated_testing_framework_plugin_gps.dart';
import 'package:flutter/material.dart';
import 'package:static_translations/static_translations.dart';

class SetLocationPermissionForm extends TestStepForm {
  const SetLocationPermissionForm();

  @override
  bool get supportsMinified => true;

  @override
  TranslationEntry get title =>
      TestGpsTranslations.atf_gps_title_set_location_permission;

  @override
  Widget buildForm(
    BuildContext context,
    Map<String, dynamic>? values, {
    bool minify = false,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (minify != true)
          buildHelpSection(
            context,
            TestGpsTranslations.atf_gps_help_set_location_permission,
            minify: minify,
          ),
        buildValuesSection(
          context,
          [
            buildDropdown(
              context: context,
              defaultValue: 'whileInUse',
              id: 'permission',
              items: [
                'always',
                'denied',
                'deniedForever',
                'whileInUse',
              ],
              label: TestGpsTranslations.atf_gps_form_permission,
              values: values ?? <String, dynamic>{},
            ),
          ],
          minify: minify,
        ),
      ],
    );
  }
}
