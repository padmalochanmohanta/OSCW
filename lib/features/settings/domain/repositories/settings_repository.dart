import '../entities/user_settings.dart';

abstract class SettingsRepository {
  Future<UserSettings> getUserSettings();
  Future<void> setTheme(String theme);
  Future<void> setLanguage(String langCode);
}
