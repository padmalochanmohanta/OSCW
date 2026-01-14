import 'package:flutter/material.dart';

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
      appBar: const AppAppBar(
        title: 'OSCW – Government of Odisha',
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
                  Navigator.pushNamed(
                    context,
                    AppRoutes.giveComplaint,
                  );
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
    return RichText(
      text: TextSpan(
        style: AppTextStyles.body.copyWith(
          height: 1.5,
          color: AppColors.textDark,
        ),
        children: [
          TextSpan(
            text: '$step ',
            style: const TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: '$title\n',
            style: const TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
          TextSpan(text: description),
        ],
      ),
    );
  }
}
