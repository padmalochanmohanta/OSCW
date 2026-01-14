import 'package:flutter/material.dart';
import '../../../../core/localization/app_localizations.dart';

class ThemeSelectorRow extends StatelessWidget {
  final String selected;
  final ValueChanged<String?> onChanged;

  const ThemeSelectorRow({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🎨 ICON
            Icon(
              Icons.color_lens_outlined,
              size: 30,
              color: theme.colorScheme.primary,
            ),

            const SizedBox(width: 16),

            /// 📋 OPTIONS
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t.translate("select_theme"),
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 8),

                  RadioListTile<String>(
                    contentPadding: EdgeInsets.zero,
                    title: Text(t.translate("theme_light")),
                    value: 'light',
                    groupValue: selected,
                    onChanged: onChanged,
                  ),

                  RadioListTile<String>(
                    contentPadding: EdgeInsets.zero,
                    title: Text(t.translate("theme_dark")),
                    value: 'dark',
                    groupValue: selected,
                    onChanged: onChanged,
                  ),

                  RadioListTile<String>(
                    contentPadding: EdgeInsets.zero,
                    title: Text(t.translate("theme_system")),
                    value: 'system',
                    groupValue: selected,
                    onChanged: onChanged,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
