import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:oscw/features/complaint/data/models/complain_dropdown_item.dart';
import 'package:oscw/features/complaint/domain/repository/complain_dropdown_repository.dart';

class DropdownRepositoryImpl implements DropdownRepository {
  final String apiUrl;

  DropdownRepositoryImpl({required this.apiUrl});

  @override
  Future<List<ComplainDropdownItem>> fetchItems() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => ComplainDropdownItem.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load dropdown items');
    }
  }
}
