import 'package:flutter/material.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared_widgets/app_app_bar.dart';

class TrackComplaintPage extends StatefulWidget {
  const TrackComplaintPage({super.key});

  @override
  State<TrackComplaintPage> createState() => _TrackComplaintPageState();
}

class _TrackComplaintPageState extends State<TrackComplaintPage> {
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, String>> _complaints = [
    {
      'id': 'CTC/25/2026',
      'title': 'Domestic Violence Complaint',
      'status': 'pending',
    },
    {
      'id': 'CTC/26/2026',
      'title': 'Workplace Harassment',
      'status': 'in_progress',
    },
    {
      'id': 'CTC/27/2026',
      'title': 'Dowry Harassment Case',
      'status': 'resolved',
    },
  ];

  List<Map<String, String>> _filteredComplaints = [];
  bool _hasSearched = false;

  void _onSearch(String query) {
    setState(() {
      _hasSearched = query.isNotEmpty;

      if (query.isEmpty) {
        _filteredComplaints.clear();
        return;
      }

      _filteredComplaints = _complaints.where((complaint) {
        return complaint['id']!
            .toLowerCase()
            .contains(query.toLowerCase()) ||
            complaint['title']!
                .toLowerCase()
                .contains(query.toLowerCase());
      }).toList();
    });
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'resolved':
        return Colors.green;
      case 'in_progress':
        return Colors.orange;
      default:
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppAppBar(
        title: t.translate('track_complaint'),
        showBack: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              t.translate('track_title'),
              style:
              AppTextStyles.h2.copyWith(color: AppColors.primary),
            ),
            const SizedBox(height: 8),
            Text(
              t.translate('track_desc'),
              style: AppTextStyles.body.copyWith(height: 1.5),
            ),
            const SizedBox(height: 20),

            /// 🔍 Search
            TextField(
              controller: _searchController,
              onChanged: _onSearch,
              decoration: InputDecoration(
                hintText: t.translate('search_complaint_hint'),
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// 📋 Conditional Result Area
            Expanded(
              child: !_hasSearched
                  ? Center(
                child: Text(
                  t.translate('search_to_view_complaint'),
                  style: AppTextStyles.bodySmall
                      .copyWith(color: Colors.grey),
                ),
              )
                  : _filteredComplaints.isEmpty
                  ? Center(
                child: Text(
                  t.translate('no_complaints_found'),
                  style: AppTextStyles.bodySmall
                      .copyWith(color: Colors.grey),
                ),
              )
                  : ListView.builder(
                itemCount: _filteredComplaints.length,
                itemBuilder: (context, index) {
                  final complaint =
                  _filteredComplaints[index];

                  return Card(
                    elevation: 2,
                    margin:
                    const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: AppColors.primary
                            .withOpacity(0.1),
                        child: const Icon(
                          Icons.female,
                          color: AppColors.primary,
                        ),
                      ),
                      title: Text(
                        complaint['title']!,
                        style: AppTextStyles.body
                            .copyWith(
                            fontWeight:
                            FontWeight.w600),
                      ),
                      subtitle: Text(
                        '${t.translate('complaint_id')}: ${complaint['id']}',
                        style:
                        AppTextStyles.bodySmall,
                      ),
                      trailing: Container(
                        padding:
                        const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4),
                        decoration: BoxDecoration(
                          color: _statusColor(
                              complaint['status']!)
                              .withOpacity(0.15),
                          borderRadius:
                          BorderRadius.circular(20),
                        ),
                        child: Text(
                          t.translate(
                              complaint['status']!),
                          style: TextStyle(
                            color: _statusColor(
                                complaint['status']!),
                            fontSize: 12,
                            fontWeight:
                            FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
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

