class MobileMenuModel {
  final int slNo;
  final String menuName;
  final String? odiaMenuName; // NEW
  final String menuImage;
  final String imageUrl;

  MobileMenuModel({
    required this.slNo,
    required this.menuName,
    this.odiaMenuName,
    required this.menuImage,
    required this.imageUrl,
  });

  factory MobileMenuModel.fromJson(Map<String, dynamic> json) {
    return MobileMenuModel(
      slNo: json['slNo'] ?? 0,
      menuName: json['menuName'] ?? '',
      odiaMenuName: json['odiaMenuName'],
      menuImage: json['menuImage'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
    );
  }
}
