class DistrictItem {
  final int id;
  final String nameEng;
  final String nameOdia;

  DistrictItem({
    required this.id,
    required this.nameEng,
    required this.nameOdia,
  });

  factory DistrictItem.fromJson(Map<String, dynamic> json) => DistrictItem(
        id: json['distSlNo'],
        nameEng: json['distNameEng'],
        nameOdia: json['distNameOdia'],
      );

  String displayName(String language) =>
      language == 'en' ? nameEng : nameOdia;
}
