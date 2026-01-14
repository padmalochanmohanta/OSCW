// lib/core/internet/internet_state.dart
import 'package:equatable/equatable.dart';

class InternetState extends Equatable {
  final bool isConnected;
  final bool loading;

  const InternetState({required this.isConnected, this.loading = false});

  factory InternetState.initial() => const InternetState(isConnected: true, loading: false);

  InternetState copyWith({bool? isConnected, bool? loading}) {
    return InternetState(isConnected: isConnected ?? this.isConnected, loading: loading ?? this.loading);
  }

  @override
  List<Object?> get props => [isConnected, loading];
}
