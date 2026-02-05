// Bloc
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oscw/features/complaint/domain/usecase/get_district_usecase.dart';
import 'package:oscw/features/complaint/presentation/bloc/district/district_event.dart';
import 'package:oscw/features/complaint/presentation/bloc/district/district_state.dart';

class DistrictBloc extends Bloc<DistrictEvent, DistrictState> {
  final GetDistrictsUseCase getDistricts;

  DistrictBloc({required this.getDistricts}) : super(DistrictInitial()) {
    on<LoadDistricts>((event, emit) async {
      emit(DistrictLoading());
      try {
        final items = await getDistricts();
        emit(DistrictLoaded(items));
      } catch (e) {
        emit(DistrictError(e.toString()));
      }
    });
  }
}