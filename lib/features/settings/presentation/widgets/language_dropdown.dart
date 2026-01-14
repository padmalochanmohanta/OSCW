import 'package:flutter/material.dart';
import '../../../../core/localization/app_localizations.dart';

class LanguageSelectorRow extends StatelessWidget {
  final String selected;
  final ValueChanged<String?> onChanged;

  const LanguageSelectorRow({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            _buildLanguageOption(
              context,
              "en",
              "English",
              "🇬🇧",
            ),
            _buildLanguageOption(
              context,
              "hi",
              "हिंदी",
              "🇮🇳",
            ),
            _buildLanguageOption(
              context,
              "or",
              "ଓଡ଼ିଆ",
              "🌾",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageOption(
      BuildContext context, String code, String title, String flagEmoji) {
    return RadioListTile<String>(
      title: Row(
        children: [
          Text(flagEmoji, style: const TextStyle(fontSize: 22)),
          const SizedBox(width: 12),
          Text(title),
        ],
      ),
      value: code,
      groupValue: selected,
      onChanged: onChanged,
    );
  }
}
