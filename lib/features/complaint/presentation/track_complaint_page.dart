import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oscw/core/localization/app_localizations.dart';
import 'package:oscw/features/complaint/domain/entity/track_complaint_entity.dart';
import 'package:oscw/features/complaint/presentation/bloc/track_complaint/track_complaint_bloc.dart';
import 'package:oscw/shared_widgets/app_app_bar.dart';

enum SearchType { complaintId, referenceNo, phoneNumber }

class TrackComplaintPage extends StatefulWidget {
  const TrackComplaintPage({super.key});

  @override
  State<TrackComplaintPage> createState() => _TrackComplaintPageState();
}

class _TrackComplaintPageState extends State<TrackComplaintPage> {
  final TextEditingController _searchController = TextEditingController();
  SearchType _searchType = SearchType.complaintId;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return Scaffold(
       appBar: AppAppBar(
        title: t.translate("trackComplaintTitle"),
        showBack: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title Text
            Text(
              t.translate("trackComplaintTitle"),
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 8),
            Text(t.translate("trackComplaintDesc")),
            const SizedBox(height: 20),

            // Radio Buttons in Row with Responsive Text Size
            _buildRadioButtonsForSearchType(),

            const SizedBox(height: 20),

            // Search TextField
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: t.translate("searchHint"),
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onSubmitted: (value) {
                if (value.isNotEmpty) _searchComplaint(value);
              },
            ),

            const SizedBox(height: 20),

            // BlocBuilder for Results
          Expanded(
      child: BlocBuilder<TrackComplaintBloc, TrackComplaintState>(
    builder: (context, state) {
      if (state is TrackComplaintLoading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is TrackComplaintLoaded) {
        return _buildTimelineDiagram(state.complaint);
      } else if (state is TrackComplaintEmpty) {
          return Center(child: Text(t.translate("noComplaintFound")));
      } else if (state is TrackComplaintError) {
       return Center(child: Text(t.translate("errorMessage").replaceAll("{message}", state.message)));
      }
     return Center(child: Text(t.translate("enterValueToSearch")));
    },
  ),
)

          ],
        ),
      ),
    );
  }

  /// Radio Buttons in Row with Responsive Text Size
  Widget _buildRadioButtonsForSearchType() {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isSmallScreen = constraints.maxWidth < 600;
        double textSize = isSmallScreen ? 12.0 : 16.0; 
       final t = AppLocalizations.of(context); 
        return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
          child: Row(
            children: [
            _buildRadio(SearchType.complaintId, t.translate('complaint_id'), textSize),
            _buildRadio(SearchType.referenceNo, t.translate('reference_no'), textSize),
            _buildRadio(SearchType.phoneNumber, t.translate('phone_number'), textSize),
            ],
          ),
        );
      },
    );
  }

  // Build a single radio button with custom text size
  Widget _buildRadio(SearchType type, String label, double textSize) {
    return Row(
      children: [
        Radio<SearchType>(
          value: type,
          groupValue: _searchType,
          onChanged: (value) {
            setState(() {
              _searchType = value!;
              _searchController.clear();
            });

            // Reset Bloc state
            context.read<TrackComplaintBloc>().add(TrackComplaintReset());
          },
        ),
        Text(
          label,
          style: TextStyle(fontSize: textSize), // Apply dynamic text size
        ),
        const SizedBox(width: 10),
      ],
    );
  }

  // Search complaint based on selected type
  void _searchComplaint(String value) {
    final bloc = context.read<TrackComplaintBloc>();
    switch (_searchType) {
      case SearchType.complaintId:
        bloc.add(TrackComplaintFetch(complaintId: value));
        break;
      case SearchType.referenceNo:
        bloc.add(TrackComplaintFetch(referenceNo: value));
        break;
      case SearchType.phoneNumber:
        bloc.add(TrackComplaintFetch(phoneNumber: value));
        break;
    }
  }

  // Build timeline diagram for complaint
  Widget _buildTimelineDiagram(ComplaintEntity complaint) {
    final Map<String, List<TimelineEntity>> grouped = {};
    for (var t in complaint.timeline) {
      if (t.isCompleted) {
        grouped.putIfAbsent(t.stage, () => []).add(t);
      }
    }

    if (grouped.isEmpty) {
      return Center(child: Text(AppLocalizations.of(context).translate("noComplaint")));
    }

    String? latestStage;
    for (var entry in complaint.timeline) {
      if (!entry.isCompleted) {
        latestStage = entry.stage;
        break;
      }
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: grouped.entries.length,
      itemBuilder: (context, stageIndex) {
        final stageEntry = grouped.entries.elementAt(stageIndex);
        final stage = stageEntry.key;
        final events = stageEntry.value;

        bool isClosedStage = stage.toLowerCase() == 'closed';
        bool isLatestStage = stage == latestStage;

        IconData headerIcon;
        Color headerColor;

        if (isClosedStage) {
          headerIcon = Icons.verified;
          headerColor = Colors.green;
        } else if (isLatestStage) {
          headerIcon = Icons.hourglass_top;
          headerColor = Colors.orange;
        } else {
          headerIcon = Icons.check_circle;
          headerColor = Colors.green;
        }

        return Theme(
          data: Theme.of(context).copyWith(
            dividerColor: Colors.transparent,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: ExpansionTile(
            initiallyExpanded: true,
            tilePadding: EdgeInsets.zero,
            childrenPadding: EdgeInsets.zero,
            leading: Icon(headerIcon, color: headerColor),
            title: Text(
              stage,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            children: [
              Card(
                margin: const EdgeInsets.only(bottom: 16),
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: events.asMap().entries.map((e) {
                      final index = e.key;
                      final event = e.value;
                      final isLast = index == events.length - 1;

                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              const Icon(
                                Icons.check_circle,
                                color: Colors.green,
                                size: 20,
                              ),
                              if (!isLast)
                                Container(
                                  width: 2,
                                  height: 40,
                                  color: Colors.grey.shade400,
                                ),
                            ],
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    event.status,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    event.actionDate
                                        .toLocal()
                                        .toString()
                                        .split('T')
                                        .first,
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
