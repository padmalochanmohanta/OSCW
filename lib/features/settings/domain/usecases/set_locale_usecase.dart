// lib/features/settings/domain/usecases/set_locale_usecase.dart
import '../repositories/settings_repository.dart';

class SetLocaleUseCase {
  final SettingsRepository repository;
  SetLocaleUseCase(this.repository);

  Future<void> call(String langCode) => repository.setLanguage(langCode);
}
