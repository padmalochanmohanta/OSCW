import 'package:http/http.dart' as http;
import 'package:oscw/core/constants/app_urls.dart';
import 'package:oscw/features/complaint/data/models/complain_registration_model.dart';
import '../models/complaint_response_model.dart';
import 'dart:convert';
import 'package:flutter/material.dart';

abstract class ComplaintRemoteDataSource {
  Future<ComplaintResponseModel> submitComplaint(ComplaintRequestModel request);
}
class ComplaintRemoteDataSourceImpl implements ComplaintRemoteDataSource {
  ComplaintRemoteDataSourceImpl();

@override
Future<ComplaintResponseModel> submitComplaint(
    ComplaintRequestModel request) async {
  try {
    final uri = Uri.parse(AppUrls.registration);
    final requestMultipart = http.MultipartRequest('POST', uri);

    // ================= TEXT FIELDS =================

    requestMultipart.fields.addAll({
      'RegisterDate': request.registerDate,
      'ModeOfCommunication': request.modeOfCommunication,
      'AppellantName': request.appellantName,
      'ComplainType': request.complainType.toString(),
      'AppellantEducation': request.appellantEducation,
      'AppellantMobile': request.appellantMobile,
      'AppellantWhatsapp': request.appellantWhatsapp,
      'AppellantEmail': request.appellantEmail,
      'AppellantAadhar': request.appellantAadhar,
      'AppellantDOB': request.appellantDOB,
      'AppellantAge': request.appellantAge.toString(),
      'DateOfMarriage': request.dateOfMarriage,
      'Relationship': request.relationship,
      'NumberOfChildren': request.numberOfChildren.toString(),
      'Category': request.category,
      'UnwedMother': request.unwedMother,
      'CyberCrime': request.cyberCrime,
      'IsGovServant': request.isGovServant,

      'AppellantPresentAddressOne': request.appellantPresentAddressOne,
      'AppellantPresentAddressTwo': request.appellantPresentAddressTwo,
      'AppellantPresentDistSlNo':
          request.appellantPresentDistSlNo.toString(),
      'AppellantPresentCity': request.appellantPresentCity,
      'AppellantPresentPin': request.appellantPresentPin,
      'AppellantPresentPO': request.appellantPresentPO,
      'AppellantPresentPS': request.appellantPresentPS,

      'AppellantPerAddressOne': request.appellantPerAddressOne,
      'AppellantPerAddressTwo': request.appellantPerAddressTwo,
      'AppellantPerDistSlNo': request.appellantPerDistSlNo.toString(),
      'AppellantPerCity': request.appellantPerCity,
      'AppellantPerPin': request.appellantPerPin,
      'AppellantPerPO': request.appellantPerPO,
      'AppellantPerPS': request.appellantPerPS,

      'OppPartyName': request.oppPartyName,
      'OppPartyMobile': request.oppPartyMobile,
      'OppPartyOccupation': request.oppPartyOccupation,
      'OppPartyDOB': request.oppPartyDOB,
      'OppPartyAge': request.oppPartyAge.toString(),
      'OppPartyQualification': request.oppPartyQualification,
      'OppPartyMonthlyIncome': request.oppPartyMonthlyIncome,
      'OppPartyEmail': request.oppPartyEmail,

      'OppPartyPresentAddressOne': request.oppPartyPresentAddressOne,
      'OppPartyPresentAddressTwo': request.oppPartyPresentAddressTwo,
      'OppPartyPresentDistSlNo': request.oppPartyPresentDistSlNo,
      'OppPartyPresentCity': request.oppPartyPresentCity,
      'OppPartyPresentPin': request.oppPartyPresentPin,
      'OppPartyPresentPO': request.oppPartyPresentPO,
      'OppPartyPresentPS': request.oppPartyPresentPS,

      'OppPartyPerAddressOne': request.oppPartyPerAddressOne,
      'OppPartyPerAddressTwo': request.oppPartyPerAddressTwo,
      'OppPartyPerDistSlNo': request.oppPartyPerDistSlNo,
      'OppPartyPerCity': request.oppPartyPerCity,
      'OppPartyPerPin': request.oppPartyPerPin,
      'OppPartyPerPO': request.oppPartyPerPO,
      'OppPartyPerPS': request.oppPartyPerPS,

      'DetailedIncident': request.detailedIncident,
      'RequestWish': request.requestWish,
      'FileCaption': request.fileCaption,
    });

    // ================= FILES =================
   if (request.attactFiles != null && request.attactFiles!.isNotEmpty) {
  debugPrint('Total files selected: ${request.attactFiles!.length}');

  for (final file in request.attactFiles!) {
    final fileName = file.path.split('/').last;
    final fileSize = await file.length();

    debugPrint('----- FILE DEBUG START -----');
    debugPrint('File name : $fileName');
    debugPrint('File path : ${file.path}');
    debugPrint('File size : $fileSize bytes');
    debugPrint('----- FILE DEBUG END -----');

    requestMultipart.files.add(
      await http.MultipartFile.fromPath(
        'AttactFile', 
        file.path,
        filename: fileName,
      ),
    );
  }
}

    // ================= SEND =================

    final response = await requestMultipart.send();
    final responseBody = await response.stream.bytesToString();

    debugPrint('Status: ${response.statusCode}');
    debugPrint('Response: $responseBody');

    if (response.statusCode == 200) {
      return ComplaintResponseModel.fromJson(jsonDecode(responseBody));
    } else {
      throw Exception(responseBody);
    }
  } catch (e) {
    debugPrint('API ERROR: $e');
    rethrow;
  }
}

}