import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:oscw/core/constants/app_urls.dart';

class SafetyTipsService {


  // Fetches image URLs from API
  static Future<List<String>> fetchImageUrls() async {
    final response = await http.get(Uri.parse(AppUrls.safetytips));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => item['imageUrl'] as String).toList();
    } else {
      throw Exception('Failed to fetch images');
    }
  }
}
