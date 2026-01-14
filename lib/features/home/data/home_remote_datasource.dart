import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../core/constants/app_urls.dart';
import 'models/mobile_menu_model.dart';

class HomeRemoteDataSource {
  Future<List<MobileMenuModel>> fetchMobileMenus() async {
    final response = await http.get(
      Uri.parse(AppUrls.mobileMenus),
      headers: {'accept': '*/*'},
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data
          .map((e) => MobileMenuModel.fromJson(e))
          .toList();
    } else {
      throw Exception('Failed to load mobile menus');
    }
  }
}
