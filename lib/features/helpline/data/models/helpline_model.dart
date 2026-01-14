class HelplineModel {
  final int slno;
  final String helplineName;
  final String helplineNo;

  HelplineModel({
    required this.slno,
    required this.helplineName,
    required this.helplineNo,
  });

  factory HelplineModel.fromJson(Map<String, dynamic> json) {
    return HelplineModel(
      slno: json['slno'] ?? 0,
      helplineName: json['helplineName'] ?? '',
      helplineNo: json['helplineNo'] ?? '',
    );
  }
}
