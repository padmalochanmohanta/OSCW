// lib/core/di/injector.dart
import 'package:get_it/get_it.dart';
import 'package:oscw/core/constants/app_urls.dart';
import 'package:oscw/features/complaint/data/datasource/complain_regitration_remote_ds.dart';
import 'package:oscw/features/complaint/data/datasource/track_complaint_remote_ds.dart';
import 'package:oscw/features/complaint/data/repository_impl/complain_dropdown_repository_impl.dart';
import 'package:oscw/features/complaint/data/repository_impl/complain_registration_repo_impl.dart';
import 'package:oscw/features/complaint/data/repository_impl/district_repo_impl.dart';
import 'package:oscw/features/complaint/data/repository_impl/track_complaint_repo_impl.dart';
import 'package:oscw/features/complaint/domain/repository/complain_dropdown_repository.dart';
import 'package:oscw/features/complaint/domain/repository/complain_registration_repo.dart';
import 'package:oscw/features/complaint/domain/repository/district_repo.dart';
import 'package:oscw/features/complaint/domain/repository/track_complaint_repository.dart';
import 'package:oscw/features/complaint/domain/usecase/get_compain_dropdwon.dart';
import 'package:oscw/features/complaint/domain/usecase/get_complain_registration.dart';
import 'package:oscw/features/complaint/domain/usecase/get_district_usecase.dart';
import 'package:oscw/features/complaint/domain/usecase/search_complaint_usecase.dart';
import 'package:oscw/features/complaint/presentation/bloc/complain_dropdown_bloc.dart';
import 'package:oscw/features/complaint/presentation/bloc/complaint_registration/complaint_bloc.dart';
import 'package:oscw/features/complaint/presentation/bloc/district/district_bloc.dart';
import 'package:oscw/features/complaint/presentation/bloc/track_complaint/track_complaint_bloc.dart';
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

  // ======================================================
//                DROPDOWN FEATURE (Complaint Type)
// ======================================================

// Repository
sl.registerLazySingleton<DropdownRepository>(
  () => DropdownRepositoryImpl(
    apiUrl: AppUrls.typeofcompalins,
  ),
);

// Use case
sl.registerLazySingleton(
  () => GetDropdownItemsUseCase(sl()),
);

// Bloc
sl.registerFactory(
  () => DropdownBloc(getDropdownItems: sl()),
);

// Repository
sl.registerLazySingleton<DistrictRepository>(
  () => DistrictRepositoryImpl(apiUrl: AppUrls.district),
);

// UseCase
sl.registerLazySingleton(() => GetDistrictsUseCase(sl()));

// Bloc
sl.registerFactory(() => DistrictBloc(getDistricts: sl()));

// ---------------- DATASOURCE ----------------
  sl.registerLazySingleton<ComplaintRemoteDataSource>(
    () => ComplaintRemoteDataSourceImpl(),
  );

  // ---------------- REPOSITORY ----------------
  sl.registerLazySingleton<ComplaintRepository>(
    () => ComplaintRepositoryImpl(remoteDataSource: sl()),
  );

  // ---------------- USE CASE ----------------
  sl.registerLazySingleton<SubmitComplaintUseCase>(
    () => SubmitComplaintUseCase(sl()),
  );

  // ---------------- BLOC ----------------
  sl.registerFactory<ComplaintBloc>(
    () => ComplaintBloc(submitComplaint: sl()),
  );

// Data
// In your DI setup (main.dart or di.dart)
sl.registerLazySingleton<TrackComplaintRemoteDataSource>(
    () => TrackComplaintRemoteDataSourceImpl());

sl.registerLazySingleton<TrackComplaintRepository>(
    () => TrackComplaintRepositoryImpl(sl()));

sl.registerLazySingleton(() => SearchComplaintUseCase(sl()));

sl.registerFactory(() => TrackComplaintBloc(sl())); 


}
