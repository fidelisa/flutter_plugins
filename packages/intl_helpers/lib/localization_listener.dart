import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl_helpers/app_helper_localizations.dart';

class LocaleNotifier extends ChangeNotifier {
  LocaleNotifier._(this.locale, this.initializeMessages);

  Locale locale;

  InitializeMessages initializeMessages;

  static LocaleNotifier instance;

  static void init({Locale locale, InitializeMessages initializeMessages}) {
    assert(locale != null);
    assert(initializeMessages != null);
    instance = new LocaleNotifier._(locale, initializeMessages);
  }

  void update(Locale value) async {
    locale = value;
    await initializeMessages(value.toString());
    Intl.defaultLocale = value.toString();

    notifyListeners();
  }
}
