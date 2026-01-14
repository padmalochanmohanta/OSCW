class GenerateOtpResponse {
  final String mobileNo;
  final String otp;
  final String message;

  GenerateOtpResponse({
    required this.mobileNo,
    required this.otp,
    required this.message,
  });

  factory GenerateOtpResponse.fromJson(Map<String, dynamic> json) {
    return GenerateOtpResponse(
      mobileNo: json['mobileNo'] ?? '',
      otp: json['otp'] ?? '',
      message: json['message'] ?? '',
    );
  }
}
