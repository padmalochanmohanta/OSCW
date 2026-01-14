import '../domain/auth_repository.dart';
import 'auth_remote_datasource.dart';
import 'models/generate_otp_response.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<GenerateOtpResponse> generateOtp(String mobileNo) {
    return remoteDataSource.generateOtp(mobileNo);
  }
}
