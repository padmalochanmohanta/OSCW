// lib/core/network/network_info.dart

import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'connectivity_service.dart';

abstract class NetworkInfo {
  /// Returns TRUE only if the device truly has internet access.
  Future<bool> get isConnected;

  /// Connectivity stream (Wifi/Mobile/None)
  Stream<ConnectivityResult> get onConnectivityChanged;
}

class NetworkInfoImpl implements NetworkInfo {
  final ConnectivityService connectivityService;

  NetworkInfoImpl({required this.connectivityService});

  @override
  Future<bool> get isConnected async {
    // Step 1: Check basic connectivity (wifi/mobile)
    final connectivityResult = await connectivityService.checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) return false;

    // Step 2: Try multiple DNS lookups (Gov networks often block Google)
    final testHosts = [
      '1.1.1.1',          // Cloudflare DNS - most reliable
      'google.com',       // Google DNS
      '208.67.222.222',   // OpenDNS
    ];

    for (final host in testHosts) {
      try {
        final result = await InternetAddress.lookup(host)
            .timeout(const Duration(seconds: 2));

        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          return true; // Internet is available
        }
      } catch (_) {
        // Try next host
      }
    }

    return false; // All checks failed → internet not available
  }

  @override
  Stream<ConnectivityResult> get onConnectivityChanged =>
      connectivityService.onConnectivityChanged;
}
