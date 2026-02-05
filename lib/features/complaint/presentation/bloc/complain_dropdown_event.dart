// Events
import 'package:equatable/equatable.dart';

abstract class DropdownEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadDropdownItems extends DropdownEvent {}
