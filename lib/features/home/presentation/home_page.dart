import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/internet/internet_bloc.dart';
import '../../../../core/internet/internet_state.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../routes/app_routes.dart';

import '../../../../shared_widgets/app_icon.dart';
import '../../../../shared_widgets/app_image.dart';
import '../../../../shared_widgets/no_internet_banner.dart';
import '../../../shared_widgets/app_app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppAppBar(
        title: t.translate("home_title"),
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
              child: Column(
                children: [
                  // ================= BANNER =================
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: AppImage(
                      path: AppImages.banner,
                      height: 160,
                      width: double.infinity,
                      fit: BoxFit.fill,
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),

                  // ================= GRID =================
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: GridView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.15,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                      ),
                      children: [
                        _homeAction(
                          context,
                          iconPath: AppIcons.tollFree,
                          title: t.translate("toll_free_number"),
                          color: Colors.deepPurple,
                          onTap: () =>
                              Navigator.pushNamed(context, AppRoutes.tollFree),
                        ),
                        _homeAction(
                          context,
                          iconPath: AppIcons.complaint,
                          title: t.translate("give_complaint"),
                          color: Colors.red,
                          onTap: () => Navigator.pushNamed(
                              context, AppRoutes.registerComplaint),
                        ),
                        _homeAction(
                          context,
                          iconPath: AppIcons.complaint,
                          title: t.translate("track_complaint"),
                          color: Colors.blue,
                          onTap: () => Navigator.pushNamed(
                              context, AppRoutes.trackComplaint),
                        ),
                        _homeAction(
                          context,
                          iconPath: AppIcons.whatsapp,
                          title: t.translate("complaint_whatsapp"),
                          color: Colors.green,
                          onTap: () => Navigator.pushNamed(
                              context, AppRoutes.whatsappComplaint),
                        ),
                        _homeAction(
                          context,
                          iconPath: AppIcons.support,
                          title: t.translate("helpline_number"),
                          color: Colors.orange,
                          onTap: () =>
                              Navigator.pushNamed(context, AppRoutes.helpline),
                        ),
                        _homeAction(
                          context,
                          iconPath: AppIcons.safety,
                          title: t.translate("safety_tips"),
                          color: Colors.teal,
                          onTap: () =>
                              Navigator.pushNamed(context, AppRoutes.safetyTips),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================= CARD =================
  Widget _homeAction(
      BuildContext context, {
        required String iconPath,
        required String title,
        String? subtitle,
        required Color color,
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
              backgroundColor: color.withOpacity(0.12),
              child: AppIcon(
                path: iconPath,
                size: 32,
                color: color,
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
            if (subtitle != null) ...[
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade600,
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
