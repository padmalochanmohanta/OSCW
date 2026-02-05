// lib/features/settings/data/datasources/settings_local_datasource.dart
import '../../../../core/local_storage/preferences.dart';

class SettingsLocalDataSource {
  final Preferences prefs;

  SettingsLocalDataSource({required this.prefs});

  String getTheme() => prefs.getThemeString() ?? "system";
  String getLanguage() => prefs.getLocale() ?? "en";

  Future<void> setTheme(String theme) => prefs.setThemeString(theme);
  Future<void> setLanguage(String langCode) => prefs.setLocale(langCode);
}
