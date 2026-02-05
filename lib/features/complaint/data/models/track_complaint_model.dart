

import 'package:oscw/features/complaint/domain/entity/track_complaint_entity.dart';

class TrackComplaintModel extends ComplaintEntity {
  TrackComplaintModel({
    required super.searchValue,
    required super.complaintSlNo,
    required super.currentStatus,
    required super.timeline,
  });

  factory TrackComplaintModel.fromJson(Map<String, dynamic> json) {
    return TrackComplaintModel(
      searchValue: json['searchValue'] ?? '',
      complaintSlNo: json['complaintSlNo'] ?? '',
      currentStatus: json['currentStatus'] ?? '',
      timeline: (json['timeline'] as List<dynamic>? ?? [])
          .map((e) => TimelineModel.fromJson(e))
          .toList(),
    );
  }
}


class TimelineModel extends TimelineEntity {
  TimelineModel({
    required super.stage,
    required super.status,
    required super.actionDate,
    required super.isCompleted,
  });

  factory TimelineModel.fromJson(Map<String, dynamic> json) {
    return TimelineModel(
      stage: json['stage'] ?? '',
      status: json['status'] ?? '',
      actionDate: DateTime.parse(json['actionDate']),
      isCompleted: json['isCompleted'] ?? false,
    );
  }
}
