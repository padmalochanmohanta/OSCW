// lib/features/settings/presentation/viewmodel/settings_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injector.dart';
import '../../../../core/theme/theme_bloc.dart';
import '../../../../core/theme/theme_event.dart';
import '../../../../core/localization/locale_bloc.dart';
import '../../../../core/localization/locale_event.dart';

import '../../domain/usecases/get_theme_usecase.dart';
import '../../domain/usecases/set_theme_usecase.dart';
import '../../domain/usecases/get_locale_usecase.dart';
import '../../domain/usecases/set_locale_usecase.dart';

class SettingsBloc extends Cubit<Map<String, String>> {
  final GetThemeUseCase getTheme;
  final SetThemeUseCase setTheme;
  final GetLocaleUseCase getLocale;
  final SetLocaleUseCase setLocale;

  SettingsBloc({
    required this.getTheme,
    required this.setTheme,
    required this.getLocale,
    required this.setLocale,
  }) : super({"theme": "system", "language": "en"}) {
    loadSettings();
  }

  Future<void> loadSettings() async {
    final theme = await getTheme();
    final lang = await getLocale();
    emit({"theme": theme, "language": lang});
  }

  // -------------------------
  // FIX: Update ThemeBloc too
  // -------------------------
  Future<void> updateTheme(String theme) async {
    await setTheme(theme); // save to SharedPreferences

    emit({...state, "theme": theme}); // update Settings UI

    // Tell global ThemeBloc to update real app theme
    sl<ThemeBloc>().add(ChangeThemeEvent(theme));
  }

  // -------------------------
  // FIX: Update LocaleBloc too
  // -------------------------
  Future<void> updateLanguage(String lang) async {
    await setLocale(lang); // save to SharedPreferences

    emit({...state, "language": lang}); // update Settings UI

    // Tell global LocaleBloc to update real app language
    sl<LocaleBloc>().add(ChangeLocaleEvent(lang));
  }
}
