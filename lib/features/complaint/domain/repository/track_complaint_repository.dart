

import 'package:oscw/features/complaint/domain/entity/track_complaint_entity.dart';


abstract class TrackComplaintRepository {
  Future<ComplaintEntity> searchComplaint({
    String? referenceNo,
    String? complaintId,
    String? phoneNumber,
  });
}