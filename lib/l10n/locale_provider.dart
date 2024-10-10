import 'package:flutter/material.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale = const Locale('en'); // Langue par défaut

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    if (_locale != locale) {
      _locale = locale;
      notifyListeners(); // Notifie tous les widgets dépendants de ce provider
    }
  }

  // Fonction pour alterner entre anglais et français
  void toggleLocale() {
    if (_locale.languageCode == 'en') {
      setLocale(const Locale('fr'));
    } else {
      setLocale(const Locale('en'));
    }
  }
}
