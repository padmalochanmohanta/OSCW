

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oscw/features/complaint/domain/usecase/get_complain_registration.dart';
import 'package:oscw/features/complaint/presentation/bloc/complaint_registration/complaint_event.dart';
import 'package:oscw/features/complaint/presentation/bloc/complaint_registration/complaint_state.dart';



class ComplaintBloc extends Bloc<ComplaintEvent, ComplaintState> {
  final SubmitComplaintUseCase submitComplaint;

  ComplaintBloc({required this.submitComplaint}) : super(ComplaintInitial()) {
    on<SubmitComplaintEvent>((event, emit) async {
      emit(ComplaintLoading());

      try {
        // Call the submitComplaint method which makes the API request
        final response = await submitComplaint(event.request);

        // Emit success state with the response model
        emit(ComplaintSuccess(response));
      } catch (e) {
        // Handle errors and emit failure state
        emit(ComplaintFailure(e.toString()));
      }
    });
  }
}
