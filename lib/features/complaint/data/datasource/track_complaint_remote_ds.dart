import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:oscw/core/constants/app_urls.dart';
import 'package:oscw/features/complaint/data/models/track_complaint_model.dart';


abstract class TrackComplaintRemoteDataSource {
  Future<TrackComplaintModel> searchComplaint({
    String? referenceNo,
    String? complaintId,
    String? phoneNumber,
  });
}

class TrackComplaintRemoteDataSourceImpl
    implements TrackComplaintRemoteDataSource {
  
  TrackComplaintRemoteDataSourceImpl();

  @override
  Future<TrackComplaintModel> searchComplaint({
    String? referenceNo,
    String? complaintId,
    String? phoneNumber,
  }) async {
    final uri = Uri.parse(AppUrls.complaintTracking).replace(
      queryParameters: {
        if (referenceNo != null) 'referenceNo': referenceNo,
        if (complaintId != null) 'complaintId': complaintId,
        if (phoneNumber != null) 'phoneNumber': phoneNumber,
      },
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      print('🔹 Parsed JSON: $jsonData');

      // Check if 'data' is null
      if (jsonData['data'] != null) {
        return TrackComplaintModel.fromJson(jsonData['data']);
      } else {
        // If no complaint found, return null or throw an exception
        throw Exception('No complaint found');
      }
    } else {
      throw Exception('Failed to fetch complaint. Status code: ${response.statusCode}');
    }
  }
}
