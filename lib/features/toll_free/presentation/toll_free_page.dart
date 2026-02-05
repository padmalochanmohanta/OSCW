import 'package:flutter/material.dart';
import 'package:oscw/shared_widgets/app_app_bar.dart';
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
    appBar:AppAppBar(
          title: t.translate("toll_free_number"),
        showBack: true,
      ),
      body: Center(
        child: Image.asset(
          AppImages.tollFree, 
          fit: BoxFit.fill,  
        ),
      ),
    );
  }
}
