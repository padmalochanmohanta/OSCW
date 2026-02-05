part of 'track_complaint_bloc.dart';



abstract class TrackComplaintState extends Equatable {
  const TrackComplaintState();

  @override
  List<Object?> get props => [];
}

class TrackComplaintInitial extends TrackComplaintState {}

class TrackComplaintLoading extends TrackComplaintState {}

class TrackComplaintLoaded extends TrackComplaintState {
  final ComplaintEntity complaint;
  const TrackComplaintLoaded({required this.complaint});

  @override
  List<Object?> get props => [complaint];
}

class TrackComplaintEmpty extends TrackComplaintState {}

class TrackComplaintError extends TrackComplaintState {
  final String message;
  const TrackComplaintError({required this.message});

  @override
  List<Object?> get props => [message];
}
