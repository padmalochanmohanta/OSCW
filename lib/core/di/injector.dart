// lib/core/di/injector.dart
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Core
import '../../features/settings/domain/repositories/settings_repository.dart';
import '../local_storage/preferences.dart';
import '../network/connectivity_service.dart';
import '../network/network_info.dart';

// Core Blocs
import '../theme/theme_bloc.dart';
import '../localization/locale_bloc.dart';
import '../internet/internet_bloc.dart';

// Settings Feature
import '../../features/settings/data/datasources/settings_local_datasource.dart';
import '../../features/settings/data/repositories/settings_repository_impl.dart';
import '../../features/settings/domain/usecases/get_theme_usecase.dart';
import '../../features/settings/domain/usecases/set_theme_usecase.dart';
import '../../features/settings/domain/usecases/get_locale_usecase.dart';
import '../../features/settings/domain/usecases/set_locale_usecase.dart';
import '../../features/settings/presentation/viewmodel/settings_bloc.dart';

final GetIt sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // ---------------- EXTERNAL ----------------
  final SharedPreferences sharedPreferences =
  await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(sharedPreferences);

  // ---------------- CORE ----------------
  sl.registerLazySingleton<Preferences>(() => Preferences(sharedPreferences));
  sl.registerLazySingleton<ConnectivityService>(() => ConnectivityService());
  sl.registerLazySingleton<NetworkInfo>(
          () => NetworkInfoImpl(connectivityService: sl()));

  // ======================================================
  //             GLOBAL BLOCS (IMPORTANT FIX)
  // ======================================================
  // These MUST be singletons so the whole app listens to the same instance.
  sl.registerLazySingleton<ThemeBloc>(() => ThemeBloc(preferences: sl()));
  sl.registerLazySingleton<LocaleBloc>(() => LocaleBloc(preferences: sl()));

  // InternetBloc can be factory (not global)
  sl.registerFactory<InternetBloc>(() => InternetBloc(networkInfo: sl()));

  // ======================================================
//                   SETTINGS FEATURE
// ======================================================

// Datasource
  sl.registerLazySingleton<SettingsLocalDataSource>(
        () => SettingsLocalDataSource(prefs: sl()),
  );

// Repository (IMPORTANT FIX: register as SettingsRepository)
  sl.registerLazySingleton<SettingsRepository>(
        () => SettingsRepositoryImpl(local: sl()),
  );

// Use Cases
  sl.registerLazySingleton(() => GetThemeUseCase(sl()));
  sl.registerLazySingleton(() => SetThemeUseCase(sl()));
  sl.registerLazySingleton(() => GetLocaleUseCase(sl()));
  sl.registerLazySingleton(() => SetLocaleUseCase(sl()));

// Bloc (factory)
  sl.registerFactory(() => SettingsBloc(
    getTheme: sl(),
    setTheme: sl(),
    getLocale: sl(),
    setLocale: sl(),
  ));

}
