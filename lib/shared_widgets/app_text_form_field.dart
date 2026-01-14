import 'package:flutter/material.dart';
import '../core/theme/app_text_styles.dart';

class AppTextFormField extends StatelessWidget {
  final String label;
  final bool readOnly;
  final bool enabled; // ✅ NEW
  final int maxLines;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final VoidCallback? onTap;

  const AppTextFormField({
    super.key,
    required this.label,
    this.readOnly = false,
    this.enabled = true, // ✅ default enabled
    this.maxLines = 1,
    this.suffixIcon,
    this.controller,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        readOnly: readOnly,
        enabled: enabled, // ✅ IMPORTANT
        maxLines: maxLines,
        onTap: onTap,
        style: enabled
            ? theme.textTheme.bodyMedium
            : theme.textTheme.bodyMedium?.copyWith(
          color: theme.disabledColor,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: AppTextStyles.bodySmall,
          border: const OutlineInputBorder(),
          suffixIcon: suffixIcon,

          // ✅ Disabled look
          filled: !enabled,
          fillColor: !enabled
              ? theme.disabledColor.withOpacity(0.08)
              : null,
        ),
      ),
    );
  }
}
