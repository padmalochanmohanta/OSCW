import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../core/theme/app_text_styles.dart';


// class AppTextFormField extends StatelessWidget {
//   final String label;
//   final bool readOnly;
//   final bool enabled; 
//   final int maxLines;
//   final Widget? suffixIcon;
//   final TextEditingController? controller;
//   final VoidCallback? onTap;
//   final String? Function(String?)? validator;
//   final int? maxLength;  
//   final TextInputType keyboardType;  

//   const AppTextFormField({
//     super.key,
//     required this.label,
//     this.readOnly = false,
//     this.enabled = true, 
//     this.maxLines = 1,
//     this.suffixIcon,
//     this.controller,
//     this.onTap,
//     this.validator,
//     this.maxLength,  
//     this.keyboardType = TextInputType.text,  
//   });

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12),
//       child: TextFormField(
//         controller: controller,
//         readOnly: readOnly,
//         enabled: enabled, 
//         maxLines: maxLines,
//         onTap: onTap,
//         validator: validator,
//         style: enabled
//             ? theme.textTheme.bodyMedium
//             : theme.textTheme.bodyMedium?.copyWith(
//                 color: theme.disabledColor,
//               ),
//         keyboardType: keyboardType,  
//         decoration: InputDecoration(
//           labelText: label,
//           labelStyle: AppTextStyles.bodySmall,
//           border: const OutlineInputBorder(),
//           suffixIcon: suffixIcon,

//           // ✅ Disabled look
//           filled: !enabled,
//           fillColor: !enabled
//               ? theme.disabledColor.withOpacity(0.08)
//               : null,

        
//         ),
//         inputFormatters: maxLength != null
//             ? [
//                 LengthLimitingTextInputFormatter(maxLength),
//               ]
//             : null,
//       ),
//     );
//   }
// }



class AppTextFormField extends StatelessWidget {
  final String label;
  final bool readOnly;
  final bool enabled;
  final int maxLines;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final VoidCallback? onTap;
  final String? Function(String?)? validator;
  final int? maxLength;
  final TextInputType keyboardType;
  final FocusNode? focusNode; // Pass FocusNode here

  const AppTextFormField({
    super.key,
    required this.label,
    this.readOnly = false,
    this.enabled = true,
    this.maxLines = 1,
    this.suffixIcon,
    this.controller,
    this.onTap,
    this.validator,
    this.maxLength,
    this.keyboardType = TextInputType.text,
    this.focusNode, // Initialize FocusNode here
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        readOnly: readOnly,
        enabled: enabled,
        maxLines: maxLines,
        focusNode: focusNode, // Use the passed FocusNode here
        onTap: onTap,
        validator: validator,
        style: enabled
            ? theme.textTheme.bodyMedium
            : theme.textTheme.bodyMedium?.copyWith(color: theme.disabledColor),
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: AppTextStyles.bodySmall,
          border: const OutlineInputBorder(),
          suffixIcon: suffixIcon,
          filled: !enabled,
          fillColor: !enabled ? theme.disabledColor.withOpacity(0.08) : null,
        ),
        inputFormatters: maxLength != null
            ? [LengthLimitingTextInputFormatter(maxLength)]
            : null,
      ),
    );
  }
}
