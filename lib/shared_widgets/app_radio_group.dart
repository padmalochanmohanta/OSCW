import 'package:flutter/material.dart';
import '../core/localization/app_localizations.dart';
import '../core/theme/app_text_styles.dart';

// =====================================================
// COMMON RADIO BUTTON GROUP (YES / NO) – WORKING
// =====================================================
class AppRadioGroup extends StatefulWidget {
  final String labelKey;

  const AppRadioGroup({
    super.key,
    required this.labelKey,
  });

  @override
  State<AppRadioGroup> createState() => _AppRadioGroupState();
}

class _AppRadioGroupState extends State<AppRadioGroup> {
  bool? _value; // yes / no

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.translate(widget.labelKey),
            style: AppTextStyles.label,
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Radio<bool>(
                value: true,
                groupValue: _value,
                onChanged: (val) {
                  setState(() => _value = val);
                },
              ),
              Text(t.translate('yes')),
              const SizedBox(width: 12),
              Radio<bool>(
                value: false,
                groupValue: _value,
                onChanged: (val) {
                  setState(() => _value = val);
                },
              ),
              Text(t.translate('no')),
            ],
          ),
        ],
      ),
    );
  }
}
