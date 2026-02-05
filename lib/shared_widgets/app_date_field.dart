import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'app_text_form_field.dart';

// =====================================================
// DATE PICKER FIELD (WORKING)
// =====================================================
class AppDateField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final TextEditingController? ageController; // Controller for age (optional for DOB)

  const AppDateField({
    super.key,
    required this.label,
    required this.controller,
    this.ageController,
  });

  @override
  State<AppDateField> createState() => _AppDateFieldState();
}

class _AppDateFieldState extends State<AppDateField> {
  Future<void> _pickDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      // Set the date in the controller
      widget.controller.text = DateFormat('dd/MM/yyyy').format(picked);

      // If ageController is provided and it's DOB field, calculate age
      if (widget.ageController != null) {
        final age = _calculateAge(picked);
        widget.ageController?.text = age.toString();
      }
    }
  }

  int _calculateAge(DateTime dob) {
    final now = DateTime.now();
    final age = now.year - dob.year;
    if (now.month < dob.month || (now.month == dob.month && now.day < dob.day)) {
      return age - 1;
    }
    return age;
  }

  @override
  Widget build(BuildContext context) {
    return AppTextFormField(
      label: widget.label,
      controller: widget.controller,
      readOnly: true,
      onTap: () => _pickDate(context),
      suffixIcon: const Icon(Icons.calendar_today, size: 18),
    );
  }
}

String convertToIso8601(String date) {
  try {
    // Parse the date string in 'dd/MM/yyyy' format
    final parsedDate = DateFormat('dd/MM/yyyy').parse(date);
    // Convert it into 'yyyy-MM-dd' format
    return DateFormat('yyyy-MM-dd').format(parsedDate);
  } catch (e) {
    // In case of error, return an empty string or handle the error as needed
    return '';
  }
}


