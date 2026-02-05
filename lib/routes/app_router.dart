import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oscw/core/di/injector.dart';
import 'package:oscw/features/complaint/data/datasource/track_complaint_remote_ds.dart';
import 'package:oscw/features/complaint/data/repository_impl/track_complaint_repo_impl.dart';
import 'package:oscw/features/complaint/domain/usecase/get_complain_registration.dart';
import 'package:oscw/features/complaint/domain/usecase/search_complaint_usecase.dart';
import 'package:oscw/features/complaint/presentation/bloc/complaint_registration/complaint_bloc.dart';
import 'package:oscw/features/complaint/presentation/bloc/track_complaint/track_complaint_bloc.dart';
import 'package:oscw/features/complaint/presentation/compliant_registration_page.dart';

import '../features/auth/presentation/login_page.dart';
import '../features/auth/presentation/verify_otp_page.dart';
import '../features/complaint/presentation/register_complaint_page.dart';
import '../features/splash/presentation/splash_page.dart';
import '../navigation/main_nav_page.dart';
import '../features/home/presentation/home_page.dart';
import '../features/settings/presentation/view/settings_page.dart';

import '../features/toll_free/presentation/toll_free_page.dart';
import '../features/complaint/presentation/track_complaint_page.dart';
import '../features/whatsapp/presentation/whatsapp_complaint_page.dart';
import '../features/helpline/presentation/helpline_page.dart';
import '../features/safety/presentation/safety_tips_page.dart';

import 'app_routes.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {

    /// ✅ IMPORTANT: ROOT ROUTE FIX
      case '/':
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
        );

      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashPage());

      case AppRoutes.mainNav:
        return MaterialPageRoute(builder: (_) => const MainNavPage());

      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomePage());

      case AppRoutes.settings:
        return MaterialPageRoute(builder: (_) => const SettingsPage());

      case AppRoutes.tollFree:
        return MaterialPageRoute(builder: (_) => const TollFreePage());
        
      case AppRoutes.giveComplaint:
             return MaterialPageRoute(
               builder: (_) => BlocProvider(
               create: (_) => ComplaintBloc(submitComplaint: sl<SubmitComplaintUseCase>()),
              child: const ComplaintFormPage(),
    ),
  );
  


case AppRoutes.trackComplaint:
  return MaterialPageRoute(
    builder: (_) => BlocProvider(
      create: (_) => TrackComplaintBloc(
        SearchComplaintUseCase(
          TrackComplaintRepositoryImpl(
            TrackComplaintRemoteDataSourceImpl(),
          ),
        ),
      ),
      child: TrackComplaintPage(), 
    ),
  );


       


      case AppRoutes.whatsappComplaint:
        return MaterialPageRoute(builder: (_) => const WhatsAppComplaintPage());

      case AppRoutes.helpline:
        return MaterialPageRoute(builder: (_) => const HelplinePage());

      case AppRoutes.safetyTips:
        return MaterialPageRoute(builder: (_) => const SafetyTipsPage());

      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginPage());

      case AppRoutes.verifyOtp:
        return MaterialPageRoute(
          builder: (_) => const VerifyOtpPage(),
          settings: settings, // 👈 pass arguments safely
        );

      case AppRoutes.registerComplaint:
        return MaterialPageRoute(
          builder: (_) => const RegisterComplaintPage(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text(
                "No route defined for ${settings.name}",
              ),
            ),
          ),
        );
    }
  }
}
