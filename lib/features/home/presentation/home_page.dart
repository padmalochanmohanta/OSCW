import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oscw/core/theme/theme_bloc.dart';
import 'package:oscw/core/theme/theme_state.dart';
import 'package:oscw/shared_widgets/home_menu_helper.dart';

import '../../../../core/internet/internet_bloc.dart';
import '../../../../core/internet/internet_state.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../routes/app_routes.dart';
import '../../../../shared_widgets/no_internet_banner.dart';
import '../../../shared_widgets/app_app_bar.dart';

import '../data/home_remote_datasource.dart';
import '../data/home_repository_impl.dart';
import '../data/models/mobile_menu_model.dart';
import '../domain/home_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeRepository _repo;
  late Future<List<MobileMenuModel>> _menuFuture;

  @override
  void initState() {
    super.initState();
    _repo = HomeRepositoryImpl(HomeRemoteDataSource());
    _menuFuture = _repo.getMobileMenus();
  }

  /// Creates a fresh future per theme change
  Future<List<MobileMenuModel>> _menuFutureForTheme(ThemeMode themeMode) {
    return _repo.getMobileMenus();
  }

  /// Route mapping
  String _routeFromMenu(String name) {
    switch (name) {
      case 'OSCW Toll Free Number':
        return AppRoutes.tollFree;
      case 'Give a Complaint':
        return AppRoutes.registerComplaint;
      case 'Track Your Complaint':
        return AppRoutes.trackComplaint;
      case 'Complaint via Whatsapp':
        return AppRoutes.whatsappComplaint;
      case 'Helpline Numbers':
        return AppRoutes.helpline;
      case 'Safety Tips':
        return AppRoutes.safetyTips;
      default:
        return AppRoutes.home;
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final langCode = Localizations.localeOf(context).languageCode;

    return Scaffold(
      drawer: _buildMenuDrawer(context, langCode),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(64),
        child: Builder(
          builder: (context) {
            return AppAppBar(
              title: t.translate("home_title"),
              onMenuTap: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      body: Column(
        children: [
          /// INTERNET STATUS
          BlocBuilder<InternetBloc, InternetState>(
            builder: (context, state) {
              return NoInternetBanner(
                visible: !state.isConnected,
                message: t.translate("no_internet"),
              );
            },
          ),
          Expanded(
            child: SingleChildScrollView(
              child: BlocBuilder<ThemeBloc, ThemeState>(
                builder: (context, themeState) {
                  // ✅ Get theme from ThemeBloc
                  final bool isDark = themeState.themeMode == ThemeMode.dark;
                  final menuFuture = _menuFutureForTheme(themeState.themeMode);

                  return FutureBuilder<List<MobileMenuModel>>(
                    key: ValueKey(themeState.themeMode),
                    future: menuFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Padding(
                          padding: EdgeInsets.all(24),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                      if (snapshot.hasError) {
                        return Padding(
                          padding: const EdgeInsets.all(16),
                          child: Center(
                            child: Text(
                              'Failed to load menus. Please try again.',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  ),
                            ),
                          ),
                        );
                      }

                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.all(16),
                          child: Center(
                            child: Text(
                              'No menus available at the moment.',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                            ),
                          ),
                        );
                      }

                      final menus = snapshot.data!;
                      final banner = menus.firstWhere(
                        (e) => e.menuName == 'Banner',
                        orElse: () => MobileMenuModel(
                          slNo: 0,
                          menuName: '',
                          menuImage: '',
                          imageUrl: AppImages.banner,
                        ),
                      );

                      final gridMenus =
                          menus.where((e) => e.menuName != 'Banner').toList();

                      return Column(
                        children: [
                          // -------- BANNER --------
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.network(
                                banner.imageUrl,
                                height: 160,
                                width: double.infinity,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),

                          // -------- GRID --------
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 1.15,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                              ),
                              itemCount: gridMenus.length,
                              itemBuilder: (context, index) {
                                final menu = gridMenus[index];
                                final title = langCode == 'or'
                                    ? (menu.odiaMenuName ?? menu.menuName)
                                    : menu.menuName;

                                return _homeAction(
                                  context,
                                  title: title,
                                  imageUrl: menu.imageUrl,
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      _routeFromMenu(menu.menuName),
                                    );
                                  },
                                  isDark: isDark, // ✅ Pass theme state
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Custom card for grid
  Widget _homeAction(
    BuildContext context, {
    required String title,
    required String imageUrl,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1A1D23) : Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? Colors.black.withOpacity(0.25)
                  : Colors.grey.withOpacity(0.15),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor:
                  isDark ? Colors.white : Colors.black12,
              child: Image.network(
                imageUrl,
                width: 32,
                height: 32,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) {
                  return Icon(
                    Icons.image_not_supported,
                    size: 24,
                    color: isDark ? Colors.white70 : Colors.black54,
                  );
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Drawer menu
  Widget _buildMenuDrawer(BuildContext context, String langCode) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return Drawer(
          child: SafeArea(
            child: FutureBuilder<List<MobileMenuModel>>(
              key: ValueKey(themeState.themeMode),
              future: _menuFutureForTheme(themeState.themeMode),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.hasError) {
                  return const Center(child: Text('Menu load failed'));
                }

                final menus = snapshot.data!;

                return HomeMenuHelper.buildDrawerMenu(
                  context: context,
                  menus: menus,
                  langCode: langCode,
                  selectedMenuName: null,
                  themeMode: themeState.themeMode,
                );
              },
            ),
          ),
        );
      },
    );
  }
}
