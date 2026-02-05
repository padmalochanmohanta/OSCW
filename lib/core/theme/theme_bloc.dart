

// lib/core/theme/theme_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'theme_event.dart';
import 'theme_state.dart';
import '../local_storage/preferences.dart';


// class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
//   final Preferences preferences;

//   ThemeBloc({required this.preferences}) : super(ThemeState.initial()) {
//     on<LoadThemeEvent>(_onLoadTheme);
//     on<ChangeThemeEvent>(_onChangeTheme);
//   }

//   Future<void> _onLoadTheme(LoadThemeEvent event, Emitter<ThemeState> emit) async {
//     emit(state.copyWith(loading: true));
//     final stored = preferences.getThemeString(); // may be null
//     if (stored != null) {
//       emit(_stateFromString(stored));
//     } else {
//       emit(state.copyWith(loading: false));
//     }
//   }

//   // Future<void> _onChangeTheme(ChangeThemeEvent event, Emitter<ThemeState> emit) async {
//   //   final newState = _stateFromString(event.themeString);
//   //   await preferences.setThemeString(event.themeString);
//   //   emit(newState.copyWith(loading: false));
//   // }
//   Future<void> _onChangeTheme(
//   ChangeThemeEvent event,
//   Emitter<ThemeState> emit,
// ) async {
//   final newState = _stateFromString(event.themeString);

//   // ✅ 1. Emit immediately (forces rebuild)
//   emit(newState.copyWith(loading: false));

//   // ✅ 2. Save in background
//   await preferences.setThemeString(event.themeString);
// }


//   ThemeState _stateFromString(String s) {
//     switch (s) {
//       case 'light':
//         return ThemeState(themeMode: ThemeMode.light, themeString: 'light', loading: false);
//       case 'dark':
//         return ThemeState(themeMode: ThemeMode.dark, themeString: 'dark', loading: false);
//       case 'system':
//       default:
//         return ThemeState(themeMode: ThemeMode.system, themeString: 'system', loading: false);
//     }
//   }
// }


class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final Preferences preferences;

  ThemeBloc({required this.preferences}) : super(ThemeState.initial()) {
    on<LoadThemeEvent>(_onLoadTheme);
    on<ChangeThemeEvent>(_onChangeTheme);
  }

  Future<void> _onLoadTheme(LoadThemeEvent event, Emitter<ThemeState> emit) async {
    emit(state.copyWith(loading: true));
    final stored = preferences.getThemeString(); // Get stored theme preference
    if (stored != null) {
      emit(_stateFromString(stored));
    } else {
      emit(state.copyWith(loading: false));
    }
  }

  Future<void> _onChangeTheme(ChangeThemeEvent event, Emitter<ThemeState> emit) async {
    final newState = _stateFromString(event.themeString);

    // Emit new state immediately to rebuild the UI
    emit(newState.copyWith(loading: false));

    // Save the theme preference in the background
    await preferences.setThemeString(event.themeString);
  }

  ThemeState _stateFromString(String s) {
    switch (s) {
      case 'light':
        return ThemeState(themeMode: ThemeMode.light, themeString: 'light', loading: false);
      case 'dark':
        return ThemeState(themeMode: ThemeMode.dark, themeString: 'dark', loading: false);
      case 'system':
      default:
        return ThemeState(themeMode: ThemeMode.system, themeString: 'system', loading: false);
    }
  }
}
