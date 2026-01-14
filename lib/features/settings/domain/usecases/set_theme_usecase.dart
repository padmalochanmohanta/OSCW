// lib/features/settings/domain/usecases/set_theme_usecase.dart
import '../repositories/settings_repository.dart';

class SetThemeUseCase {
  final SettingsRepository repository;
  SetThemeUseCase(this.repository);

  Future<void> call(String theme) => repository.setTheme(theme);
}
