import 'package:oscw/features/complaint/data/models/district_item.dart';

abstract class DistrictRepository {
  Future<List<DistrictItem>> fetchDistricts();
}