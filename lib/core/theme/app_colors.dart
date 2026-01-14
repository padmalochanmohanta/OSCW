// lib/core/theme/app_colors.dart
import 'package:flutter/material.dart';

class AppColors {
  // ================= BRAND COLORS =================
  static const Color orange = Color(0xFF0A185B); // Navy Blue – Govt standard
  static const Color accent = Color(0xFFF5C518);  // Gold (use sparingly)
  static const Color primary = Color(0xFFFF6F00);  // Govt Orange (alerts/CTA)

  // ================= LIGHT THEME =================
  static const Color backgroundLight = Color(0xFFF6F7FB); // soft grey
  static const Color surfaceLight = Colors.white;
  static const Color surfaceVariantLight = Color(0xFFF0F2F6);

  static const Color textDark = Color(0xFF1A1A1A);
  static const Color textMuted = Color(0xFF6B7280); // subtitles, hints

  // ================= DARK THEME =================
  static const Color backgroundDark = Color(0xFF0F1115); // deep dark
  static const Color surfaceDark = Color(0xFF1A1D23);
  static const Color surfaceVariantDark = Color(0xFF22262E);

  static const Color textLight = Color(0xFFFFFFFF);
  static const Color textMutedDark = Color(0xFF9CA3AF);

  // ================= STATUS COLORS =================
  static const Color error = Color(0xFFD32F2F);
  static const Color success = Color(0xFF2E7D32);
  static const Color warning = Color(0xFFF9A825);
  static const Color info = Color(0xFF0288D1);
}
