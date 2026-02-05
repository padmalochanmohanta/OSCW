// States
import 'package:equatable/equatable.dart';
import 'package:oscw/features/complaint/data/models/complain_dropdown_item.dart';

abstract class DropdownState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DropdownInitial extends DropdownState {}
class DropdownLoading extends DropdownState {}
class DropdownLoaded extends DropdownState {
  final List<ComplainDropdownItem> items;
  DropdownLoaded(this.items);

  @override
  List<Object?> get props => [items];
}
class DropdownError extends DropdownState {
  final String message;
  DropdownError(this.message);

  @override
  List<Object?> get props => [message];
}