// lib/shared_widgets/no_internet_widget.dart
import 'package:flutter/material.dart';
import '../core/localization/app_localizations.dart';

class NoInternetWidget extends StatelessWidget {
  const NoInternetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      color: Colors.red.shade600,
      child: Text(
        t.translate("no_internet"),
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }
}
