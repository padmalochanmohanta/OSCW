// lib/core/theme/theme_event.dart
import 'package:equatable/equatable.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
  @override
  List<Object?> get props => [];
}

class LoadThemeEvent extends ThemeEvent {
  const LoadThemeEvent();
}

class ChangeThemeEvent extends ThemeEvent {
  /// Accepts 'light' | 'dark' | 'system'
  final String themeString;
  const ChangeThemeEvent(this.themeString);

  @override
  List<Object?> get props => [themeString];
}
