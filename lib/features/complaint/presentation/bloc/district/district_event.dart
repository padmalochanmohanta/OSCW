// Events
import 'package:equatable/equatable.dart';

abstract class DistrictEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadDistricts extends DistrictEvent {}