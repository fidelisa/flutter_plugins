import 'dart:ui' show Locale;

class TranslationBundle {
  const TranslationBundle(this.parent);
  final TranslationBundle parent;

  String get welcome => parent?.welcome;

  String get emailLabel => parent?.emailLabel;

  String get nextButtonLabel => parent?.nextButtonLabel;

  String get cancelButtonLabel => parent?.cancelButtonLabel;

  String get passwordLabel => parent?.passwordLabel;

  String get troubleSigningInLabel => parent?.troubleSigningInLabel;

  String get signInLabel => parent?.signInLabel;

  String get signInTitle => parent?.signInTitle;

  String get passwordInvalidMessage => parent?.passwordInvalidMessage;

  String get recoverPasswordTitle => parent?.recoverPasswordTitle;

  String get recoverHelpLabel => parent?.recoverHelpLabel;

  String get sendButtonLabel => parent?.sendButtonLabel;

  String get nameLabel => parent?.nameLabel;

  String get saveLabel => parent?.saveLabel;

  String get passwordLengthMessage => parent?.passwordLengthMessage;

  String get signInFacebook => parent?.signInFacebook;
  String get signInGoogle => parent?.signInGoogle;
  String get signInEmail => parent?.signInEmail;

  String get errorOccurred => parent?.errorOccurred;

  allReadyEmailMessage(String email, String providerName) =>
      parent?.allReadyEmailMessage(email, providerName);

  recoverDialog(String email) => parent?.recoverDialog(email);
}

// ignore: camel_case_types
class _Bundle_fr extends TranslationBundle {
  const _Bundle_fr() : super(null);

  @override
  String get welcome => r'Bienvenue';
  @override
  String get emailLabel => r'Adresse mail';
  @override
  String get passwordLabel => r'Mot de passe';

  @override
  String get nextButtonLabel => r'SUIVANT';
  @override
  String get cancelButtonLabel => r'ANNULER';
  @override
  String get signInLabel => r'CONNEXION';

  @override
  String get saveLabel => r'ENREGISTRER';

  @override
  String get signInTitle => r'Connexion';

  @override
  String get troubleSigningInLabel => 'Difficultés à se connecter ?';

  @override
  String get passwordInvalidMessage =>
      'Le mot de passe est invalide ou l\'utilisateur n\'a pas de mot de passe.';

  @override
  String get recoverPasswordTitle => r'Récupérer mot de passe';

  @override
  String get recoverHelpLabel =>
      r'Obtenez des instructions envoyées à cet e-mail ' +
      'pour expliquer comment réinitialiser votre mot de passe';

  @override
  String get sendButtonLabel => r'ENVOYER';

  @override
  String get nameLabel => r'Nom et prénom';

  @override
  String get errorOccurred => r'Une erreur est survenue';

  @override
  allReadyEmailMessage(String email, String providerName) {
    return '''Vous avez déjà utilisé $email.
Connectez-vous avec $providerName pour continuer.''';
  }

  @override
  recoverDialog(String email) {
    return 'Suivez les instructions envoyées à $email ' +
        'pour retrouver votre mot de passe';
  }

  String get passwordLengthMessage =>
      r'Le mot de passe doit comporter 6 caractères ou plus';

  @override
  String get signInFacebook => r'Connexion avec Facebook';

  @override
  String get signInGoogle => r'Connexion avec Google';

  @override
  String get signInEmail => r'Connexion avec email';
}

// ignore: camel_case_types
class _Bundle_en extends TranslationBundle {
  const _Bundle_en() : super(null);

  @override
  String get welcome => r'Welcome';
  @override
  String get emailLabel => r'Email';
  @override
  String get passwordLabel => r'Password';

  @override
  String get nextButtonLabel => r'NEXT';
  @override
  String get cancelButtonLabel => r'CANCEL';
  @override
  String get signInLabel => r'SIGN IN';
  @override
  String get signInTitle => r'Sign in';

  @override
  String get saveLabel => r'SAVE';

  @override
  String get troubleSigningInLabel => 'Trouble signing in ?';

  @override
  String get passwordInvalidMessage =>
      'The password is invalid or the user does not have password.';

  @override
  String get recoverPasswordTitle => r'Recover password';

  @override
  String get recoverHelpLabel =>
      r'Get instructions sent to this email ' +
      'that explain how to reset your password';

  @override
  String get sendButtonLabel => r'SEND';

  @override
  String get nameLabel => r'First & last name';

  @override
  String get errorOccurred => r'An error occurred';

  @override
  allReadyEmailMessage(String email, String providerName) {
    return '''You have already used $email.
Sign in with $providerName to continue.''';
  }

  @override
  recoverDialog(String email) {
    return 'Follow the instructions sent to $email to recover your password';
  }

  String get passwordLengthMessage =>
      r'The password must be 6 characters long or more';

  @override
  String get signInFacebook => r'Sign in with Facebook';

  @override
  String get signInGoogle => r'Sign in with Google';

  @override
  String get signInEmail => r'Sign in with email';
}

// ignore: camel_case_types
class _Bundle_de extends TranslationBundle {
  const _Bundle_de() : super(null);

  @override
  String get welcome => r'Willkommen';
  @override
  String get emailLabel => r'Email';
  @override
  String get passwordLabel => r'Passwort';

  @override
  String get nextButtonLabel => r'WEITER';
  @override
  String get cancelButtonLabel => r'ABBRUCH';
  @override
  String get signInLabel => r'ANMELDEN';
  @override
  String get signInTitle => r'Anmelden';

  @override
  String get saveLabel => r'SPEICHERN';

  @override
  String get troubleSigningInLabel => 'Probleme beim Anmelden?';

  @override
  String get passwordInvalidMessage =>
      'Das Passwort ist ungültig oder der Bentutzer hat kein Passwort.';

  @override
  String get recoverPasswordTitle => r'Passwort wiederherstellen';

  @override
  String get recoverHelpLabel =>
      r'Erhalte Anweisungen zum Wiederherstellen des Passworts ' +
      'an diese Email';

  @override
  String get sendButtonLabel => r'SENDEN';

  @override
  String get nameLabel => r'Vor- & Nachname';

  @override
  String get errorOccurred => r'Ein Fehler ist aufgetreten';

  @override
  allReadyEmailMessage(String email, String providerName) {
    return '''$email wurde bereits genutzt.
Mit $providerName anmelden um fortzufarhen.''';
  }

  @override
  recoverDialog(String email) {
    return 'Befolge die Anweisungen, welche an $email gesendet wurden um das Passswort wiederherzustellen';
  }

  String get passwordLengthMessage =>
      r'Das Passwort muss 6 oder mehr Zeichen haben';

  @override
  String get signInFacebook => r'Mit Facebook anmelden';

  @override
  String get signInGoogle => r'Mit Google anmelden';

  @override
  String get signInEmail => r'Mit Email anmelden';
}

TranslationBundle translationBundleForLocale(Locale locale) {
  switch (locale.languageCode) {
    case 'fr':
      return const _Bundle_fr();
    case 'en':
      return const _Bundle_en();
    case 'de':
      return const _Bundle_de();
  }
  return const TranslationBundle(null);
}
