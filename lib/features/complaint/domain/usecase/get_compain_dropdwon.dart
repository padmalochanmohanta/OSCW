

import 'package:oscw/features/complaint/data/models/complain_dropdown_item.dart';
import 'package:oscw/features/complaint/domain/repository/complain_dropdown_repository.dart';

class GetDropdownItemsUseCase {
  final DropdownRepository repository;

  GetDropdownItemsUseCase(this.repository);

  Future<List<ComplainDropdownItem>> call() => repository.fetchItems();
}
