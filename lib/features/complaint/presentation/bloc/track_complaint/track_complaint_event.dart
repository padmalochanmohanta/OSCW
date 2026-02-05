part of 'track_complaint_bloc.dart';



abstract class TrackComplaintEvent extends Equatable {
  const TrackComplaintEvent();

  @override
  List<Object?> get props => [];
}

class TrackComplaintFetch extends TrackComplaintEvent {
  final String? complaintId;
  final String? referenceNo;
  final String? phoneNumber;

  const TrackComplaintFetch({this.complaintId, this.referenceNo, this.phoneNumber});

  @override
  List<Object?> get props => [complaintId, referenceNo, phoneNumber];
}
class TrackComplaintReset extends TrackComplaintEvent {}

