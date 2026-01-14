// lib/core/internet/internet_bloc.dart
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'internet_event.dart';
import 'internet_state.dart';
import '../network/network_info.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState> {
  final NetworkInfo networkInfo;
  StreamSubscription<ConnectivityResult>? _subscription;

  InternetBloc({required this.networkInfo}) : super(InternetState.initial()) {
    on<LoadInternetStatus>(_onLoad);
    on<InternetStatusChanged>(_onChanged);

    // subscribe to connectivity changes from NetworkInfo
    _subscription = networkInfo.onConnectivityChanged.listen((connectivityResult) async {
      final connected = await networkInfo.isConnected;
      add(InternetStatusChanged(connected));
    });
  }

  Future<void> _onLoad(LoadInternetStatus event, Emitter<InternetState> emit) async {
    emit(state.copyWith(loading: true));
    final connected = await networkInfo.isConnected;
    emit(state.copyWith(isConnected: connected, loading: false));
  }

  Future<void> _onChanged(InternetStatusChanged event, Emitter<InternetState> emit) async {
    emit(state.copyWith(isConnected: event.isConnected, loading: false));
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
