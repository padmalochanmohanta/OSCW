

import 'package:oscw/features/complaint/data/models/complain_dropdown_item.dart';


abstract class DropdownRepository {
  Future<List<ComplainDropdownItem>> fetchItems();
}
