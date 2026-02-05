

import 'dart:io';

class ComplaintRequestModel {
  final String registerDate;
  final String modeOfCommunication;
  final String appellantName;
  final int complainType;
  final String appellantEducation;
  final String appellantMobile;
  final String appellantWhatsapp;
  final String appellantEmail;
  final String appellantAadhar;
  final String appellantDOB;
  final int appellantAge;
  final String dateOfMarriage;
  final String relationship;
  final int numberOfChildren;
  final String category;
  final String unwedMother;
  final String cyberCrime;
  final String isGovServant;

  final String appellantPresentAddressOne;
  final String appellantPresentAddressTwo;
  final int appellantPresentDistSlNo;
  final String appellantPresentCity;
  final String appellantPresentPin;
  final String appellantPresentPO;
  final String appellantPresentPS;

  final String appellantPerAddressOne;
  final String appellantPerAddressTwo;
  final int appellantPerDistSlNo;
  final String appellantPerCity;
  final String appellantPerPin;
  final String appellantPerPO;
  final String appellantPerPS;

  final String oppPartyName;
  final String oppPartyMobile;
  final String oppPartyOccupation;
  final String oppPartyDOB;
  final int oppPartyAge;
  final String oppPartyQualification;
  final String oppPartyMonthlyIncome;
  final String oppPartyEmail;

  final String oppPartyPresentAddressOne;
  final String oppPartyPresentAddressTwo;
  final String oppPartyPresentDistSlNo;
  final String oppPartyPresentCity;
  final String oppPartyPresentPin;
  final String oppPartyPresentPO;
  final String oppPartyPresentPS;

  final String oppPartyPerAddressOne;
  final String oppPartyPerAddressTwo;
  final String oppPartyPerDistSlNo;
  final String oppPartyPerCity;
  final String oppPartyPerPin;
  final String oppPartyPerPO;
  final String oppPartyPerPS;

  final String detailedIncident;
  final String requestWish;
  final String fileCaption;

  /// API expects array
 final List<File>? attactFiles;

  ComplaintRequestModel({
    required this.registerDate,
    required this.modeOfCommunication,
    required this.appellantName,
    required this.complainType,
    required this.appellantEducation,
    required this.appellantMobile,
    required this.appellantWhatsapp,
    required this.appellantEmail,
    required this.appellantAadhar,
    required this.appellantDOB,
    required this.appellantAge,
    required this.dateOfMarriage,
    required this.relationship,
    required this.numberOfChildren,
    required this.category,
    required this.unwedMother,
    required this.cyberCrime,
    required this.isGovServant,
    required this.appellantPresentAddressOne,
    required this.appellantPresentAddressTwo,
    required this.appellantPresentDistSlNo,
    required this.appellantPresentCity,
    required this.appellantPresentPin,
    required this.appellantPresentPO,
    required this.appellantPresentPS,
    required this.appellantPerAddressOne,
    required this.appellantPerAddressTwo,
    required this.appellantPerDistSlNo,
    required this.appellantPerCity,
    required this.appellantPerPin,
    required this.appellantPerPO,
    required this.appellantPerPS,
    required this.oppPartyName,
    required this.oppPartyMobile,
    required this.oppPartyOccupation,
    required this.oppPartyDOB,
    required this.oppPartyAge,
    required this.oppPartyQualification,
    required this.oppPartyMonthlyIncome,
    required this.oppPartyEmail,
    required this.oppPartyPresentAddressOne,
    required this.oppPartyPresentAddressTwo,
    required this.oppPartyPresentDistSlNo,
    required this.oppPartyPresentCity,
    required this.oppPartyPresentPin,
    required this.oppPartyPresentPO,
    required this.oppPartyPresentPS,
    required this.oppPartyPerAddressOne,
    required this.oppPartyPerAddressTwo,
    required this.oppPartyPerDistSlNo,
    required this.oppPartyPerCity,
    required this.oppPartyPerPin,
    required this.oppPartyPerPO,
    required this.oppPartyPerPS,
    required this.detailedIncident,
    required this.requestWish,
    required this.fileCaption,
    this.attactFiles,
  });

  Map<String, dynamic> toJson() {
    return {
      'RegisterDate': registerDate,
      'ModeOfCommunication': modeOfCommunication,
      'AppellantName': appellantName,
      'ComplainType': complainType,
      'AppellantEducation': appellantEducation,
      'AppellantMobile': appellantMobile,
      'AppellantWhatsapp': appellantWhatsapp,
      'AppellantEmail': appellantEmail,
      'AppellantAadhar': appellantAadhar,
      'AppellantDOB': appellantDOB,
      'AppellantAge': appellantAge,
      'DateOfMarriage': dateOfMarriage,
      'Relationship': relationship,
      'NumberOfChildren': numberOfChildren,
      'Category': category,
      'UnwedMother': unwedMother,
      'CyberCrime': cyberCrime,
      'IsGovServant': isGovServant,

      'AppellantPresentAddressOne': appellantPresentAddressOne,
      'AppellantPresentAddressTwo': appellantPresentAddressTwo,
      'AppellantPresentDistSlNo': appellantPresentDistSlNo,
      'AppellantPresentCity': appellantPresentCity,
      'AppellantPresentPin': appellantPresentPin,
      'AppellantPresentPO': appellantPresentPO,
      'AppellantPresentPS': appellantPresentPS,

      'AppellantPerAddressOne': appellantPerAddressOne,
      'AppellantPerAddressTwo': appellantPerAddressTwo,
      'AppellantPerDistSlNo': appellantPerDistSlNo,
      'AppellantPerCity': appellantPerCity,
      'AppellantPerPin': appellantPerPin,
      'AppellantPerPO': appellantPerPO,
      'AppellantPerPS': appellantPerPS,

      'OppPartyName': oppPartyName,
      'OppPartyMobile': oppPartyMobile,
      'OppPartyOccupation': oppPartyOccupation,
      'OppPartyDOB': oppPartyDOB,
      'OppPartyAge': oppPartyAge,
      'OppPartyQualification': oppPartyQualification,
      'OppPartyMonthlyIncome': oppPartyMonthlyIncome,
      'OppPartyEmail': oppPartyEmail,

      'OppPartyPresentAddressOne': oppPartyPresentAddressOne,
      'OppPartyPresentAddressTwo': oppPartyPresentAddressTwo,
      'OppPartyPresentDistSlNo': oppPartyPresentDistSlNo,
      'OppPartyPresentCity': oppPartyPresentCity,
      'OppPartyPresentPin': oppPartyPresentPin,
      'OppPartyPresentPO': oppPartyPresentPO,
      'OppPartyPresentPS': oppPartyPresentPS,

      'OppPartyPerAddressOne': oppPartyPerAddressOne,
      'OppPartyPerAddressTwo': oppPartyPerAddressTwo,
      'OppPartyPerDistSlNo': oppPartyPerDistSlNo,
      'OppPartyPerCity': oppPartyPerCity,
      'OppPartyPerPin': oppPartyPerPin,
      'OppPartyPerPO': oppPartyPerPO,
      'OppPartyPerPS': oppPartyPerPS,

      'DetailedIncident': detailedIncident,
      'RequestWish': requestWish,
      'FileCaption': fileCaption,
  
    };
  }
}
