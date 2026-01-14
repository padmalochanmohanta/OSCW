import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/localization/app_localizations.dart';
import '../../../../core/di/injector.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../routes/app_routes.dart';
import '../../../../shared_widgets/app_app_bar.dart';
import '../../../../shared_widgets/app_icon.dart';

import '../viewmodel/settings_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<SettingsBloc>(),
      child: const _SettingsBody(),
    );
  }
}

class _SettingsBody extends StatelessWidget {
  const _SettingsBody();

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppAppBar(
        title: t.translate("settings_title"),
      ),
      body: BlocBuilder<SettingsBloc, Map<String, String>>(
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                t.translate("settings_subtitle"),
                style: theme.textTheme.bodySmall,
              ),

              const SizedBox(height: 20),

              /// 🎨 THEME
              _SettingsTile(
                icon: AppIcons.settings,
                title: t.translate("select_theme"),
                subtitle: _themeLabel(state["theme"]!, t),
                onTap: () =>
                    _showThemeSheet(context, state["theme"]!, t),
              ),

              const SizedBox(height: 12),

              /// 🌍 LANGUAGE
              _SettingsTile(
                icon: AppIcons.language,
                title: t.translate("select_language"),
                subtitle: _languageLabel(state["language"]!),
                onTap: () =>
                    _showLanguageSheet(context, state["language"]!, t),
              ),

              const SizedBox(height: 12),

              /// 🚪 LOGOUT
              _SettingsTile(
                icon: AppIcons.logout,
                title: t.translate("logout"),
                onTap: () async {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.clear();

                  if (!context.mounted) return;

                  Navigator.of(context, rootNavigator: true)
                      .pushNamedAndRemoveUntil(
                    AppRoutes.login,
                        (_) => false,
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }

  // ================= THEME SHEET =================
  void _showThemeSheet(
      BuildContext context, String selected, AppLocalizations t) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return _BottomSheet(
          title: t.translate("choose_theme"),
          children: [
            _radioTile(context, t.translate("system_default"), "system",
                selected, context.read<SettingsBloc>().updateTheme),
            _radioTile(context, t.translate("light"), "light",
                selected, context.read<SettingsBloc>().updateTheme),
            _radioTile(context, t.translate("dark"), "dark",
                selected, context.read<SettingsBloc>().updateTheme),
          ],
        );
      },
    );
  }

  // ================= LANGUAGE SHEET =================
  void _showLanguageSheet(
      BuildContext context, String selected, AppLocalizations t) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return _BottomSheet(
          title: t.translate("choose_language"),
          children: [
            _radioTile(context, "English", "en", selected,
                context.read<SettingsBloc>().updateLanguage),
            _radioTile(context, "हिंदी", "hi", selected,
                context.read<SettingsBloc>().updateLanguage),
            _radioTile(context, "ଓଡ଼ିଆ", "or", selected,
                context.read<SettingsBloc>().updateLanguage),
          ],
        );
      },
    );
  }

  // ================= RADIO TILE =================
  Widget _radioTile(
      BuildContext context,
      String label,
      String value,
      String selected,
      Function(String) onChanged,
      ) {
    return RadioListTile<String>(
      value: value,
      groupValue: selected,
      title: Text(label),
      onChanged: (val) {
        if (val != null) {
          onChanged(val);
          Navigator.pop(context);
        }
      },
    );
  }

  // ================= LABEL HELPERS =================
  String _themeLabel(String key, AppLocalizations t) {
    switch (key) {
      case "light":
        return t.translate("light");
      case "dark":
        return t.translate("dark");
      default:
        return t.translate("system_default");
    }
  }

  String _languageLabel(String key) {
    switch (key) {
      case "hi":
        return "हिंदी";
      case "or":
        return "ଓଡ଼ିଆ";
      default:
        return "English";
    }
  }
}

// =================================================
// SETTINGS TILE (THEME-AWARE GOV STYLE)
// =================================================
class _SettingsTile extends StatelessWidget {
  final String icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;

  const _SettingsTile({
    required this.icon,
    required this.title,
    this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(14),
          boxShadow: isDark
              ? null
              : [
            BoxShadow(
              color: theme.shadowColor.withOpacity(0.08),
              blurRadius: 6,
            ),
          ],
        ),
        child: Row(
          children: [
            /// 🔹 ICON (THEME-COLORED)
            AppIcon(
              path: icon,
              size: 28,
              color: theme.colorScheme.primary,
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.bodyLarge,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      subtitle!,
                      style: theme.textTheme.bodySmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),

            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}

// =================================================
// BOTTOM SHEET WRAPPER (THEME-SAFE)
// =================================================
class _BottomSheet extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _BottomSheet({
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          ...children,
        ],
      ),
    );
  }
}
