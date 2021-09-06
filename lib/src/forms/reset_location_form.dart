import 'package:automated_testing_framework/automated_testing_framework.dart';
import 'package:automated_testing_framework_plugin_gps/automated_testing_framework_plugin_gps.dart';
import 'package:flutter/material.dart';
import 'package:static_translations/static_translations.dart';

class ResetLocationForm extends TestStepForm {
  const ResetLocationForm();

  @override
  bool get supportsMinified => false;

  @override
  TranslationEntry get title =>
      TestGpsTranslations.atf_gps_title_reset_location;

  @override
  Widget buildForm(
    BuildContext context,
    Map<String, dynamic>? values, {
    bool minify = false,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        buildHelpSection(
          context,
          TestGpsTranslations.atf_gps_help_reset_location,
          minify: minify,
        ),
      ],
    );
  }
}
