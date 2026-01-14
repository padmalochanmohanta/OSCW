import 'package:flutter/material.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/constants/app_images.dart';

class TollFreePage extends StatefulWidget {
  const TollFreePage({super.key});

  @override
  State<TollFreePage> createState() => _TollFreePageState();
}

class _TollFreePageState extends State<TollFreePage> {
  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(t.translate("toll_free_number")),
      ),
      body: Center(
        child: Image.asset(
          AppImages.tollFree, // ✅ assets/images/tollfree.png
          fit: BoxFit.fill,  // full screen
        ),
      ),
    );
  }
}
