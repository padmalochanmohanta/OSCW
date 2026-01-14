// lib/features/settings/domain/entities/user_settings.dart
class UserSettings {
  final String theme;     // 'light', 'dark', 'system'
  final String language;  // 'en', 'hi', 'or'

  const UserSettings({
    required this.theme,
    required this.language,
  });
}
