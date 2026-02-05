import 'package:flutter/material.dart';
import 'package:oscw/core/local_storage/preferences.dart';
import 'package:oscw/features/auth/data/auth_remote_datasource.dart';
import 'package:oscw/features/auth/data/auth_repository_impl.dart';
import 'package:oscw/shared_widgets/app_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../routes/app_routes.dart';
import '../../../shared_widgets/app_app_bar.dart';

class RegisterComplaintPage extends StatelessWidget {
  const RegisterComplaintPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
   

    return Scaffold(
      appBar:  AppAppBar(
          title: t.translate("appHeader"),
        showBack: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ================= TITLE =================
            Center(
              child: Text(
                t.translate('register_complaint_title'),
                textAlign: TextAlign.center,
                style: AppTextStyles.h1.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ),

            const SizedBox(height: 14),

            Center(
              child: Text(
                t.translate('instruction'),
                style: AppTextStyles.h3.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ================= INTRO =================
            Text(
              t.translate('instruction_intro'),
              style: AppTextStyles.body.copyWith(height: 1.5),
            ),

            const SizedBox(height: 20),

            // ================= STEPS =================
            StepBlock(
              step: '1.',
              title: t.translate('step_1_title'),
              description: t.translate('step_1_desc'),
            ),

            const SizedBox(height: 16),

            StepBlock(
              step: '2.',
              title: t.translate('step_2_title'),
              description: t.translate('step_2_desc'),
            ),

            const SizedBox(height: 16),

            StepBlock(
              step: '3.',
              title: t.translate('step_3_title'),
              description: t.translate('step_3_desc'),
            ),

            const SizedBox(height: 40),

            // ================= TRACK SECTION =================
            Center(
              child: Text(
                t.translate('track_title'),
                style: AppTextStyles.h2.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ),

            const SizedBox(height: 12),

            Text(
              t.translate('track_desc'),
              style: AppTextStyles.body.copyWith(height: 1.5),
            ),

            const SizedBox(height: 14),

            Text(t.translate('track_step_1'), style: AppTextStyles.bodySmall),
            const SizedBox(height: 6),
            Text(t.translate('track_step_2'), style: AppTextStyles.bodySmall),
            const SizedBox(height: 6),
            Text(t.translate('track_step_3'), style: AppTextStyles.bodySmall),

            const SizedBox(height: 40),

            // ================= BUTTON =================
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                ),
                onPressed: () {
                  // Navigator.pushNamed(
                  //   context,
                  //   AppRoutes.giveComplaint,
                  // );
                    _showConfirmMobileDialog(context, editableByDefault: true);

                },
                child: Text(
                  t.translate('complaint_form_button'),
                  textAlign: TextAlign.center,
                  style: AppTextStyles.button,
                ),
              ),
            ),

            const SizedBox(height: 30),

            // ================= FOOTER =================
            Center(
              child: Text(
                t.translate('copyright'),
                style: AppTextStyles.label.copyWith(
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

Future<void> _showConfirmMobileDialog(
  BuildContext context, {
  bool editableByDefault = false,
}) async {
  final t = AppLocalizations.of(context);
  final prefs = Preferences(await SharedPreferences.getInstance());
  final savedMobile = prefs.getMobile();

  bool isEditable = editableByDefault || savedMobile == null;
  final mobileCtrl = TextEditingController(text: savedMobile ?? "");

  // Keep a reference to the original page context
  final pageContext = context;

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return StatefulBuilder(
        builder: (dialogContext, setState) {
          String getButtonText() {
            final newMobile = mobileCtrl.text.trim();
            if (isEditable && newMobile != savedMobile) {
              return t.translate("send_otp");
            }
            return t.translate("proceed");
          }

          return AlertDialog(
            title: Text(t.translate("confirm_mobile_number")),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: mobileCtrl,
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  readOnly: !isEditable,
                  decoration: InputDecoration(
                    hintText: t.translate("enter_mobile_number"),
                    suffixIcon: !isEditable
                        ? const Icon(Icons.lock_outline)
                        : const Icon(Icons.edit),
                  ),
                  onChanged: (_) => setState(() {}),
                ),
                const SizedBox(height: 8),
                Text(t.translate("mobile_number_used_for_updates")),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  setState(() => isEditable = true);
                },
                child: Text(t.translate("change_number")),
              ),
              ElevatedButton(
                onPressed: () async {
                  final newMobile = mobileCtrl.text.trim();

                  if (newMobile.length != 10) {
                    AppToast.show(
                      pageContext,
                      message: t.translate("invalid_mobile_number"),
                      type: ToastType.error,
                    );
                    return;
                  }

                  Navigator.pop(dialogContext); // close dialog

                  if (isEditable && newMobile != savedMobile) {
                    final authRepo =
                        AuthRepositoryImpl(AuthRemoteDataSource());
                    final response = await authRepo.generateOtp(newMobile);
                    await prefs.setMobile(newMobile);

                    Navigator.pushNamed(
                      pageContext, // use the page context, NOT dialog context
                      AppRoutes.verifyOtp,
                      arguments: {
                        "response": response,
                        "redirectRoute": AppRoutes.giveComplaint,
                      },
                    );
                  } else {
                    Navigator.pushNamed(
                      pageContext, // use the page context
                      AppRoutes.giveComplaint,
                    );
                  }
                },
                child: Text(getButtonText()),
              ),
            ],
          );
        },
      );
    },
  );
}






}

// =====================================================
// STEP BLOCK WIDGET (Reusable)
// =====================================================
class StepBlock extends StatelessWidget {
  final String step;
  final String title;
  final String description;

  const StepBlock({
    super.key,
    required this.step,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return RichText(
      text: TextSpan(
        style: AppTextStyles.body.copyWith(
          height: 1.5,
          color: isDark ? Colors.white : Colors.black, 
        ),
        children: [
          TextSpan(
            text: '$step ',
            style: TextStyle(
              color: AppColors.primary, 
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: '$title\n',
            style: TextStyle(
              color: AppColors.primary, 
              fontWeight: FontWeight.w600,
            ),
          ),
          TextSpan(
            text: description,
            style: TextStyle(
              color: isDark ? Colors.white70 : Colors.grey[800], 
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}


