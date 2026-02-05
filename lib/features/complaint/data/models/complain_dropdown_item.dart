class ComplainDropdownItem {
  final int id;
  final String nameEng;
  final String nameOdia;

  ComplainDropdownItem({
    required this.id,
    required this.nameEng,
    required this.nameOdia,
  });

  factory ComplainDropdownItem.fromJson(Map<String, dynamic> json) => ComplainDropdownItem(
        id: json['catSlNo'],
        nameEng: json['categoryNameEng'],
        nameOdia: json['categoryNameOdia'],
      );

  String displayName(String language) =>
      language == 'en' ? nameEng : nameOdia;
}
