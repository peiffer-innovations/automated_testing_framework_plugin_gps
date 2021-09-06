import 'package:automated_testing_framework/automated_testing_framework.dart';
import 'package:automated_testing_framework_plugin_gps/automated_testing_framework_plugin_gps.dart';
import 'package:flutter/material.dart';
import 'package:form_validation/form_validation.dart';
import 'package:static_translations/static_translations.dart';

class SetLocationForm extends TestStepForm {
  const SetLocationForm();

  @override
  bool get supportsMinified => true;

  @override
  TranslationEntry get title => TestGpsTranslations.atf_gps_title_set_location;

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
            TestGpsTranslations.atf_gps_help_set_location,
            minify: minify,
          ),
        buildValuesSection(
          context,
          [
            buildEditText(
              context: context,
              id: 'latitude',
              validators: [
                RequiredValidator(),
                NumberValidator(),
                MinNumberValidator(number: -90.0),
                MaxNumberValidator(number: 90.0),
              ],
              label: TestGpsTranslations.atf_gps_form_latitude,
              values: values ?? <String, dynamic>{},
            ),
            buildEditText(
              context: context,
              id: 'longitude',
              validators: [
                RequiredValidator(),
                NumberValidator(),
                MinNumberValidator(number: -180.0),
                MaxNumberValidator(number: 180.0),
              ],
              label: TestGpsTranslations.atf_gps_form_longitude,
              values: values ?? <String, dynamic>{},
            ),
          ],
          minify: minify,
        ),
      ],
    );
  }
}
