// lib/core/localization/locale_state.dart
import 'package:equatable/equatable.dart';

class LocaleState extends Equatable {
  final String languageCode;
  final bool loading;

  const LocaleState({required this.languageCode, this.loading = false});

  factory LocaleState.initial() => const LocaleState(languageCode: 'en', loading: false);

  LocaleState copyWith({String? languageCode, bool? loading}) {
    return LocaleState(languageCode: languageCode ?? this.languageCode, loading: loading ?? this.loading);
  }

  @override
  List<Object?> get props => [languageCode, loading];
}
