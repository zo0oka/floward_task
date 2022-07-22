import 'dart:developer';

import 'package:floward_task/utils/preferences_manager.dart';
import 'package:flutter/material.dart';

class LanguageProvider with ChangeNotifier {
  Locale locale = const Locale('en');

  void init() {
    locale =
        Locale(PreferencesManager.getString(PreferencesManager.lang) ?? 'en');
  }

  void changeLocale() async {
    locale = Locale(locale.languageCode == 'en' ? 'ar' : 'en');
    log('Selected Local -> ${locale.languageCode}');
    await PreferencesManager.saveString(
        PreferencesManager.lang, locale.languageCode);
    notifyListeners();
  }
}
