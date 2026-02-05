// lib/app.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:oscw/routes/app_router.dart';
import 'package:oscw/routes/app_routes.dart';

// DI
import 'core/di/injector.dart';

// Theme
import 'core/theme/theme_bloc.dart';
import 'core/theme/theme_event.dart';
import 'core/theme/theme_state.dart';
import 'core/theme/app_theme.dart';

// Localization
import 'core/localization/locale_bloc.dart';
import 'core/localization/locale_event.dart';
import 'core/localization/locale_state.dart';
import 'core/localization/app_localizations.dart';

// Internet
import 'core/internet/internet_bloc.dart';
import 'core/internet/internet_event.dart';


// Screens

class OSCWApp extends StatelessWidget {
  const OSCWApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // IMPORTANT:
        // Using BlocProvider.value because ThemeBloc & LocaleBloc are singletons
        BlocProvider.value(
          value: sl<ThemeBloc>()..add(const LoadThemeEvent()),
        ),

        BlocProvider.value(
          value: sl<LocaleBloc>()..add(const LoadLocaleEvent()),
        ),

        // InternetBloc can be factory
        BlocProvider(
          create: (_) => sl<InternetBloc>()..add(const LoadInternetStatus()),
        ),
      ],

      // MaterialApp MUST rebuild when theme or language changes
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          return BlocBuilder<LocaleBloc, LocaleState>(
            builder: (context, localeState) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: "OSCW",

                // -------------------------------
                // LOCALIZATION CONFIGURATION
                // -------------------------------
                supportedLocales: const [
                  Locale('en'),
                  Locale('hi'),
                  Locale('or'),
                ],

                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],

                // Dynamic Locale
                locale: Locale(localeState.languageCode),

                // -------------------------------
                // THEME CONFIGURATION
                // -------------------------------
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                themeMode: themeState.themeMode,
                

                // -------------------------------
                // INITIAL SCREEN
                // -------------------------------
              //  home: const SplashPage(),
                onGenerateRoute: AppRouter.generateRoute,
                initialRoute: AppRoutes.splash,
              );
            },
          );
        },
      ),
    );
  }
}
