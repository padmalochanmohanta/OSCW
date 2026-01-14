import '../domain/helpline_repository.dart';
import 'helpline_remote_datasource.dart';
import 'models/helpline_model.dart';

class HelplineRepositoryImpl implements HelplineRepository {
  final HelplineRemoteDataSource remote;

  HelplineRepositoryImpl(this.remote);

  @override
  Future<List<HelplineModel>> getHelplines() {
    return remote.fetchHelplines();
  }
}
