import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:oscw/features/complaint/data/models/district_item.dart';
import 'package:oscw/features/complaint/domain/repository/district_repo.dart';

class DistrictRepositoryImpl implements DistrictRepository {
  final String apiUrl;

  DistrictRepositoryImpl({required this.apiUrl});

  @override
  Future<List<DistrictItem>> fetchDistricts() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => DistrictItem.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load districts');
    }
  }
}