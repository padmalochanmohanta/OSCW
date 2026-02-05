import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entity/track_complaint_entity.dart';
import '../../../domain/usecase/search_complaint_usecase.dart';

part 'track_complaint_event.dart';
part 'track_complaint_state.dart';

class TrackComplaintBloc extends Bloc<TrackComplaintEvent, TrackComplaintState> {
  final SearchComplaintUseCase searchComplaintUseCase;

  TrackComplaintBloc(this.searchComplaintUseCase) : super(TrackComplaintInitial()) {

    // Handle TrackComplaintFetch event (fetching the complaint)
    on<TrackComplaintFetch>((event, emit) async {
      emit(TrackComplaintLoading());
      try {
        // Fetch the complaint using the provided search criteria
        final complaint = await searchComplaintUseCase(
          complaintId: event.complaintId,
          referenceNo: event.referenceNo,
          phoneNumber: event.phoneNumber,
        );

        // Debugging logs
        print('🔹 Complaint fetched: ${complaint.searchValue}');
        print('🔹 Timeline: ${complaint.timeline}');

        // If the complaint timeline is empty, emit TrackComplaintEmpty state
        if (complaint.timeline.isEmpty) {
          emit(TrackComplaintEmpty());
        } else {
          // Otherwise, emit the TrackComplaintLoaded state with the fetched complaint data
          emit(TrackComplaintLoaded(complaint: complaint));
        }
      } catch (e) {
        // If any error occurs (e.g., network failure or invalid response), emit the error state
        print('🔹 Bloc Error: $e');
        emit(TrackComplaintError(message: e.toString()));
      }
    });

    // Handle TrackComplaintReset event (reset the state)
    on<TrackComplaintReset>((event, emit) {
      // Emit initial state to reset the bloc state
      emit(TrackComplaintInitial());
    });
  }
}
