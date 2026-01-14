// lib/core/localization/app_localizations.dart
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

/// Simple JSON-based localization loader.
/// JSON files placed under assets/lang/<code>.json or as you prefer.
/// Example file structure used in this project: lib/core/localization/l10n/en.json
class AppLocalizations {
  final Locale locale;
  late Map<String, String> _localizedStrings;

  AppLocalizations(this.locale);

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  Future<bool> load() async {
    final String jsonString = await rootBundle.loadString('lib/core/localization/l10n/${locale.languageCode}.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedStrings = jsonMap.map((key, value) => MapEntry(key, value.toString()));
    return true;
  }

  String translate(String key) {
    return _localizedStrings[key] ?? key;
  }
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override

  bool isSupported(Locale locale) => ['en', 'hi', 'or'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    final loc = AppLocalizations(locale);
    await loc.load();
    return loc;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
