import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared_widgets/app_app_bar.dart';
import '../../../shared_widgets/no_internet_banner.dart';
import '../../../core/internet/internet_bloc.dart';
import '../../../core/internet/internet_state.dart';

import '../data/helpline_remote_datasource.dart';
import '../data/helpline_repository_impl.dart';
import '../data/models/helpline_model.dart';

class HelplinePage extends StatefulWidget {
  const HelplinePage({super.key});

  @override
  State<HelplinePage> createState() => _HelplinePageState();
}

class _HelplinePageState extends State<HelplinePage> {
  late final HelplineRepositoryImpl _repo;
  late Future<List<HelplineModel>> _helplineFuture;

  @override
  void initState() {
    super.initState();
    _repo = HelplineRepositoryImpl(HelplineRemoteDataSource());
    _helplineFuture = _repo.getHelplines();
  }

  Future<void> _callNumber(String number) async {
    final Uri uri = Uri.parse('tel:$number');

    if (!await launchUrl(
      uri,
      mode: LaunchMode.platformDefault,
    )) {
      debugPrint('Could not launch dialer');
    }
  }


  Widget _helplineTile({
  required String title,
  required String number,
  required IconData icon,
  required Color color,
}) {
  return InkWell(
    onTap: () => _callNumber(number),
    borderRadius: BorderRadius.circular(14),
    child: Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color, width: 1.2),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color,
            child: Icon(icon, color: Colors.white),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  number,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.call, color: color),
        ],
      ),
    ),
  );
}


  /// 🔹 SAME COLORS AS BEFORE
  Color _getColor(int index) {
    const colors = [
      Colors.red,
      Colors.pink,
      Colors.orange,
      Colors.green,
      Colors.teal,
      Colors.blue,
      Colors.purple,
      Colors.indigo,
    ];
    return colors[index % colors.length];
  }

  /// 🔹 SAME ICONS AS BEFORE
  IconData _getIcon(int index) {
    const icons = [
      Icons.warning,
      Icons.female,
      Icons.child_care,
      Icons.local_hospital,
      Icons.health_and_safety,
      Icons.local_police,
      Icons.support_agent,
      Icons.psychology,
    ];
    return icons[index % icons.length];
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final langCode = Localizations.localeOf(context).languageCode;
    return Scaffold(
      appBar: AppAppBar(
        title: t.translate('helpline_numbers'),
        showBack: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🌐 INTERNET STATUS (AS REQUESTED)
            BlocBuilder<InternetBloc, InternetState>(
              builder: (context, state) {
                return NoInternetBanner(
                  visible: !state.isConnected,
                  message: t.translate("no_internet"),
                );
              },
            ),

            Text(
              t.translate('helpline_desc'),
              style: AppTextStyles.body.copyWith(height: 1.5),
            ),
            const SizedBox(height: 20),

            Expanded(
              child: FutureBuilder<List<HelplineModel>>(
                future: _helplineFuture,
                builder: (context, snapshot) {
                  /// 🔄 LOADER
                  if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  /// ❌ ERROR / EMPTY
                  if (snapshot.hasError || !snapshot.hasData) {
                    return const Center(
                      child: Text('No helpline numbers available'),
                    );
                  }

                  final list = snapshot.data!;

                  return ListView.separated(
                    itemCount: list.length,
                    separatorBuilder: (_, __) =>
                    const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final item = list[index];
                    
                    final helplineTitle = langCode == 'or' ? item.odiaHelplineName : item.helplineName;
                    final helplineNumber = langCode == 'or' ? item.odiaHelplineNo : item.helplineNo;

                      return _helplineTile(
                         title: helplineTitle,
                         number: helplineNumber,
                        icon: _getIcon(index),
                        color: _getColor(index),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
