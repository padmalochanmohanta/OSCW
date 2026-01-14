class AppUrls {
  // 🔹 Base URL
  static const String baseUrl = 'http://192.168.3.102:86';

  // ================= AUTH =================

  /// Generate OTP
  static const String generateOtp = '$baseUrl/api/generate-otp';

  /// Verify OTP
  static const String verifyOtp = '$baseUrl/api/verify-otp';

  // ================= HELPLINE =================

  /// Get Helpline Numbers & Names
  static const String helplineNumbers =
      '$baseUrl/api/HelplineNumbers&Names';

  // ================= HOME =================

  /// Get Mobile Menus for Home Screen
  static const String mobileMenus =
      '$baseUrl/api/MobileMenus';
}
