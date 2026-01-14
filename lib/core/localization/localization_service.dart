// lib/core/localization/localization_service.dart
import 'package:flutter/widgets.dart';
import '../local_storage/preferences.dart';

/// Simple service to read/write selected locale via Preferences.
class LocalizationService {
  final Preferences preferences;

  LocalizationService({required this.preferences});

  Locale getSavedLocale() {
    final code = preferences.getLocale();
    if (code == null || code.isEmpty) return const Locale('en');
    return Locale(code);
  }

  Future<void> saveLocale(Locale locale) async {
    await preferences.setLocale(locale.languageCode);
  }
}
