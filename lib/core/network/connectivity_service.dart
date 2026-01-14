// lib/core/network/connectivity_service.dart
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

/// A lightweight wrapper around connectivity_plus.
/// Exposes a stream of ConnectivityResult and a method to check current status.
class ConnectivityService {
  final Connectivity _connectivity;
  final StreamController<ConnectivityResult> _controller = StreamController.broadcast();

  ConnectivityService({Connectivity? connectivity}) : _connectivity = connectivity ?? Connectivity() {
    _connectivity.onConnectivityChanged.listen((result) {
      _controller.add(result);
    });
  }

  Future<ConnectivityResult> checkConnectivity() => _connectivity.checkConnectivity();

  Stream<ConnectivityResult> get onConnectivityChanged => _controller.stream;

  void dispose() {
    _controller.close();
  }
}
