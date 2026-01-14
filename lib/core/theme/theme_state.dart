// lib/core/theme/theme_state.dart
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ThemeState extends Equatable {
  final ThemeMode themeMode;
  final String themeString; // 'light'|'dark'|'system'
  final bool loading;

  const ThemeState({
    required this.themeMode,
    required this.themeString,
    this.loading = false,
  });

  factory ThemeState.initial() => const ThemeState(themeMode: ThemeMode.system, themeString: 'system', loading: false);

  ThemeState copyWith({
    ThemeMode? themeMode,
    String? themeString,
    bool? loading,
  }) {
    return ThemeState(
      themeMode: themeMode ?? this.themeMode,
      themeString: themeString ?? this.themeString,
      loading: loading ?? this.loading,
    );
  }

  @override
  List<Object?> get props => [themeMode, themeString, loading];
}
