class PostOffice {
  final String name;

  PostOffice({required this.name});

  factory PostOffice.fromJson(Map<String, dynamic> json) {
    return PostOffice(name: json['Name']);
  }
}
