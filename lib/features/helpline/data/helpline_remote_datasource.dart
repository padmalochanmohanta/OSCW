import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../core/constants/app_urls.dart';
import 'models/helpline_model.dart';

class HelplineRemoteDataSource {
  Future<List<HelplineModel>> fetchHelplines() async {
    final response = await http.get(
      Uri.parse(AppUrls.helplineNumbers),
      headers: {'accept': '*/*'},
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => HelplineModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load helpline numbers');
    }
  }
}
