import 'package:flutter/material.dart';
import 'package:oscw/core/constants/app_images.dart';
import 'package:oscw/features/home/data/models/mobile_menu_model.dart';
import 'package:oscw/routes/app_routes.dart';
import 'package:oscw/shared_widgets/app_image.dart';

class HomeMenuHelper {
  /// 🔁 Route mapping
  static String routeFromMenu(String name) {
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

  /// 📋 Drawer vertical list with header + selected highlight + theme aware
  static Widget buildDrawerMenu({
    required BuildContext context,
    required List<MobileMenuModel> menus,
    required String langCode,
    String? selectedMenuName,
    ThemeMode? themeMode, // optional, for key/fresh rebuild
  }) {
    final drawerMenus = menus.where((e) => e.menuName != 'Banner').toList();
    final isDark = themeMode == ThemeMode.dark || 
        (themeMode == ThemeMode.system && Theme.of(context).brightness == Brightness.dark);

    // Colors
    final headerColor = isDark ? const Color(0xFF1A1D23) : Theme.of(context).primaryColor.withOpacity(0.9);
    final selectedBgColor = isDark ? Colors.white10 : Theme.of(context).primaryColor.withOpacity(0.1);
    final unselectedTextColor = isDark ? Colors.white : Colors.black87;
    final selectedTextColor = Theme.of(context).primaryColor;
    final trailingIconColor = isDark ? Colors.white70 : Colors.black45;

    return Column(
      children: [
        // ================= DRAWER HEADER =================
        DrawerHeader(
          key: ValueKey(themeMode), // rebuilds when theme changes
          decoration: BoxDecoration(
            color: headerColor,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 56,
                height: 56,
                child: AppImage(path: AppImages.logo),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  'OSCW',
                  style: TextStyle(
                    color: isDark ? Colors.white : Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),

        // ================= MENU ITEMS =================
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.only(top: 0),
            itemCount: drawerMenus.length,
            separatorBuilder: (_, __) => Divider(
              height: 1,
              color: isDark ? Colors.white10 : Colors.grey[300],
            ),
            itemBuilder: (context, index) {
              final menu = drawerMenus[index];
              final title = langCode == 'or'
                  ? (menu.odiaMenuName ?? menu.menuName)
                  : menu.menuName;

              final isSelected = selectedMenuName == menu.menuName;

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundColor: isDark
                        ? Colors.white
                        : Colors.black12,
                    child: Image.network(
                      menu.imageUrl,
                      width: 32,
                      height: 32,
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) {
                        return Icon(
                          Icons.image_not_supported,
                          size: 24,
                          color: isDark ? Colors.white70 : Colors.black45,
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
                  title: Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: isSelected ? selectedTextColor : unselectedTextColor,
                    ),
                  ),
                  trailing: isSelected
                      ? Icon(Icons.check, color: selectedTextColor)
                      : Icon(Icons.chevron_right, color: trailingIconColor),
                  tileColor: isSelected ? selectedBgColor : null,
                  onTap: () {
                    Navigator.pop(context); // close drawer
                    Navigator.pushNamed(
                      context,
                      routeFromMenu(menu.menuName),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
