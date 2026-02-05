class HelplineModel {
  final int slno;
  final String helplineName;
  final String odiaHelplineName;
  final String helplineNo;
  final String odiaHelplineNo;

  HelplineModel({
    required this.slno,
    required this.helplineName,
    required this.odiaHelplineName,
    required this.helplineNo,
    required this.odiaHelplineNo,
  });

  factory HelplineModel.fromJson(Map<String, dynamic> json) {
    return HelplineModel(
      slno: json['slno'] ?? 0,
      helplineName: json['helplineName'] ?? '',
      odiaHelplineName: json['odiaHelplineName'] ?? '',
      helplineNo: json['helplineNo'] ?? '',
      odiaHelplineNo: json['odiaHelplineNo'] ?? '',
    );
  }
}
