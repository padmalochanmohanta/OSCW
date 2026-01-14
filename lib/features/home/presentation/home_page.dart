import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/internet/internet_bloc.dart';
import '../../../../core/internet/internet_state.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../routes/app_routes.dart';

import '../../../../shared_widgets/app_image.dart';
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

  /// 🔁 Route mapping (NO UI CHANGE)
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

    return Scaffold(
      appBar: AppAppBar(
        title: t.translate("home_title"),
      ),
      body: Column(
        children: [
          /// 🌐 INTERNET STATUS
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
              child: FutureBuilder<List<MobileMenuModel>>(
                future: _menuFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Padding(
                      padding: EdgeInsets.all(24),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  if (!snapshot.hasData || snapshot.hasError) {
                    return const SizedBox();
                  }

                  final menus = snapshot.data!;

                  /// 🔹 Banner from API (menuName == Banner)
                  final banner = menus.firstWhere(
                        (e) => e.menuName == 'Banner',
                    orElse: () => MobileMenuModel(
                      slNo: 0,
                      menuName: '',
                      menuImage: '',
                      imageUrl: AppImages.banner,
                    ),
                  );

                  /// 🔹 Grid menus (exclude Banner)
                  final gridMenus =
                  menus.where((e) => e.menuName != 'Banner').toList();

                  return Column(
                    children: [
                      /// ================= BANNER =================
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            banner.imageUrl,
                            height: 160,
                            width: double.infinity,
                            fit: BoxFit.fill,
                            loadingBuilder: (context, child, progress) {
                              if (progress == null) return child;
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                height: 160,
                                alignment: Alignment.center,
                                child: const Icon(Icons.image_not_supported),
                              );
                            },
                          ),
                        ),
                      ),


                      /// ================= GRID =================
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics:
                          const NeverScrollableScrollPhysics(),
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

                            return _homeAction(
                              context,
                              title: menu.menuName,
                              imageUrl: menu.imageUrl,
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  _routeFromMenu(menu.menuName),
                                );
                              },
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 20),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================= CARD (UI UNCHANGED) =================
  Widget _homeAction(
      BuildContext context, {
        required String title,
        required String imageUrl,
        required VoidCallback onTap,
      }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
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
              Theme.of(context).primaryColor.withOpacity(0.12),
              child: Image.network(
                imageUrl,
                width: 32,
                height: 32,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) {
                  return const Icon(Icons.image_not_supported, size: 24);
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
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
