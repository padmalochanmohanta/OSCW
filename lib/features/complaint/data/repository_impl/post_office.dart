import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:oscw/shared_widgets/app_dropdown_field.dart';

Future<List<DropdownItem>> fetchPostOffices(String pin) async {
  final url = Uri.parse('http://www.postalpincode.in/api/pincode/$pin');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = json.decode(response.body);

    if (data['Status'] == 'Success') {
      return (data['PostOffice'] as List)
          .map((e) => DropdownItem(
                nameEng: e['Name'],
                nameOdia: e['Name'],
              ))
          .toList();
    }
  }
  return [];
}
