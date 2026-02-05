import 'package:flutter/material.dart';
import '../core/localization/app_localizations.dart';
import '../core/theme/app_text_styles.dart';

// =====================================================
// COMMON RADIO BUTTON GROUP (YES / NO) – WORKING
// =====================================================
// class AppRadioGroup extends StatefulWidget {
//   final String labelKey;
//   final void Function(bool?) onChanged; // ✅ NEW

//   const AppRadioGroup({
//     super.key,
//     required this.labelKey,
//     required this.onChanged,
//   });

//   @override
//   State<AppRadioGroup> createState() => _AppRadioGroupState();
// }

// class _AppRadioGroupState extends State<AppRadioGroup> {
//   bool? _value;

//   @override
//   Widget build(BuildContext context) {
//     final t = AppLocalizations.of(context);

//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(t.translate(widget.labelKey), style: AppTextStyles.label),
//           Row(
//             children: [
//               Radio<bool>(
//                 value: true,
//                 groupValue: _value,
//                 onChanged: (val) {
//                   setState(() => _value = val);
//                   widget.onChanged(val); // ✅ PASS TO UI
//                 },
//               ),
//               Text(t.translate('yes')),
//               Radio<bool>(
//                 value: false,
//                 groupValue: _value,
//                 onChanged: (val) {
//                   setState(() => _value = val);
//                   widget.onChanged(val); 
//                 },
//               ),
//               Text(t.translate('no')),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

class AppRadioGroup extends StatelessWidget {
  final String labelKey;
  final bool? value;
  final void Function(bool?) onChanged;

  const AppRadioGroup({
    super.key,
    required this.labelKey,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(t.translate(labelKey), style: AppTextStyles.label),
          Row(
            children: [
              Radio<bool>(
                value: true,
                groupValue: value,
                onChanged: onChanged,
              ),
              Text(t.translate('yes')),
              Radio<bool>(
                value: false,
                groupValue: value,
                onChanged: onChanged,
              ),
              Text(t.translate('no')),
            ],
          ),
        ],
      ),
    );
  }
}

