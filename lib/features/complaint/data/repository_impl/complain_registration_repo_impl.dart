

import 'package:oscw/features/complaint/data/datasource/complain_regitration_remote_ds.dart';
import 'package:oscw/features/complaint/data/models/complain_registration_model.dart';
import 'package:oscw/features/complaint/data/models/complaint_response_model.dart';
import 'package:oscw/features/complaint/domain/repository/complain_registration_repo.dart';

class ComplaintRepositoryImpl implements ComplaintRepository {
  final ComplaintRemoteDataSource remoteDataSource;

  ComplaintRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ComplaintResponseModel> submitComplaint(ComplaintRequestModel request) {
    return remoteDataSource.submitComplaint(request);
  }
}
