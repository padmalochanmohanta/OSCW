import '../domain/home_repository.dart';
import 'home_remote_datasource.dart';
import 'models/mobile_menu_model.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remote;

  HomeRepositoryImpl(this.remote);

  @override
  Future<List<MobileMenuModel>> getMobileMenus() {
    return remote.fetchMobileMenus();
  }
}
