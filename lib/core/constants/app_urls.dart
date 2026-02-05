class AppUrls {
  // 🔹 Base URL
  static const String baseUrl = 'http://192.168.3.176:86';
  //static const String baseUrl = 'https://oscwcms.addsofttech.com/CMSAPI';

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

/// Get Complaints
  static const String typeofcompalins =
      '$baseUrl/api/TypeOfComplains';
      
      /// Get Districts
  static const String district ='$baseUrl/api/District';
            /// registration
  static const String registration ='$baseUrl/api/OnlineComplaint';
  // Tracking
  static const String complaintTracking = '$baseUrl/api/complaint-tracking';
  // Tracking
  static const String safetytips = '$baseUrl/api/Content';
}


// Small helper to convert number to Odia digits
  String odiaNumber(int n) {
    const odiaDigits = ['୦','୧','୨','୩','୪','୫','୬','୭','୮','୯'];
    return n.toString().split('').map((d) => odiaDigits[int.parse(d)]).join();
  }
