// lib/features/settings/data/repositories/settings_repository_impl.dart
import '../../domain/entities/user_settings.dart';
import '../../domain/repositories/settings_repository.dart';
import '../datasources/settings_local_datasource.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDataSource local;

  SettingsRepositoryImpl({required this.local});

  @override
  Future<UserSettings> getUserSettings() async {
    return UserSettings(
      theme: local.getTheme(),
      language: local.getLanguage(),
    );
  }

  @override
  Future<void> setTheme(String theme) async {
    await local.setTheme(theme);
  }

  @override
  Future<void> setLanguage(String langCode) async {
    await local.setLanguage(langCode);
  }
}
