import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oscw/core/constants/app_urls.dart';
import 'package:oscw/core/di/injector.dart';
import 'package:oscw/core/local_storage/preferences.dart';
import 'package:oscw/core/localization/app_localizations.dart';
import 'package:oscw/core/theme/app_colors.dart';
import 'package:oscw/core/theme/app_text_styles.dart';
import 'package:oscw/features/complaint/data/models/complain_registration_model.dart';
import 'package:oscw/features/complaint/data/repository_impl/post_office.dart';
import 'package:oscw/features/complaint/presentation/bloc/complain_dropdown_bloc.dart';
import 'package:oscw/features/complaint/presentation/bloc/complain_dropdown_event.dart';
import 'package:oscw/features/complaint/presentation/bloc/complain_dropdwon_state.dart';
import 'package:oscw/features/complaint/presentation/bloc/complaint_registration/complaint_bloc.dart';
import 'package:oscw/features/complaint/presentation/bloc/complaint_registration/complaint_event.dart';
import 'package:oscw/features/complaint/presentation/bloc/complaint_registration/complaint_state.dart';
import 'package:oscw/features/complaint/presentation/bloc/district/district_bloc.dart';
import 'package:oscw/features/complaint/presentation/bloc/district/district_event.dart';
import 'package:oscw/features/complaint/presentation/bloc/district/district_state.dart';
import 'package:oscw/shared_widgets/app_app_bar.dart';
import 'package:oscw/shared_widgets/app_date_field.dart';
import 'package:oscw/shared_widgets/app_dropdown_field.dart';
import 'package:oscw/shared_widgets/app_file_picker_button.dart';
import 'package:oscw/shared_widgets/app_radio_group.dart';
import 'package:oscw/shared_widgets/app_text_form_field.dart';
import 'package:oscw/shared_widgets/validators.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ComplaintFormPage extends StatefulWidget {
  const ComplaintFormPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ComplaintFormPageState createState() => _ComplaintFormPageState();
}

class _ComplaintFormPageState extends State<ComplaintFormPage> {
final _formKey = GlobalKey<FormState>();

  // ================== Appellant Controllers ==================
final TextEditingController _pAddress1 = TextEditingController();
final TextEditingController _pAddress2 = TextEditingController();
final TextEditingController _pCity = TextEditingController();
final TextEditingController _pPin = TextEditingController();
final TextEditingController _pPostOffice = TextEditingController();
final TextEditingController _pPoliceStation = TextEditingController();
final TextEditingController _permAddress1 = TextEditingController();
final TextEditingController _permAddress2 = TextEditingController();
final TextEditingController _permCity = TextEditingController();
final TextEditingController _permPin = TextEditingController();
final TextEditingController _permPostOffice = TextEditingController();
final TextEditingController _permPoliceStation = TextEditingController();
final TextEditingController _pDistrictCtrl = TextEditingController(); 
final TextEditingController _permDistrictCtrl = TextEditingController(); 

final TextEditingController _opPDistrictCtrl = TextEditingController(); 
final TextEditingController _opPermDistrictCtrl = TextEditingController(); 


final TextEditingController _appellantNameCtrl = TextEditingController();
final TextEditingController _educationCtrl = TextEditingController();
final TextEditingController _mobileCtrl = TextEditingController();
final TextEditingController _whatsappCtrl = TextEditingController();
final TextEditingController _emailCtrl = TextEditingController();
final TextEditingController _ageCtrl = TextEditingController();
final TextEditingController _aadhaarCtrl = TextEditingController();
final TextEditingController _dobCtrl = TextEditingController();
final TextEditingController _marriageDateCtrl = TextEditingController(); 
final TextEditingController _otherRelationshipCtrl = TextEditingController();
final TextEditingController _incidentController = TextEditingController();
final TextEditingController _actionRequestController = TextEditingController();
final TextEditingController _fileCaptionController = TextEditingController();

// Post office state
List<DropdownItem> _pPostOfficeItems = [];
List<DropdownItem> _permPostOfficeItems = [];
bool _loadingPPostOffice = false;
bool _loadingPermPostOffice = false;


// ================== Opposite Party Controllers ==================
final TextEditingController _opPAddress1 = TextEditingController();
final TextEditingController _opPAddress2 = TextEditingController();
final TextEditingController _opPCity = TextEditingController();
final TextEditingController _opPPin = TextEditingController();
final TextEditingController _opPPostOffice = TextEditingController();
final TextEditingController _opPPoliceStation = TextEditingController();

final TextEditingController _opPermAddress1 = TextEditingController();
final TextEditingController _opPermAddress2 = TextEditingController();
final TextEditingController _opPermCity = TextEditingController();
final TextEditingController _opPermPin = TextEditingController();
final TextEditingController _opPermPostOffice = TextEditingController();
final TextEditingController _opPermPoliceStation = TextEditingController();

final TextEditingController _opNameCtrl = TextEditingController();
final TextEditingController _opMobileCtrl = TextEditingController();
final TextEditingController _opOccupationCtrl = TextEditingController();
final TextEditingController _opDobCtrl = TextEditingController();
final TextEditingController _opAgeCtrl = TextEditingController();
final TextEditingController _opEducationCtrl = TextEditingController();
final TextEditingController _opIncomeCtrl = TextEditingController();
final TextEditingController _opEmailCtrl = TextEditingController();

// Post office state for Opposite Party
List<DropdownItem> _opPPostOfficeItems = [];
List<DropdownItem> _opPermPostOfficeItems = [];
bool _loadingOpPPostOffice = false;
bool _loadingOpPermPostOffice = false;

// Same as Present checkbox
  String attactFile = '';
 String? fileCaption = ""; 
  final _focusNode = FocusNode();
  // Dismissing the keyboard when tapping anywhere outside of a text field
  void _unfocus() {
    FocusScope.of(context).requestFocus(FocusNode()); // Unfocus the current field
  }
  // =================== Dropdown & Radio Selections ===================
  DropdownItem? selectedSex;
  DropdownItem? selectedComplaint;
  String? otherComplaintText;
  DropdownItem? selectedRelationship;
  String? otherRelationshipText;
  DropdownItem? selectedChildren;
  DropdownItem? selectedCategory;
  DropdownItem? selectedDistrict;
  DropdownItem? _pDistrict;
  DropdownItem? _permDistrict;
  DropdownItem? _selectedPPostOffice;
  DropdownItem? _selectedPermPostOffice;
  DropdownItem? _selectedOpPPostOffice;
  DropdownItem? _selectedOpPermPostOffice;


  bool? _unwedMother;
  bool? _cyberCrime;
  bool? _isGovServant;

  bool _sameAsPresent = false;
  bool _opSameAsPresent = false;
  List<File> _attachments = [];

  String? opPermDistrictName;


 Future<void> _loadMobile() async {
  final prefs = Preferences(await SharedPreferences.getInstance());
  _mobileCtrl.text = prefs.getMobile() ?? '';
}


  // =================== Post Office Dropdown ===================
  @override
  void initState() {
    super.initState();

    // Appellant Present PIN listener
    _pPin.addListener(() {
      if (_pPin.text.length == 6) {
        _loadPresentPostOffices(_pPin.text);
      } else {
        setState(() {
        _pPostOfficeItems = [];
        _selectedPPostOffice = null;
        _pPostOffice.text = '';
      });
      }
    });

    // Appellant Permanent PIN listener
    _permPin.addListener(() {
      if (_permPin.text.length == 6 && !_sameAsPresent) {
        _loadPermanentPostOffices(_permPin.text);
      } else {
        setState(() {
        _permPostOfficeItems = [];
        _selectedPermPostOffice = null;
        _permPostOffice.text = '';
      });
      }
    });

    // Opposite Party Present PIN listener
    _opPPin.addListener(() {
      if (_opPPin.text.length == 6) {
        _loadOpPresentPostOffices(_opPPin.text);
      } else {
        setState(() {
        _opPPostOfficeItems = [];
        _selectedOpPPostOffice = null;
        _opPPostOffice.text = '';
      });
      }
    });

    // Opposite Party Permanent PIN listener
    _opPermPin.addListener(() {
      if (_opPermPin.text.length == 6 && !_opSameAsPresent) {
        _loadOpPermanentPostOffices(_opPermPin.text);
      } else {
        setState(() {
        _opPermPostOfficeItems = [];
        _selectedOpPermPostOffice = null;
        _opPermPostOffice.text = '';
      });
      }
    });

    _pAddress1.addListener(_handlePresentAddressChange);
    _pAddress2.addListener(_handlePresentAddressChange);
    _pCity.addListener(_handlePresentAddressChange);
    _pPin.addListener(_handlePresentAddressChange);
    _pPostOffice.addListener(_handlePresentAddressChange);
    _pPoliceStation.addListener(_handlePresentAddressChange);

   _loadMobile();
    
  }



  // Method to update the permanent address when the present address changes
  void _handlePresentAddressChange() {
    if (_sameAsPresent) {
      _copyPresentToPermanent();
    }
  }

  // =================== Load Post Offices ===================
Future<void> _loadPresentPostOffices(String pin) async {
  setState(() => _loadingPPostOffice = true);
  final items = await fetchPostOffices(pin);
  if (mounted) {
    setState(() {
      _pPostOfficeItems = items;
      _selectedPPostOffice = null; 
      _pPostOffice.text = '';      
      _loadingPPostOffice = false;
    });
  }
}

Future<void> _loadPermanentPostOffices(String pin) async {
  setState(() => _loadingPermPostOffice = true);
  final items = await fetchPostOffices(pin);
  if (mounted) {
    setState(() {
      _permPostOfficeItems = items;
      _selectedPermPostOffice = null; 
      _permPostOffice.text = '';
      _loadingPermPostOffice = false;
    });
  }
}

Future<void> _loadOpPresentPostOffices(String pin) async {
  setState(() => _loadingOpPPostOffice = true);
  final items = await fetchPostOffices(pin);
  if (mounted) {
    setState(() {
      _opPPostOfficeItems = items;
      _selectedOpPPostOffice = null;
      _opPPostOffice.text = '';
      _loadingOpPPostOffice = false;
    });
  }
}

Future<void> _loadOpPermanentPostOffices(String pin) async {
  setState(() => _loadingOpPermPostOffice = true);
  final items = await fetchPostOffices(pin);
  if (mounted) {
    setState(() {
      _opPermPostOfficeItems = items;
      _selectedOpPermPostOffice = null;
      _opPermPostOffice.text = '';
      _loadingOpPermPostOffice = false;
    });
  }
}

 // =================== Copy Functions ===================
   void _copyPresentToPermanent() {
  _permAddress1.text = _pAddress1.text;
  _permAddress2.text = _pAddress2.text;
  _permCity.text = _pCity.text;
  _permPin.text = _pPin.text;
  _permPostOffice.text = _pPostOffice.text;
  _permPoliceStation.text = _pPoliceStation.text;

  // Copy post office items
  _permPostOfficeItems = List.from(_pPostOfficeItems);

  // Set the selected dropdown item to match the present selection
  _selectedPermPostOffice = _selectedPPostOffice;

  _permDistrict = _pDistrict;

  setState(() {});
}

// For Opposite Party
void _copyOpPresentToPermanent() {
  _opPermAddress1.text = _opPAddress1.text;
  _opPermAddress2.text = _opPAddress2.text;
  _opPermCity.text = _opPCity.text;
  _opPermPin.text = _opPPin.text;
  _opPermPostOffice.text = _opPPostOffice.text;
  _opPermPoliceStation.text = _opPPoliceStation.text;

  // Copy post office items
  _opPermPostOfficeItems = List.from(_opPPostOfficeItems);

  // Set the selected dropdown item to match the present selection
  _selectedOpPermPostOffice = _selectedOpPPostOffice;

  // Copy district text
  _opPermDistrictCtrl.text = _opPDistrictCtrl.text;

  setState(() {});
}


  

  // =================== Address Section ===================

Widget _buildAddressSection({
  required AppLocalizations t, 
  required String title,
  required TextEditingController address1,
  required TextEditingController address2,
  required TextEditingController city,
  required TextEditingController pin,
  required TextEditingController postOffice,
  required TextEditingController policeStation,
  required List<DropdownItem> postOfficeItems,
  required DropdownItem? selectedPostOffice, 
  required bool loadingPostOffice,
  required bool sameAsPresent, 
  required String langCode,
  required bool isForAppellant,
  required TextEditingController districtCtrl, 
  required void Function(String) onDistrictEntered, 
  required DropdownItem? selectedDistrict, 
  required void Function(DropdownItem) onDistrictSelected, 
   required void Function(DropdownItem) onPostOfficeSelected,
     // FocusNode parameters
  required FocusNode address1FocusNode,
  required FocusNode address2FocusNode,
  required FocusNode cityFocusNode,
  required FocusNode pinFocusNode,
  required FocusNode postOfficeFocusNode,
  required FocusNode policeStationFocusNode,
  required FocusNode districtFocusNode,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: 12),
      Text(title, style: AppTextStyles.h1),
      const SizedBox(height: 12),

      AppTextFormField(
        label: t.translate('address_line_1'),
        controller: address1,
        enabled: !sameAsPresent,
        validator: requiredValidator,
       focusNode: address1FocusNode,
      ),
      const SizedBox(height: 8),
      AppTextFormField(
        label: t.translate('address_line_2'),
        controller: address2,
        enabled: !sameAsPresent,
        focusNode: address2FocusNode,
      ),
      const SizedBox(height: 8),
      AppTextFormField(
        label: t.translate('city'),
        controller: city,
        enabled: !sameAsPresent,
       focusNode: cityFocusNode,
      ),
      const SizedBox(height: 8),
      AppTextFormField(
        label: t.translate('pin_code'),
        controller: pin,
        enabled: !sameAsPresent,
        validator: pinValidator,
        focusNode: pinFocusNode,
        keyboardType: TextInputType.number,
      ),
      const SizedBox(height: 8),

// ================= Post Office Dropdown =================
    if (loadingPostOffice)
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircularProgressIndicator(),
        )
      else if (postOfficeItems.isNotEmpty)
        Builder(
          builder: (context) {
            final defaultItem = DropdownItem(id: -1, nameEng: 'Select Post Office', nameOdia: '');
            final poItems = [defaultItem] + postOfficeItems;

           return AppDropdownField(
              label: t.translate('post_office'),
              items: poItems,
                value: selectedPostOffice ?? defaultItem,
              enabled: !sameAsPresent,
              language: langCode,
              hint: t.translate('select_post_office'),
              onChanged: sameAsPresent
                  ? null
                  : (item, _) {
                      postOffice.text = item.id == -1 ? '' : item.nameEng;
                      onPostOfficeSelected(item); 
                    },
            );
          },
        )
      else
        AppTextFormField(
          label: t.translate('no_post_office_available'),
          controller: postOffice,
          enabled: false,
          validator: requiredValidator,
           focusNode: postOfficeFocusNode, 
        ),


      const SizedBox(height: 8),

      // District: Conditionally render dropdown or textfield based on `isForAppellant`
      if (isForAppellant)
        // Appellant Section (Dropdown for District)
        BlocProvider(
          create: (_) => sl<DistrictBloc>()..add(LoadDistricts()),
          child: BlocBuilder<DistrictBloc, DistrictState>(
            builder: (context, state) {
              if (state is DistrictLoading) return const CircularProgressIndicator();
              if (state is DistrictError) return Text(state.message);
              if (state is DistrictLoaded) {
                final items = state.items
                    .map((e) => DropdownItem(id: e.id, nameEng: e.nameEng, nameOdia: e.nameOdia))
                    .toList();

                return AppDropdownField(
                  label: t.translate('district'),
                  language: langCode,
                  items: items,
                  value: selectedDistrict,
                  enabled: !sameAsPresent,
                  onChanged: sameAsPresent ? null : (item, _) => onDistrictSelected(item),
                );
              }
              return const SizedBox();
            },
          ),
        )
      else
        // Opposite Party Section (TextField for District)
        AppTextFormField(
          label: t.translate('district'),
          controller: districtCtrl,
          enabled: !sameAsPresent,
          validator: requiredValidator,
          focusNode: districtFocusNode,
        ),

      const SizedBox(height: 8),

      AppTextFormField(
        label: t.translate('police_station'),
        controller: policeStation,
        enabled: !sameAsPresent,
        focusNode: policeStationFocusNode,
      ),
      const SizedBox(height: 16),
    ],
  );
}


@override
  void dispose() {
    // Don't forget to dispose the listeners
    _pAddress1.removeListener(_handlePresentAddressChange);
    _pAddress2.removeListener(_handlePresentAddressChange);
    _pCity.removeListener(_handlePresentAddressChange);
    _pPin.removeListener(_handlePresentAddressChange);
    _pPostOffice.removeListener(_handlePresentAddressChange);
    _pPoliceStation.removeListener(_handlePresentAddressChange);
    _pAddress1.dispose();
    _pAddress2.dispose();
    _pCity.dispose();
    _pPin.dispose();
    _pPostOffice.dispose();
    _pPoliceStation.dispose();
    _permAddress1.dispose();
    _permAddress2.dispose();
    _permCity.dispose();
    _permPin.dispose();
    _permPostOffice.dispose();
    _permPoliceStation.dispose();

    _opPAddress1.dispose();
    _opPAddress2.dispose();
    _opPCity.dispose();
    _opPPin.dispose();
    _opPPostOffice.dispose();
    _opPPoliceStation.dispose();

    _opPermAddress1.dispose();
    _opPermAddress2.dispose();
    _opPermCity.dispose();
    _opPermPin.dispose();
    _opPermPostOffice.dispose();
    _opPermPoliceStation.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  final _appellantNameFocusNode = FocusNode();
  final _educationFocusNode = FocusNode();
  final _mobileFocusNode = FocusNode();
  final _whatsappFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _ageFocusNode = FocusNode();
  final _aadhaarFocusNode = FocusNode();
  final _otherRelationFocusNode = FocusNode();
  final _opNameFocusNode = FocusNode();
  final _opMobileFocusNode = FocusNode();
  final _opOccupationFocusNode = FocusNode();
  final _opAgeFocusNode = FocusNode();
  final _opEducationFocusNode = FocusNode();
  final _opIncomeFocusNode = FocusNode();
  final _opEmailFocusNode = FocusNode();
  // Appellant Present Address Focus Nodes
  final _pAddress1FocusNode = FocusNode();
  final _pAddress2FocusNode = FocusNode();
  final _pCityFocusNode = FocusNode();
  final _pPinFocusNode = FocusNode();
  final _pPostOfficeFocusNode = FocusNode();
  final _pPoliceStationFocusNode = FocusNode();
  final _pDistrictFocusNode = FocusNode();

  // Appellant Permanent Address Focus Nodes
  final _permAddress1FocusNode = FocusNode();
  final _permAddress2FocusNode = FocusNode();
  final _permCityFocusNode = FocusNode();
  final _permPinFocusNode = FocusNode();
  final _permPostOfficeFocusNode = FocusNode();
  final _permPoliceStationFocusNode = FocusNode();
  final _permDistrictFocusNode = FocusNode();
  final incidentFocusNode = FocusNode();
  final otherFocusNode = FocusNode();
  final _captionFocusNode = FocusNode();

 // Opposite Party Present Address Focus Nodes
  final _opPAddress1FocusNode = FocusNode();
  final _opPAddress2FocusNode = FocusNode();
  final _opPCityFocusNode = FocusNode();
  final _opPPinFocusNode = FocusNode();
  final _opPPostOfficeFocusNode = FocusNode();
  final _opPPoliceStationFocusNode = FocusNode();
  final _opPDistrictFocusNode = FocusNode();

 // Opposite Party Permanent Address Focus Nodes
  final _opPermAddress1FocusNode = FocusNode();
  final _opPermAddress2FocusNode = FocusNode();
  final _opPermCityFocusNode = FocusNode();
  final _opPermPinFocusNode = FocusNode();
  final _opPermPostOfficeFocusNode = FocusNode();
  final _opPermPoliceStationFocusNode = FocusNode();
  final _opPermDistrictFocusNode = FocusNode();



  // =================== Section Title ===================
  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24,color: AppColors.primary)),
    );
  }

  // =================== Build Method ===================
  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final langCode = Localizations.localeOf(context).languageCode;
    return  BlocListener<ComplaintBloc, ComplaintState>(
    listener: (context, state) {
      if (state is ComplaintSuccess) {
        _showSuccessDialog(state.response.referenceNo);
        _clearForm();
      }

      if (state is ComplaintFailure) {
        _showError(state.message);
      }
    },
      child: Stack(
        children: [
          Scaffold(
         resizeToAvoidBottomInset: true,
          appBar: AppAppBar(
            title: t.translate('complaint_form_title'),
            subtitle: t.translate('govt_odisha'),
            showBack: true,
          ),
          body:GestureDetector(
           onTap: _unfocus, 
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ================= Appellant Details =================
                  _sectionTitle(t.translate('details_appellant')),
                    SizedBox(height: 10,),
                   AppTextFormField(
                    label: t.translate('name'),
                     controller: _appellantNameCtrl,
                    validator: requiredValidator, 
                    keyboardType: TextInputType.text,
                    focusNode: _appellantNameFocusNode,
                  ),
                    AppDropdownField(
                            label: t.translate('sex'),
                            language: langCode, 
                            value: selectedSex,
                            items: [
                              DropdownItem(nameEng: t.translate('male'), nameOdia: t.translate('male')),
                              DropdownItem(nameEng: t.translate('female'), nameOdia: t.translate('female')),
                              DropdownItem(nameEng: t.translate('other'), nameOdia: t.translate('other')),
                            ],
                            onChanged: (item, _) {
                              setState(() => selectedSex = item);
                            },
                          ),
                        
                    // Complaint Type with BlocProvider
                    BlocProvider(
                      create: (_) => sl<DropdownBloc>()..add(LoadDropdownItems()),
                      child: BlocBuilder<DropdownBloc, DropdownState>(
                        builder: (context, state) {
                          if (state is DropdownLoading) return const CircularProgressIndicator();
                          if (state is DropdownError) return Text(state.message);
                          if (state is DropdownLoaded) {
                            final items = state.items
                                .map((e) => DropdownItem(id: e.id, nameEng: e.nameEng, nameOdia: e.nameOdia))
                                .toList();
                            items.add(DropdownItem(nameEng: 'Other', nameOdia: 'ଅନ୍ୟ'));
                            return AppDropdownField(
                             label: t.translate('complaint_category'),
                              language: langCode,
                               value: selectedComplaint,
                              items: items,
                              onChanged: (item, otherText) {
                                setState(() {
                                  selectedComplaint = item;
                                  otherComplaintText = otherText;
                                });
                              },
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                    ),
                        
                        AppTextFormField(label: t.translate('education'),
                        controller: _educationCtrl,
                        keyboardType: TextInputType.text,
                        focusNode: _educationFocusNode,),
                        AppTextFormField(
                              label: t.translate('mobile'),
                              validator: mobileValidator,  
                              controller: _mobileCtrl,
                              keyboardType: TextInputType.phone, 
                              maxLength: 10,
                              readOnly: true,
                              focusNode: _mobileFocusNode,
                          ),
                        AppTextFormField(label: t.translate('whatsapp'),
                        validator: mobileValidator,  
                         controller: _whatsappCtrl,
                         keyboardType: TextInputType.phone, 
                          maxLength: 10,
                          focusNode: _whatsappFocusNode,),
                        AppTextFormField(
                          label: t.translate('email'),
                           validator: emailValidator, 
                           controller: _emailCtrl,
                           keyboardType: TextInputType.emailAddress,
                           focusNode: _emailFocusNode,
                        ),
                        AppDateField(label: t.translate('dob'),
                          controller: _dobCtrl,
                          ageController: _ageCtrl,
                  
                          ),
                        AppTextFormField(label: t.translate('age'),
                          controller: _ageCtrl,
                          keyboardType: TextInputType.number,
                          readOnly: true, 
                          focusNode: _ageFocusNode,
                          ),
                        AppTextFormField(
                            label: t.translate('aadhaar'),
                            validator: aadhaarValidator, 
                            controller: _aadhaarCtrl, 
                            keyboardType: TextInputType.phone, 
                            maxLength: 12,
                            focusNode: _aadhaarFocusNode,
                         ),
                        AppDateField(label: t.translate('date_of_marriage'),
                          controller: _marriageDateCtrl,),
                        
                   
                             AppDropdownField(
                                      label: t.translate('relationship'),
                                      language: langCode,
                                       value: selectedRelationship,
                                      items: [
                                       DropdownItem(nameEng: t.translate('husband'), nameOdia: t.translate('husband')),
                                       DropdownItem(nameEng: t.translate('brother_in_law'), nameOdia: t.translate('brother_in_law')),
                                       DropdownItem(nameEng: t.translate('neighbours'), nameOdia: t.translate('neighbours')),
                                       DropdownItem(nameEng: t.translate('others'), nameOdia: t.translate('others')),
                                     ],
                                 onChanged: (item, otherText) {
                                 setState(() {
                                     selectedRelationship = item;
                                     //otherRelationshipText = otherText;
                                     _otherRelationshipCtrl.clear();
                              });
                             },
                            ),
                    
                          // Conditionally render the AppTextFormField if "Others" is selected
                           if (selectedRelationship != null && selectedRelationship!.nameEng == t.translate('others'))
                            AppTextFormField(
                                label: t.translate('enter_relationship'),
                                controller: _otherRelationshipCtrl,
                                focusNode: _otherRelationFocusNode,
                                validator: (value) {
                                 if (value == null || value.isEmpty) {
                                       return t.translate('please_enter_relationship');
                              }
                                 return null;
                              },
                             ),
                           AppDropdownField(
                            label: t.translate('number_of_children'),
                            language: langCode,
                            value: selectedChildren,
                            items: List.generate(
                              10,
                              (i) => DropdownItem(
                                nameEng: '${i + 0}',
                                nameOdia: odiaNumber(i + 0), 
                              ),
                            ),
                            onChanged: (item, _) {
                              setState(() => selectedChildren = item);
                            },
                          ),
                          
                      // Category
                          AppDropdownField(
                            label: t.translate('category'),
                            language: langCode,
                            value: selectedCategory,
                            items: [
                              DropdownItem(nameEng: t.translate('general'), nameOdia: t.translate('general')),
                              DropdownItem(nameEng: t.translate('SEBC'), nameOdia: t.translate('SEBC')),
                              DropdownItem(nameEng: t.translate('OBC'), nameOdia: t.translate('OBC')),
                              DropdownItem(nameEng: t.translate('SC'), nameOdia: t.translate('SC')),
                              DropdownItem(nameEng: t.translate('ST'), nameOdia: t.translate('ST')),
                            ],
                            onChanged: (item, _) {
                              setState(() => selectedCategory = item);
                            },
                          ),
                          AppRadioGroup(
                              labelKey: 'unwed_mother',
                              value: _unwedMother,
                              onChanged: (val) {
                               setState(() => _unwedMother = val);
                           },
                         ),
            
                       AppRadioGroup(
                            labelKey: 'cyber_crime',
                            value: _cyberCrime,
                            onChanged: (val) {
                            setState(() => _cyberCrime = val);
                         },
                       ),
            
                       AppRadioGroup(
                          labelKey: 'govt_servant',
                          value: _isGovServant,
                          onChanged: (val) {
                              setState(() => _isGovServant = val);
                          },
                        ),
            
                    
                        
                        const SizedBox(height: 24),
                        
                   
                       // ===== Appellant Present Address =====
                           _buildAddressSection(
                                         t: t,
                                         title: t.translate('present_address'),
                                         address1: _pAddress1,
                                         address2: _pAddress2,
                                         city: _pCity,
                                         pin: _pPin,
                                         postOffice: _pPostOffice,
                                         policeStation: _pPoliceStation,
                                         postOfficeItems: _pPostOfficeItems,
                                          selectedPostOffice: _selectedPPostOffice, 
                                         loadingPostOffice: _loadingPPostOffice,
                                         sameAsPresent: false,
                                         langCode: langCode,
                                         isForAppellant: true,
                                         districtCtrl: _pDistrictCtrl,
                                         onDistrictEntered: (value) {},
                                         selectedDistrict: _pDistrict,
                                         onDistrictSelected: (item) => setState(() => _pDistrict = item),
                                         onPostOfficeSelected: (item) => setState(() => _selectedPPostOffice = item),
                                          
                                            // Pass FocusNodes for Present Address
                                             address1FocusNode: _pAddress1FocusNode,
                                             address2FocusNode: _pAddress2FocusNode,
                                             cityFocusNode: _pCityFocusNode,
                                             pinFocusNode: _pPinFocusNode,
                                             postOfficeFocusNode: _pPostOfficeFocusNode,
                                             policeStationFocusNode: _pPoliceStationFocusNode,
                                             districtFocusNode: _pDistrictFocusNode,
                                      ),
                
                        
                                        // Same as Present checkbox
                                     CheckboxListTile(
                                    value: _sameAsPresent,
                                    onChanged: (val) {
                                    setState(() {
                                        _sameAsPresent = val ?? false;
                                        if (_sameAsPresent) _copyPresentToPermanent();
                                   });
                                 },
                                   title: Text(t.translate('same_as_present_address'), style: AppTextStyles.body),
                                   controlAffinity: ListTileControlAffinity.leading,
                                 ),
                        
                                  // Permanent Address
                                  _buildAddressSection(
                                                  t: t,
                                                  title: t.translate('permanent_address'),
                                                  address1: _permAddress1,
                                                  address2: _permAddress2,
                                                  city: _permCity,
                                                  pin: _permPin,
                                                  postOffice: _permPostOffice,
                                                  policeStation: _permPoliceStation,
                                                  postOfficeItems: _permPostOfficeItems,
                                                  loadingPostOffice: _loadingPermPostOffice,
                                                  selectedPostOffice: _selectedPermPostOffice, 
                                                  sameAsPresent: _sameAsPresent,
                                                  langCode: langCode,
                                                  isForAppellant: true, 
                                                  selectedDistrict: _permDistrict,
                                                  onDistrictSelected: (item) => setState(() => _permDistrict = item), 
                                                  districtCtrl: _permDistrictCtrl, 
                                                  onDistrictEntered: (value) {},
                                                  onPostOfficeSelected: (item) => setState(() => _selectedPermPostOffice = item),
                                                   // Pass FocusNodes for Permanent Address
                                                  address1FocusNode: _permAddress1FocusNode,
                                                  address2FocusNode: _permAddress2FocusNode,
                                                  cityFocusNode: _permCityFocusNode,
                                                  pinFocusNode: _permPinFocusNode,
                                                  postOfficeFocusNode: _permPostOfficeFocusNode,
                                                  policeStationFocusNode: _permPoliceStationFocusNode,
                                                  districtFocusNode: _permDistrictFocusNode,
            
                                  ),
                
                                 const SizedBox(height: 15),
                        
                              // ================= Opposite Party Details =================
                               _sectionTitle(t.translate('detail_of_opposite_party')),
                                 SizedBox(height: 10,),
                                  AppTextFormField(label: t.translate('name'),
                                  validator: requiredValidator,
                                    controller: _opNameCtrl,
                                    focusNode: _opNameFocusNode,
                                    keyboardType: TextInputType.name,),
                                  AppTextFormField(label: t.translate('mobile'),
                                  validator: mobileValidator,
                                    controller: _opMobileCtrl,
                                    keyboardType: TextInputType.phone, 
                                    maxLength: 10,
                                    focusNode: _opMobileFocusNode,),
                                  AppTextFormField(label: t.translate('occupation'),
                                   controller: _opOccupationCtrl,
                                   focusNode: _opOccupationFocusNode,),
                                  AppDateField(label: t.translate('dob'),
                                    controller: _opDobCtrl,
                                     ageController: _opAgeCtrl,),
                                  AppTextFormField(label: t.translate('age'),
                                   controller: _opAgeCtrl,
                                   keyboardType: TextInputType.number,
                                    readOnly: true, 
                                    focusNode: _opAgeFocusNode,),
                                  AppTextFormField(label: t.translate('education'),
                                    controller: _opEducationCtrl,
                                    focusNode: _opEducationFocusNode,),
                                  AppTextFormField(label: t.translate('monthly_income'),
                                    controller: _opIncomeCtrl,
                                    keyboardType: TextInputType.phone, 
                                    focusNode: _opIncomeFocusNode,
                                   ),
                                  AppTextFormField(label: t.translate('opposite_party_email'),
                                  validator: emailValidator,
                                   controller: _opEmailCtrl,
                                   keyboardType: TextInputType.emailAddress,
                                   focusNode: _opEmailFocusNode,),
                        
                               // Opposite Party Present Address
                 
                           _buildAddressSection(
                                           t: t,
                                           title: t.translate('present_address'),
                                           address1: _opPAddress1,
                                           address2: _opPAddress2,
                                           city: _opPCity,
                                           pin: _opPPin,
                                           postOffice: _opPPostOffice,
                                           policeStation: _opPPoliceStation,
                                           postOfficeItems: _opPPostOfficeItems,
                                           loadingPostOffice: _loadingOpPPostOffice,
                                           selectedPostOffice: _selectedOpPPostOffice, 
                                           sameAsPresent: false,
                                           langCode: langCode,
                                           isForAppellant: false, 
                                           districtCtrl: _opPDistrictCtrl,
                                            onDistrictEntered: (value) {
                                            setState(() {
                                                 opPermDistrictName = value; 
                                           });
                                          },
                                          selectedDistrict: null, 
                                           onDistrictSelected: (item) {},
                                           onPostOfficeSelected: (item) => setState(() => _selectedOpPPostOffice = item),
                                    
                                             // Pass FocusNodes for Opposite Party Present Address
                                           address1FocusNode: _opPAddress1FocusNode,
                                           address2FocusNode: _opPAddress2FocusNode,
                                           cityFocusNode: _opPCityFocusNode,
                                           pinFocusNode: _opPPinFocusNode,
                                           postOfficeFocusNode: _opPPostOfficeFocusNode,
                                           policeStationFocusNode: _opPPoliceStationFocusNode,
                                           districtFocusNode: _opPDistrictFocusNode,
                                      ),
                
                        
                                   // Opposite Party Same as Present checkbox
                                     CheckboxListTile(
                                          value: _opSameAsPresent,
                                          onChanged: (val) {
                                          setState(() {
                                         _opSameAsPresent = val ?? false;
                                         if (_opSameAsPresent) _copyOpPresentToPermanent();
                                      });
                                    },
                                  title: Text(t.translate('same_as_present_address'), style: AppTextStyles.body),
                                    controlAffinity: ListTileControlAffinity.leading,
                                 ),
                        
                               // Opposite Party Permanent Address
                                  _buildAddressSection(
                                                 t: t,
                                                 title: t.translate('permanent_address'),
                                                 address1: _opPermAddress1,
                                                 address2: _opPermAddress2,
                                                 city: _opPermCity,
                                                 pin: _opPermPin,
                                                 postOffice: _opPermPostOffice,
                                                 policeStation: _opPermPoliceStation,
                                                 postOfficeItems: _opPermPostOfficeItems,
                                                 loadingPostOffice: _loadingOpPermPostOffice,
                                                  selectedPostOffice: _selectedOpPermPostOffice, 
                                                 sameAsPresent: _opSameAsPresent,
                                                 langCode: langCode,
                                                 isForAppellant: false,
                                                 districtCtrl: _opPermDistrictCtrl,
                                                  onDistrictEntered: (value) {
                                                   setState(() {
                                                        opPermDistrictName = value; 
                                                   });
                                                 },
                                              selectedDistrict: null,
                                                  onDistrictSelected: (item) {},
                                                   onPostOfficeSelected: (item) => setState(() => _selectedOpPermPostOffice = item),
                                                    // Pass FocusNodes for Opposite Party Permanent Address
                                                  address1FocusNode: _opPermAddress1FocusNode,
                                                  address2FocusNode: _opPermAddress2FocusNode,
                                                  cityFocusNode: _opPermCityFocusNode,
                                                   pinFocusNode: _opPermPinFocusNode,
                                                   postOfficeFocusNode: _opPermPostOfficeFocusNode,
                                                   policeStationFocusNode: _opPermPoliceStationFocusNode,
                                                   districtFocusNode: _opPermDistrictFocusNode,
                                    ),
                
                      const SizedBox(height: 15),
                        _sectionTitle(t.translate('other_details')),
                  
                      AppTextFormField(
                                label: t.translate('incident_detail'),
                                controller: _incidentController,
                                maxLines: 4,
                                validator: requiredValidator,
                                focusNode: incidentFocusNode,
                         ),
                    
                        AppTextFormField(
                          label: t.translate('action_request'),
                          maxLines: 4,
                          controller: _actionRequestController,
                          focusNode: otherFocusNode,
                        ),
                  
                        const SizedBox(height: 24),
                        _sectionTitle(t.translate('attach_document')),
                  
                     
                        AppFilePickerField(
                                 maxSizeMB: 5,
                                 allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
                                 files: _attachments,
                                 onFilesSelected: (files) {
                                  setState(() {
                                         _attachments = files;
                                });
                              },
                            ),
                          AppTextFormField(
                          label: t.translate('caption'),
                          controller: _fileCaptionController,
                          validator: requiredValidator,
                          focusNode:_captionFocusNode ,
                        ),
                  
                        const SizedBox(height: 40),
                  
                        Row(
                             children: [
                        // ---------------- CLEAR BUTTON ----------------
                         Expanded(
                              child: OutlinedButton(
                                   onPressed: _clearForm,
                                  child: Text(t.translate('clear')),
                             ),
                           ),
            
                          const SizedBox(width: 16),
            
                               // ---------------- SUBMIT BUTTON ----------------
                                 Expanded(
                                child: ElevatedButton(
                                onPressed: () {
                                     if (!_formKey.currentState!.validate()) return;
            
                                 // ---- DROPDOWN CHECKS ----
                               if (selectedSex == null) {
                                      _showError('Please select Sex');
                                        return;
                               }
            
                               if (selectedComplaint == null) {
                                    _showError('Please select Complaint Type');
                                    return;
                                  }
            
                                if (selectedRelationship == null) {
                                  _showError('Please select Relationship');
                                   return;
                                }
            
                                  if (_pDistrict == null) {
                                      _showError('Please select Appellant District');
                                   return;
                                }
            
                                 // Opposite Party Present Address
                               if (_opPDistrictCtrl.text.isEmpty) {
                                _showError('Please enter Opposite Party Present District');
                                   return; 
                               }
            
                                   // ---- FILE ----
                                  if (_attachments.isEmpty) {
                                       _showError('Please attach document');
                                          return;
                               }
            
                             // ---- SUBMIT FORM ----
                                _submitForm(context);
            
                        
                         },
                           style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            ),
                            child: Text(
                              t.translate('submit'),
                              style: AppTextStyles.button,
                           ),
                          ),
                        ),
                      ],
                    )
                      ]
                        
                ),
              )
            ),
          ),
        ),
         /// ================= LOADER OVERLAY =================
      BlocBuilder<ComplaintBloc, ComplaintState>(
        builder: (context, state) {
          if (state is ComplaintLoading) {
            return Container(
              color: Colors.black.withOpacity(0.3),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
        ]
      ),
    );

  
  }

void _showError(String message) {
  if (!mounted) return;

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    ),
  );
}

  


void _submitForm(BuildContext context) {
  String relationshipToSubmit = selectedRelationship?.nameEng ?? '';

  if (_otherRelationshipCtrl.text.isNotEmpty) {
    relationshipToSubmit = _otherRelationshipCtrl.text;
  }

  final fileCaption =
      _fileCaptionController.text.isNotEmpty ? _fileCaptionController.text : "";

  // ================= FILE DEBUG =================
  if (_attachments.isNotEmpty) {
    debugPrint('Total selected files: ${_attachments.length}');
    for (final file in _attachments) {
      final fileName = file.path.split('/').last;
      debugPrint('File selected: $fileName');
      debugPrint('File path: ${file.path}');
    }
  }

  final request = ComplaintRequestModel(
    // ================= META =================
    registerDate: DateTime.now().toIso8601String(),
    modeOfCommunication: "7",

    // ================= APPELLANT =================
    appellantName: _appellantNameCtrl.text,
    complainType: selectedComplaint?.id ?? 0,
    appellantEducation: _educationCtrl.text,
    appellantMobile: _mobileCtrl.text,
    appellantWhatsapp: _whatsappCtrl.text,
    appellantEmail: _emailCtrl.text,
    appellantAadhar: _aadhaarCtrl.text,
    appellantDOB: _dobCtrl.text.isNotEmpty
        ? DateTime.parse(convertToIso8601(_dobCtrl.text))
            .toUtc()
            .toIso8601String()
        : "",
    appellantAge: int.tryParse(_ageCtrl.text) ?? 0,
    dateOfMarriage: _marriageDateCtrl.text.isNotEmpty
        ? DateTime.parse(convertToIso8601(_marriageDateCtrl.text))
            .toUtc()
            .toIso8601String()
        : "",
    relationship: relationshipToSubmit,
    numberOfChildren:
        int.tryParse(selectedChildren?.nameEng ?? '0') ?? 0,
    category: selectedCategory?.nameEng ?? "",
    unwedMother: _unwedMother == true ? "Yes" : "No",
    cyberCrime: _cyberCrime == true ? "Yes" : "No",
    isGovServant: _isGovServant == true ? "Yes" : "No",

    // ================= APPELLANT PRESENT ADDRESS =================
    appellantPresentAddressOne: _pAddress1.text,
    appellantPresentAddressTwo: _pAddress2.text,
    appellantPresentDistSlNo: _pDistrict!.id!,
    appellantPresentCity: _pCity.text,
    appellantPresentPin: _pPin.text,
    appellantPresentPO: _selectedPPostOffice?.nameEng ?? '',
    appellantPresentPS: _pPoliceStation.text,

    // ================= APPELLANT PERMANENT ADDRESS =================
    appellantPerAddressOne: _permAddress1.text,
    appellantPerAddressTwo: _permAddress2.text,
    appellantPerDistSlNo: (_permDistrict ?? _pDistrict)!.id!,
    appellantPerCity: _permCity.text,
    appellantPerPin: _permPin.text,
    appellantPerPO: _selectedPermPostOffice?.nameEng ?? '',
    appellantPerPS: _permPoliceStation.text,

    // ================= OPPOSITE PARTY =================
    oppPartyName: _opNameCtrl.text,
    oppPartyMobile: _opMobileCtrl.text,
    oppPartyOccupation: _opOccupationCtrl.text,
    oppPartyDOB: _opDobCtrl.text.isNotEmpty
        ? DateTime.parse(convertToIso8601(_opDobCtrl.text))
            .toUtc()
            .toIso8601String()
        : "",
    oppPartyAge: int.tryParse(_opAgeCtrl.text) ?? 0,
    oppPartyQualification: _opEducationCtrl.text,
    oppPartyMonthlyIncome: _opIncomeCtrl.text,
    oppPartyEmail: _opEmailCtrl.text,

    // ================= OPPOSITE PARTY PRESENT ADDRESS =================
    oppPartyPresentAddressOne: _opPAddress1.text,
    oppPartyPresentAddressTwo: _opPAddress2.text,
    oppPartyPresentDistSlNo: _opPDistrictCtrl.text,
    oppPartyPresentCity: _opPCity.text,
    oppPartyPresentPin: _opPPin.text,
    oppPartyPresentPO: _selectedOpPPostOffice?.nameEng ?? '',
    oppPartyPresentPS: _opPPoliceStation.text,

    // ================= OPPOSITE PARTY PERMANENT ADDRESS =================
    oppPartyPerAddressOne: _opPermAddress1.text,
    oppPartyPerAddressTwo: _opPermAddress2.text,
    oppPartyPerDistSlNo: _opPermDistrictCtrl.text,
    oppPartyPerCity: _opPermCity.text,
    oppPartyPerPin: _opPermPin.text,
    oppPartyPerPO: _selectedOpPermPostOffice?.nameEng ?? '',
    oppPartyPerPS: _opPermPoliceStation.text,

    // ================= OTHER DETAILS =================
    detailedIncident: _incidentController.text,
    requestWish: _actionRequestController.text,

    // ================= FILES =================
    attactFiles: _attachments.isNotEmpty ? _attachments : null,
    fileCaption: fileCaption,
  );

  debugPrint('Request JSON (without files):');
  context.read<ComplaintBloc>().add(
        SubmitComplaintEvent(request),
      );
}

void _showSuccessDialog(String referenceNo) {
  if (!mounted) return;

  // Show the SnackBar first
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('Complaint submitted successfully!'),
      duration: Duration(seconds: 3),
      backgroundColor: AppColors.success,
    ),
  );

  // Show the success dialog
  showDialog(
    context: context,
    barrierDismissible: false,  // Prevent closing the dialog until user clicks 'OK'
    builder: (dialogContext) => AlertDialog(
      title: const Text("Success"),
      content: Text(
        "Complaint submitted successfully.\n\nReference No:\n$referenceNo",
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(dialogContext).pop();  // Close the dialog
            if (mounted) {
              Navigator.of(context).pop();  
            }
          },
          child: const Text("OK"),
        ),
      ],
    ),
  );
}


 void _clearForm() {
    _formKey.currentState?.reset();

    // Clear all controllers
    for (final c in [
      _appellantNameCtrl,
      _educationCtrl,
      _mobileCtrl,
      _whatsappCtrl,
      _emailCtrl,
      _aadhaarCtrl,
      _dobCtrl,
      _ageCtrl,
      _marriageDateCtrl,
      _opNameCtrl,
      _opMobileCtrl,
      _opOccupationCtrl,
      _opDobCtrl,
      _opAgeCtrl,
      _opEducationCtrl,
      _opIncomeCtrl,
      _opEmailCtrl,
      _incidentController,
      _actionRequestController,
      _opPDistrictCtrl,
      _opPermDistrictCtrl,
      _pAddress1,
      _pAddress2,
      _pCity,
      _pPin,
      _pPostOffice,
      _pPoliceStation,
      _permAddress1,
      _permAddress2,
      _permCity,
      _permPin,
      _permPostOffice,
      _permPoliceStation,
      _pDistrictCtrl,
      _permDistrictCtrl,
      _opPAddress1,
      _opPAddress2,
      _opPCity,
      _opPPin,
      _opPPostOffice,
      _opPPoliceStation,
      _opPermAddress1,
      _opPermAddress2,
      _opPermCity,
      _opPermPin,
      _opPermPostOffice,
      _opPermPoliceStation,
    ]) {
      c.clear();
    }

    setState(() {
      selectedSex = null;
      selectedComplaint = null;
      selectedRelationship = null;
      otherComplaintText = null;
      otherRelationshipText = null;
      selectedChildren = null;
      selectedCategory = null;
      _pDistrict = null;
      _permDistrict = null;

      _unwedMother = null;
      _cyberCrime = null;
      _isGovServant = null;

      _attachments.clear();
      _sameAsPresent = false;
      _opSameAsPresent = false;
    });
  }





}

