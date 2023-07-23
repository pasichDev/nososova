import 'package:flutter/cupertino.dart';

class AppLocalizations {
  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  // Тут ви можете додати ключі та рядки перекладу для підтримуваних мов
  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'title': 'My App',
      'hello': 'Hello!',
      // Додайте інші рядки перекладу для англійської мови
    },
    'uk': {
      'title': 'Моя програма',
      'hello': 'Привіт!',
      // Додайте інші рядки перекладу для української мови
    },
    // Додайте інші мови, які ви підтримуєте
  };

  // Метод, який повертає рядок перекладу для певного ключа та локалізації
  String? translate(String key, Locale locale) {
    return _localizedValues[locale.languageCode]?[key];
  }

  // Список підтримуваних локалізацій
  static List<Locale> get supportedLocales {
    return _localizedValues.keys.map((locale) => Locale(locale, '')).toList();
  }
}

// Клас делегата, який завантажує рядки перекладу
class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return AppLocalizations.supportedLocales.any((supportedLocale) => supportedLocale.languageCode == locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations();
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) {
    return false;
  }
}
