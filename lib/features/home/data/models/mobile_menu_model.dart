class MobileMenuModel {
  final int slNo;
  final String menuName;
  final String menuImage;
  final String imageUrl;

  MobileMenuModel({
    required this.slNo,
    required this.menuName,
    required this.menuImage,
    required this.imageUrl,
  });

  factory MobileMenuModel.fromJson(Map<String, dynamic> json) {
    return MobileMenuModel(
      slNo: json['slNo'] ?? 0,
      menuName: json['menuName'] ?? '',
      menuImage: json['menuImage'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
    );
  }
}
