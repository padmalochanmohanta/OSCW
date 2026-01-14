// lib/core/localization/locale_event.dart
import 'package:equatable/equatable.dart';

abstract class LocaleEvent extends Equatable {
  const LocaleEvent();
  @override
  List<Object?> get props => [];
}

class LoadLocaleEvent extends LocaleEvent {
  const LoadLocaleEvent();
}

class ChangeLocaleEvent extends LocaleEvent {
  final String languageCode; // 'en' or 'hi' etc.
  const ChangeLocaleEvent(this.languageCode);

  @override
  List<Object?> get props => [languageCode];
}
