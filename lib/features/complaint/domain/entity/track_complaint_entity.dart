

class ComplaintEntity {
  final String searchValue;
  final String complaintSlNo;
  final String currentStatus;
  final List<TimelineEntity> timeline;

  ComplaintEntity({
    required this.searchValue,
    required this.complaintSlNo,
    required this.currentStatus,
    required this.timeline,
  });
}


class TimelineEntity {
  final String stage;
  final String status;
  final DateTime actionDate;
  final bool isCompleted;

  TimelineEntity({
    required this.stage,
    required this.status,
    required this.actionDate,
    required this.isCompleted,
  });
}
