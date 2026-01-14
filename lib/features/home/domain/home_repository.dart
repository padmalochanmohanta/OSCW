import '../data/models/mobile_menu_model.dart';

abstract class HomeRepository {
  Future<List<MobileMenuModel>> getMobileMenus();
}
