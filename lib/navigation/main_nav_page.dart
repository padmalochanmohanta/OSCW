import 'package:flutter/material.dart';

import '../core/localization/app_localizations.dart';
import '../routes/app_routes.dart';
import '../routes/app_router.dart';

class MainNavPage extends StatefulWidget {
  const MainNavPage({super.key});

  @override
  State<MainNavPage> createState() => _MainNavPageState();
}

class _MainNavPageState extends State<MainNavPage> {
  int _currentIndex = 0;
  bool _isHandlingTap = false;

  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  void _onTabSelected(int index) async {
    if (_isHandlingTap) return;
    _isHandlingTap = true;

    final navigator = _navigatorKeys[index].currentState;

    if (_currentIndex == index && navigator != null) {
      // ✅ Pop safely to root
      while (navigator.canPop()) {
        navigator.pop();
        await Future.delayed(const Duration(milliseconds: 5));
      }
    } else {
      if (mounted) {
        setState(() => _currentIndex = index);
      }
    }

    await Future.delayed(const Duration(milliseconds: 120));
    _isHandlingTap = false;
  }

  Future<bool> _onWillPop() async {
    final navigator = _navigatorKeys[_currentIndex].currentState;

    if (navigator != null && navigator.canPop()) {
      navigator.pop();
      return false;
    }

    if (_currentIndex != 0) {
      setState(() => _currentIndex = 0);
      return false;
    }

    return true;
  }

  Widget _buildTabNavigator(int index, String rootRoute) {
    return Offstage(
      offstage: _currentIndex != index,
      child: Navigator(
        key: _navigatorKeys[index],

        // ✅ ROOT ROUTE CREATED ONLY ONCE
        onGenerateInitialRoutes: (_, __) {
          return [
            AppRouter.generateRoute(
              RouteSettings(name: rootRoute),
            ),
          ];
        },

        onGenerateRoute: AppRouter.generateRoute,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Stack(
          children: [
            _buildTabNavigator(0, AppRoutes.home),
            _buildTabNavigator(1, AppRoutes.settings),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onTabSelected,
          type: BottomNavigationBarType.fixed,
          selectedItemColor:
          isDark ? Colors.white : const Color(0xFF0A185B),
          unselectedItemColor: Colors.grey.shade500,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home_outlined),
              activeIcon: const Icon(Icons.home),
              label: t.translate('bottom_nav_home'),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.settings_outlined),
              activeIcon: const Icon(Icons.settings),
              label: t.translate('bottom_nav_settings'),
            ),
          ],
        ),
      ),
    );
  }
}
