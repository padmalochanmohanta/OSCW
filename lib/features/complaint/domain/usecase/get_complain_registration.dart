

import 'package:oscw/features/complaint/data/models/complain_registration_model.dart';
import 'package:oscw/features/complaint/data/models/complaint_response_model.dart';
import 'package:oscw/features/complaint/domain/repository/complain_registration_repo.dart';

class SubmitComplaintUseCase {
  final ComplaintRepository repository;

  SubmitComplaintUseCase(this.repository);

  Future<ComplaintResponseModel> call(ComplaintRequestModel request) {
    return repository.submitComplaint(request);
  }
}
