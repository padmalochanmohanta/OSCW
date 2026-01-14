// lib/features/splash/presentation/splash_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/app_images.dart';
import '../../../core/theme/theme_bloc.dart';
import '../../../core/theme/theme_event.dart';
import '../../../core/localization/locale_bloc.dart';
import '../../../core/localization/locale_event.dart';
import '../../../core/internet/internet_bloc.dart';
import '../../../core/internet/internet_event.dart';

import '../../../shared_widgets/app_image.dart';
import '../../../routes/app_routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Fade animation
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.forward();

    // Load global states
    context.read<ThemeBloc>().add(const LoadThemeEvent());
    context.read<LocaleBloc>().add(const LoadLocaleEvent());
    context.read<InternetBloc>().add(const LoadInternetStatus());

    _navigateNext();
  }

  Future<void> _navigateNext() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool("is_logged_in") ?? false;

    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    Navigator.pushReplacementNamed(
      context,
      isLoggedIn ? AppRoutes.mainNav : AppRoutes.login,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Stack(
          fit: StackFit.expand,
          children: [
            /// 🌸 Background Image
            AppImage(
              path: AppImages.oscwSplash,
              fit: BoxFit.fill,
            ),

          ],
        ),
      ),
    );
  }

}
