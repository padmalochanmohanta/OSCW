
import 'package:equatable/equatable.dart';
import 'package:oscw/features/complaint/data/models/complain_registration_model.dart';

abstract class ComplaintEvent extends Equatable {
  const ComplaintEvent();

  @override
  List<Object> get props => [];
}

class SubmitComplaintEvent extends ComplaintEvent {
  final ComplaintRequestModel request;

  const SubmitComplaintEvent(this.request);

  @override
  List<Object> get props => [request];
}
