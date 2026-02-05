class ComplaintResponseModel {
  final String message;
  final int slNo;
  final String referenceNo;

  ComplaintResponseModel({
    required this.message,
    required this.slNo,
    required this.referenceNo,
  });

  factory ComplaintResponseModel.fromJson(Map<String, dynamic> json) {
    return ComplaintResponseModel(
      message: json['message'],
      slNo: json['slNo'],
      referenceNo: json['referenceNo'],
    );
  }
}
