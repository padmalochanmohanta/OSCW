

import 'package:oscw/features/complaint/data/datasource/track_complaint_remote_ds.dart';
import 'package:oscw/features/complaint/domain/entity/track_complaint_entity.dart';
import 'package:oscw/features/complaint/domain/repository/track_complaint_repository.dart';


class TrackComplaintRepositoryImpl implements TrackComplaintRepository {
  final TrackComplaintRemoteDataSource remoteDataSource;

  TrackComplaintRepositoryImpl(this.remoteDataSource);

  @override
  Future<ComplaintEntity> searchComplaint({
    String? referenceNo,
    String? complaintId,
    String? phoneNumber,
  }) {
    return remoteDataSource.searchComplaint(
      referenceNo: referenceNo,
      complaintId: complaintId,
      phoneNumber: phoneNumber,
    );
  }
}
