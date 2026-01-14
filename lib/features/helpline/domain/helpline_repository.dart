import '../data/models/helpline_model.dart';

abstract class HelplineRepository {
  Future<List<HelplineModel>> getHelplines();
}
