
import 'package:oscw/features/complaint/data/models/complain_registration_model.dart';
import 'package:oscw/features/complaint/data/models/complaint_response_model.dart';

abstract class ComplaintRepository {
  Future<ComplaintResponseModel> submitComplaint(ComplaintRequestModel request);
}