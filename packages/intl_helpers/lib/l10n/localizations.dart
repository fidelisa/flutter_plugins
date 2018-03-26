import 'dart:ui' show Locale;

class TranslationBundle {
  const TranslationBundle(this.parent);
  final TranslationBundle parent;

  String get welcome => parent?.welcome;
  String get yesLabel => parent?.yesLabel;
  String get noLabel => parent?.noLabel;
}

// ignore: camel_case_types
class _Bundle_fr extends TranslationBundle {
  const _Bundle_fr() : super(null);

  @override
  String get welcome => r'Bienvenue !';
  @override
  String get yesLabel => r'OUI';
  @override
  String get noLabel => r'NON';
}

// ignore: camel_case_types
class _Bundle_en extends TranslationBundle {
  const _Bundle_en() : super(null);

  @override
  String get welcome => r'Welcome !';
  @override
  String get yesLabel => r'YES';
  @override
  String get noLabel => r'NO';
}

TranslationBundle translationBundleForLocale(Locale locale) {
  switch (locale.languageCode) {
    case 'fr':
      return const _Bundle_fr();
    case 'en':
      return const _Bundle_en();
  }
  return const TranslationBundle(null);
}
