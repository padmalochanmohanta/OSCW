import 'package:flutter/material.dart';

import '../core/constants/app_images.dart';
import '../core/theme/app_colors.dart';
import 'app_image.dart';

// class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final String title;
//   final String? subtitle;
//   final bool showBack;
//   final VoidCallback? onMenuTap;

//   const AppAppBar({
//     super.key,
//     required this.title,
//     this.subtitle,
//     this.showBack = false,
//     this.onMenuTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       automaticallyImplyLeading: false,
//       elevation: 0,
//       backgroundColor: Colors.white,

//       // ================= LEFT =================
//       leading: showBack
//           ? IconButton(
//         icon: const Icon(Icons.arrow_back, color: AppColors.textDark),
//         onPressed: () => Navigator.pop(context),
//       )
//           : Padding(
//         padding: const EdgeInsets.only(left: 12),
//         child: GestureDetector(
//           onTap: onMenuTap,
//           child: Container(
//             padding: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               color: AppColors.primary,
//               borderRadius: BorderRadius.circular(6),
//             ),
//             child: const Icon(Icons.menu, color: AppColors.textLight),
//           ),
//         ),
//       ),

//       // ================= TITLE + SUBTITLE =================
//       title: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(
//             title,
//             style: const TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 18,
//               color: AppColors.textDark,
//             ),
//             overflow: TextOverflow.ellipsis,
//           ),
//           if (subtitle != null)
//             Text(
//               subtitle!,
//               style: const TextStyle(
//                 fontSize: 12,
//                 color: AppColors.textDark,
//               ),
//             ),
//         ],
//       ),

//       // ================= RIGHT LOGO =================
//       actions: [
//         Padding(
//           padding: const EdgeInsets.only(right: 12),
//           child: Center(
//             child: AppImage(path: AppImages.logo),
//           ),
//         ),
//       ],
//     );
//   }

//   @override
//   Size get preferredSize => const Size.fromHeight(64);
// }


class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? subtitle;
  final bool showBack;
  final VoidCallback? onMenuTap;

  const AppAppBar({
    super.key,
    required this.title,
    this.subtitle,
    this.showBack = false,
    this.onMenuTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Colors based on theme
    final bgColor = isDark ? const Color(0xFF1A1D23) : Colors.white;
    final textColor = isDark ? Colors.white : AppColors.textDark;
    final iconColor = isDark ? Colors.white : AppColors.textDark;
    final menuBgColor = isDark ? Colors.blueGrey : AppColors.primary;
    final menuIconColor = Colors.white;

    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: bgColor,

      // ================= LEFT =================
      leading: showBack
          ? IconButton(
              icon: Icon(Icons.arrow_back, color: iconColor),
              onPressed: () => Navigator.pop(context),
            )
          : Padding(
              padding: const EdgeInsets.only(left: 12),
              child: GestureDetector(
                onTap: onMenuTap,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: menuBgColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(Icons.menu, color: menuIconColor),
                ),
              ),
            ),

      // ================= TITLE + SUBTITLE =================
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: textColor,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          if (subtitle != null)
            Text(
              subtitle!,
              style: TextStyle(
                fontSize: 12,
                color: textColor.withOpacity(0.8),
              ),
            ),
        ],
      ),

      // ================= RIGHT LOGO =================
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Center(
            child: AppImage(path: AppImages.logo),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(64);
}
