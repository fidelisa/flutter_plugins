import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl_helpers/l10n/localizations.dart';

class GenericHelperLocalizations {
  TranslationBundle _translationBundle;

  GenericHelperLocalizations(Locale locale) {
    _translationBundle = translationBundleForLocale(locale);
  }

  static Future<GenericHelperLocalizations> load(Locale locale) {
    return new SynchronousFuture<GenericHelperLocalizations>(
        new GenericHelperLocalizations(locale));
  }

  static GenericHelperLocalizations of(BuildContext context) {
    return Localizations.of<GenericHelperLocalizations>(
        context, GenericHelperLocalizations);
  }

  String get welcome => _translationBundle.welcome;

  static const LocalizationsDelegate<GenericHelperLocalizations> delegate =
      const _GenericHelperLocalizationsDelegate();

  static const List<LocalizationsDelegate<dynamic>> delegates =
      const <LocalizationsDelegate<dynamic>>[
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GenericHelperLocalizations.delegate
  ];
}

class _GenericHelperLocalizationsDelegate
    extends LocalizationsDelegate<GenericHelperLocalizations> {
  const _GenericHelperLocalizationsDelegate();

  static const List<String> _supportedLanguages = const <String>[
    'en', // English
    'fr', // French
  ];

  @override
  bool isSupported(Locale locale) =>
      _supportedLanguages.contains(locale.languageCode);

  @override
  Future<GenericHelperLocalizations> load(Locale locale) =>
      GenericHelperLocalizations.load(locale);

  @override
  bool shouldReload(_GenericHelperLocalizationsDelegate old) => false;
}
