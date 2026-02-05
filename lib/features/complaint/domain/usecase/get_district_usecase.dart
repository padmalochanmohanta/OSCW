import 'package:oscw/features/complaint/data/models/district_item.dart';
import 'package:oscw/features/complaint/domain/repository/district_repo.dart';

class GetDistrictsUseCase {
  final DistrictRepository repository;

  GetDistrictsUseCase(this.repository);

  Future<List<DistrictItem>> call() => repository.fetchDistricts();
}
