

// States
import 'package:equatable/equatable.dart';
import 'package:oscw/features/complaint/data/models/district_item.dart';

abstract class DistrictState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DistrictInitial extends DistrictState {}
class DistrictLoading extends DistrictState {}
class DistrictLoaded extends DistrictState {
  final List<DistrictItem> items;
  DistrictLoaded(this.items);

  @override
  List<Object?> get props => [items];
}
class DistrictError extends DistrictState {
  final String message;
  DistrictError(this.message);

  @override
  List<Object?> get props => [message];
}


