import 'package:equatable/equatable.dart';
import 'package:oscw/features/complaint/data/models/complaint_response_model.dart';

abstract class ComplaintState extends Equatable {
  const ComplaintState();

  @override
  List<Object?> get props => [];
}

class ComplaintInitial extends ComplaintState {}

class ComplaintLoading extends ComplaintState {}

class ComplaintSuccess extends ComplaintState {
  final ComplaintResponseModel response;

  const ComplaintSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class ComplaintFailure extends ComplaintState {
  final String message;

  const ComplaintFailure(this.message);

  @override
  List<Object?> get props => [message];
}

