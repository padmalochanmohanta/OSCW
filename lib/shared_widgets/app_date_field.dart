import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_text_styles.dart';
import 'app_text_form_field.dart';

// =====================================================
// DATE PICKER FIELD (WORKING)
// =====================================================
class AppDateField extends StatefulWidget {
  final String label;

  const AppDateField({
    super.key,
    required this.label,
  });

  @override
  State<AppDateField> createState() => _AppDateFieldState();
}

class _AppDateFieldState extends State<AppDateField> {
  final TextEditingController _controller = TextEditingController();

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      _controller.text = DateFormat('dd/MM/yyyy').format(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppTextFormField(
      label: widget.label,
      controller: _controller,
      readOnly: true,
      onTap: () => _pickDate(context),
      suffixIcon: const Icon(
        Icons.calendar_today,
        size: 18,
        color: AppColors.primary,
      ),
    );
  }
}
