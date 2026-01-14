// lib/core/internet/internet_event.dart
import 'package:equatable/equatable.dart';

abstract class InternetEvent extends Equatable {
  const InternetEvent();
  @override
  List<Object?> get props => [];
}

class LoadInternetStatus extends InternetEvent {
  const LoadInternetStatus();
}

class InternetStatusChanged extends InternetEvent {
  final bool isConnected;
  const InternetStatusChanged(this.isConnected);

  @override
  List<Object?> get props => [isConnected];
}
