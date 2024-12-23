import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

import '../constants/app_constants.dart';
import '../data/manager/preferences_manager.dart';

class AppLocalizationManager extends ChangeNotifier {
  final _preferenceManager = GetIt.I<PreferencesManager>();

  final _languageSubject = BehaviorSubject<bool>.seeded(true);

  static final AppLocalizationManager _instance =
      AppLocalizationManager._internal();

  AppLocalizationManager._internal();

  factory AppLocalizationManager() {
    return _instance;
  }

  static Locale _appLocale = const Locale(AppConstants.defaultLanguage);

  static bool get isCurrentEnglish => _appLocale.languageCode == 'en';

  /// Get the current locale of the application.
  /// Will notify whenever language is changed.
  Stream<Locale> getAppLocale() {
    Stream<Locale> locale = _languageSubject
        .flatMap((_) =>
            _preferenceManager.getString(PreferencesManager.keyLanguageCode))
        .map((locale) => Locale(locale ?? AppConstants.defaultLanguage));

    locale.listen((event) {
      _appLocale = event;
    });
    return locale;
  }

  /// Set the current locale of the application
  Stream<bool> setAppLocale(String languageCode) {
    _appLocale = Locale(languageCode);
    return _preferenceManager
        .setString(PreferencesManager.keyLanguageCode, languageCode)
        .doOnData((_) => _languageSubject.add(true));
  }

// fetchLocale() async {
//   _appLocale = Locale(await _preferenceManager.getLanguageCode() ?? 'en');
//   print("AppLocale from Shared Preference: $_appLocale");
//   return _appLocale;
// }

// void changeLanguage(Locale type) async {
//   // if (_appLocale == type) {
//   //   return;
//   // }
//   if (type == const Locale("ar")) {
//     print('AR');
//     _appLocale = const Locale("ar");
//     _preferenceManager.setLanguageCode('ar');
//   } else {
//     print('EN');
//     _appLocale = const Locale("en");
//     _preferenceManager.setLanguageCode('en');
//   }
//   print('Current $_appLocale Updating locale for $type');
//   notifyListeners();
// }
}
