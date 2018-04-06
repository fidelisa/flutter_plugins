library intl_helpers;

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl_helpers/app_helper_localizations.dart';
import 'package:intl_helpers/generic_helper_localizations.dart';

export 'app_helper_localizations.dart';
export 'generic_helper_localizations.dart';
export 'localization_listener.dart';

List<LocalizationsDelegate<dynamic>> createBasicLocalizationsDelegates(
    {List<String> supportedLanguages, InitializeMessages initializeMessages}) {
  var _delegates = [
    GlobalWidgetsLocalizations.delegate,
    GlobalMaterialLocalizations.delegate, // ignore: undefined_getter
    GenericHelperLocalizations.delegate
  ];

  _delegates.add(GenericHelperLocalizations.delegate);

  if (initializeMessages != null) {
    _delegates.add(AppHelperLocalizations.delegate(
        supportedLanguages, initializeMessages));
  }

  return _delegates;
}
