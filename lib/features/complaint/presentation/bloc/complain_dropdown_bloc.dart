
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oscw/features/complaint/domain/usecase/get_compain_dropdwon.dart';
import 'package:oscw/features/complaint/presentation/bloc/complain_dropdown_event.dart';
import 'package:oscw/features/complaint/presentation/bloc/complain_dropdwon_state.dart';

// Bloc
class DropdownBloc extends Bloc<DropdownEvent, DropdownState> {
  final GetDropdownItemsUseCase getDropdownItems;

  DropdownBloc({required this.getDropdownItems}) : super(DropdownInitial()) {
    on<LoadDropdownItems>((event, emit) async {
      emit(DropdownLoading());
      try {
        final items = await getDropdownItems();
        emit(DropdownLoaded(items));
      } catch (e) {
        emit(DropdownError(e.toString()));
      }
    });
  }
}
