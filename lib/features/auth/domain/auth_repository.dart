import '../data/models/generate_otp_response.dart';

abstract class AuthRepository {
  Future<GenerateOtpResponse> generateOtp(String mobileNo);
}
