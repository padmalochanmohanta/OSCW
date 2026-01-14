import 'package:flutter/material.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared_widgets/app_app_bar.dart';
import '../../../shared_widgets/app_date_field.dart';
import '../../../shared_widgets/app_dropdown_field.dart';
import '../../../shared_widgets/app_file_picker_button.dart';
import '../../../shared_widgets/app_radio_group.dart';
import '../../../shared_widgets/app_text_form_field.dart';

class GiveComplaintPage extends StatefulWidget {
  const GiveComplaintPage({super.key});

  @override
  State<GiveComplaintPage> createState() => _GiveComplaintPageState();
}

class _GiveComplaintPageState extends State<GiveComplaintPage> {
  bool _sameAsPresent = false;

  // ---------------- PRESENT ADDRESS ----------------
  final _pAddress1 = TextEditingController();
  final _pAddress2 = TextEditingController();
  final _pCity = TextEditingController();
  final _pPin = TextEditingController();
  final _pPostOffice = TextEditingController();
  final _pPoliceStation = TextEditingController();

  // ---------------- PERMANENT ADDRESS ----------------
  final _permAddress1 = TextEditingController();
  final _permAddress2 = TextEditingController();
  final _permCity = TextEditingController();
  final _permPin = TextEditingController();
  final _permPostOffice = TextEditingController();
  final _permPoliceStation = TextEditingController();

  void _copyPresentToPermanent() {
    _permAddress1.text = _pAddress1.text;
    _permAddress2.text = _pAddress2.text;
    _permCity.text = _pCity.text;
    _permPin.text = _pPin.text;
    _permPostOffice.text = _pPostOffice.text;
    _permPoliceStation.text = _pPoliceStation.text;
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppAppBar(
        title: t.translate('complaint_form_title'),
        subtitle: t.translate('govt_odisha'),
        showBack: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle(t.translate('details_appellant')),

            AppTextFormField(label: t.translate('name')),
            AppDropdownField(
              label: t.translate('sex'),
              items: [
                t.translate('male'),
                t.translate('female'),
                t.translate('other'),
              ],
            ),
            AppDropdownField(
              label: t.translate('complaint_type'),
              items: [
                t.translate('dowry_death'),
                t.translate('suspected_death'),
                t.translate('dowry_desertion'),
                t.translate('domestic_violence'),
                t.translate('rape'),
                t.translate('false_promise_to_marry'),
                t.translate('kidnap'),
                t.translate('property_right'),
                t.translate('sexual_harassment'),
                t.translate('service_harassment'),
                t.translate('outrage_modesty'),
                t.translate('women_right_violation'),
                t.translate('cyber_crime'),
                t.translate('others'),
              ],
            ),

            AppTextFormField(label: t.translate('education')),
            AppTextFormField(label: t.translate('mobile')),
            AppTextFormField(label: t.translate('whatsapp')),
            AppTextFormField(label: t.translate('email')),
            AppDateField(label: t.translate('dob')),
            AppTextFormField(label: t.translate('age')),
            AppTextFormField(label: t.translate('aadhaar')),
            AppDateField(label: t.translate('date_of_marriage')),

            AppRadioGroup(labelKey: 'unwed_mother'),
            AppRadioGroup(labelKey: 'cyber_crime'),
            AppRadioGroup(labelKey: 'govt_servant'),

            const SizedBox(height: 24),
            _sectionTitle(t.translate('present_address')),

            AppTextFormField(
              label: t.translate('address_line_1'),
              controller: _pAddress1,
            ),
            AppTextFormField(
              label: t.translate('address_line_2'),
              controller: _pAddress2,
            ),
            AppTextFormField(
              label: t.translate('city'),
              controller: _pCity,
            ),
            AppTextFormField(
              label: t.translate('pin_code'),
              controller: _pPin,
            ),
            AppTextFormField(
              label: t.translate('post_office'),
              controller: _pPostOffice,
            ),
            AppTextFormField(
              label: t.translate('police_station'),
              controller: _pPoliceStation,
            ),

            const SizedBox(height: 10),

            /// ✅ SAME AS PRESENT CHECKBOX
            CheckboxListTile(
              value: _sameAsPresent,
              onChanged: (val) {
                setState(() {
                  _sameAsPresent = val ?? false;
                  if (_sameAsPresent) {
                    _copyPresentToPermanent();
                  }
                });
              },
              title: Text(
                t.translate('same_as_present_address'),
                style: AppTextStyles.body,
              ),
              controlAffinity: ListTileControlAffinity.leading,
            ),

            const SizedBox(height: 12),
            _sectionTitle(t.translate('permanent_address')),

            AppTextFormField(
              label: t.translate('address_line_1'),
              controller: _permAddress1,
              enabled: !_sameAsPresent,
            ),
            AppTextFormField(
              label: t.translate('address_line_2'),
              controller: _permAddress2,
              enabled: !_sameAsPresent,
            ),
            AppTextFormField(
              label: t.translate('city'),
              controller: _permCity,
              enabled: !_sameAsPresent,
            ),
            AppTextFormField(
              label: t.translate('pin_code'),
              controller: _permPin,
              enabled: !_sameAsPresent,
            ),
            AppTextFormField(
              label: t.translate('post_office'),
              controller: _permPostOffice,
              enabled: !_sameAsPresent,
            ),
            AppTextFormField(
              label: t.translate('police_station'),
              controller: _permPoliceStation,
              enabled: !_sameAsPresent,
            ),

            const SizedBox(height: 24),
            _sectionTitle(t.translate('other_details')),

            AppTextFormField(
              label: t.translate('incident_detail'),
              maxLines: 4,
            ),
            AppTextFormField(
              label: t.translate('action_request'),
              maxLines: 4,
            ),

            const SizedBox(height: 24),
            _sectionTitle(t.translate('attach_document')),

            AppFilePickerField(
              maxSizeMB: 5,
              allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
            ),

            const SizedBox(height: 40),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                    ),
                    child: Text(
                      t.translate('submit'),
                      style: AppTextStyles.button,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: Text(t.translate('clear')),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        text,
        style: AppTextStyles.h3.copyWith(
          color: AppColors.primary,
        ),
      ),
    );
  }
}
