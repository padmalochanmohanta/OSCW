// lib/features/settings/domain/usecases/get_theme_usecase.dart
import '../repositories/settings_repository.dart';

class GetThemeUseCase {
  final SettingsRepository repository;
  GetThemeUseCase(this.repository);

  Future<String> call() => repository.getUserSettings().then((s) => s.theme);
}
