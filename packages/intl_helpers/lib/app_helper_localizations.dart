import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

typedef Future InitializeMessages(String localeName);

class AppHelperLocalizations {
  static Future<AppHelperLocalizations> load(
      Locale locale, InitializeMessages initializeMessages) async {
    final String name =
        locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    await initializeMessages(localeName);

    Intl.defaultLocale = localeName;
    return new AppHelperLocalizations();
  }

  static AppHelperLocalizations of(BuildContext context) {
    return Localizations.of<AppHelperLocalizations>(
        context, AppHelperLocalizations);
  }

  static LocalizationsDelegate<AppHelperLocalizations> delegate(
      List<String> supportedLanguages, InitializeMessages initializeMessages) {
    return new _AppHelperLocalizationsDelegate(
        supportedLanguages: supportedLanguages,
        initializeMessages: initializeMessages);
  }
}

class _AppHelperLocalizationsDelegate
    extends LocalizationsDelegate<AppHelperLocalizations> {
  final List<String> supportedLanguages;
  final InitializeMessages initializeMessages;

  _AppHelperLocalizationsDelegate(
      {this.supportedLanguages, this.initializeMessages});

  @override
  bool isSupported(Locale locale) =>
      supportedLanguages.contains(locale.languageCode);

  @override
  Future<AppHelperLocalizations> load(Locale locale) =>
      AppHelperLocalizations.load(locale, initializeMessages);

  @override
  bool shouldReload(_AppHelperLocalizationsDelegate old) => false;
}
