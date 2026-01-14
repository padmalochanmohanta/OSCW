import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../core/constants/app_urls.dart';
import 'models/generate_otp_response.dart';

class AuthRemoteDataSource {
  Future<GenerateOtpResponse> generateOtp(String mobileNo) async {
    final response = await http.post(
      Uri.parse(AppUrls.generateOtp),
      headers: {
        'Content-Type': 'application/json',
        'accept': '*/*',
      },
      body: jsonEncode({
        'mobileNo': mobileNo,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> json =
      jsonDecode(response.body);
      return GenerateOtpResponse.fromJson(json); // ✅ FULL BODY
    } else {
      throw Exception('Failed to generate OTP');
    }
  }
}
