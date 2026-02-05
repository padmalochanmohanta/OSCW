

import 'package:oscw/features/complaint/domain/entity/track_complaint_entity.dart';
import 'package:oscw/features/complaint/domain/repository/track_complaint_repository.dart';

class SearchComplaintUseCase {
  final TrackComplaintRepository repository;

  SearchComplaintUseCase(this.repository);

  Future<ComplaintEntity> call({
    String? referenceNo,
    String? complaintId,
    String? phoneNumber,
  }) {
    return repository.searchComplaint(
      referenceNo: referenceNo,
      complaintId: complaintId,
      phoneNumber: phoneNumber,
    );
  }
}
