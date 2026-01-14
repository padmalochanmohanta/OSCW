// lib/features/settings/domain/usecases/get_locale_usecase.dart
import '../repositories/settings_repository.dart';

class GetLocaleUseCase {
  final SettingsRepository repository;
  GetLocaleUseCase(this.repository);

  Future<String> call() => repository.getUserSettings().then((s) => s.language);
}
