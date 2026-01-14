// lib/core/localization/locale_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'locale_event.dart';
import 'locale_state.dart';
import '../local_storage/preferences.dart';

class LocaleBloc extends Bloc<LocaleEvent, LocaleState> {
  final Preferences preferences;

  LocaleBloc({required this.preferences}) : super(LocaleState.initial()) {
    on<LoadLocaleEvent>(_onLoad);
    on<ChangeLocaleEvent>(_onChange);
  }

  Future<void> _onLoad(LoadLocaleEvent event, Emitter<LocaleState> emit) async {
    emit(state.copyWith(loading: true));
    final stored = preferences.getLocale();
    if (stored != null && stored.isNotEmpty) {
      emit(state.copyWith(languageCode: stored, loading: false));
    } else {
      emit(state.copyWith(loading: false));
    }
  }

  Future<void> _onChange(ChangeLocaleEvent event, Emitter<LocaleState> emit) async {
    await preferences.setLocale(event.languageCode);
    emit(state.copyWith(languageCode: event.languageCode, loading: false));
  }
}
