// lib/core/local_storage/preferences.dart
import 'package:shared_preferences/shared_preferences.dart';
import 'prefs_keys.dart';

// class Preferences {
//   final SharedPreferences _prefs;

//   Preferences(this._prefs);

//   // ThemeMode stored as string: 'light' | 'dark' | 'system'
//   String? getThemeString() => _prefs.getString(PrefsKeys.themeMode);
//   Future<bool> setThemeString(String theme) => _prefs.setString(PrefsKeys.themeMode, theme);

//   // Locale stored as languageCode, e.g. 'en' | 'hi'
//   String? getLocale() => _prefs.getString(PrefsKeys.locale);
//   Future<bool> setLocale(String locale) => _prefs.setString(PrefsKeys.locale, locale);

//   // Generic helpers
//   Future<bool> clearAll() => _prefs.clear();
// }

class Preferences {
  final SharedPreferences _prefs;

  Preferences(this._prefs);

  // ================= Theme =================
  String? getThemeString() => _prefs.getString(PrefsKeys.themeMode);
  Future<bool> setThemeString(String theme) => _prefs.setString(PrefsKeys.themeMode, theme);

  // ================= Locale =================
  String? getLocale() => _prefs.getString(PrefsKeys.locale);
  Future<bool> setLocale(String locale) => _prefs.setString(PrefsKeys.locale, locale);

  // ================= User Mobile =================
  String? getMobile() => _prefs.getString(PrefsKeys.mobile);
  Future<bool> setMobile(String mobile) => _prefs.setString(PrefsKeys.mobile, mobile);

  // ================= Session Clear =================
  Future<bool> clearMobile() => _prefs.remove(PrefsKeys.mobile);

  // ================= Clear All =================
  Future<bool> clearAll() => _prefs.clear();
}


