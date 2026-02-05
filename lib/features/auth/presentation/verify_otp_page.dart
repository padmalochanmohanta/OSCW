import 'package:flutter/material.dart';

import '../../../shared_widgets/app_app_bar.dart';
import '../../../shared_widgets/app_toast.dart';
import '../../../routes/app_routes.dart';
import '../../../core/localization/app_localizations.dart';
import '../data/models/generate_otp_response.dart';

// class VerifyOtpPage extends StatefulWidget {
//   const VerifyOtpPage({super.key});

//   @override
//   State<VerifyOtpPage> createState() => _VerifyOtpPageState();
// }

// class _VerifyOtpPageState extends State<VerifyOtpPage> {
//   final TextEditingController _otpCtrl = TextEditingController();
//   bool _loading = false;

//   late GenerateOtpResponse response;

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();

//     response = ModalRoute.of(context)!.settings.arguments
//     as GenerateOtpResponse;

//     // ❌ Do NOT auto-fill OTP in production
//     // _otpCtrl.text = response.otp;
//   }

//   void _verifyOtp(BuildContext context) {
//     final t = AppLocalizations.of(context);
//     final enteredOtp = _otpCtrl.text.trim();

//     // 1️⃣ Empty OTP
//     if (enteredOtp.isEmpty) {
//       AppToast.show(
//         context,
//         message: t.translate("enter_otp"),
//         type: ToastType.warning,
//       );
//       return;
//     }

//     // 2️⃣ Length check
//     if (enteredOtp.length != 6) {
//       AppToast.show(
//         context,
//         message: t.translate("invalid_otp"),
//         type: ToastType.error,
//       );
//       return;
//     }

//     // 3️⃣ Numeric only
//     if (!RegExp(r'^\d{6}$').hasMatch(enteredOtp)) {
//       AppToast.show(
//         context,
//         message: t.translate("invalid_otp"),
//         type: ToastType.error,
//       );
//       return;
//     }

//     setState(() => _loading = true);

//     // 4️⃣ OTP match
//     if (enteredOtp == response.otp) {
//       Navigator.pushNamedAndRemoveUntil(
//         context,
//         AppRoutes.mainNav,
//             (_) => false,
//       );
//     } else {
//       AppToast.show(
//         context,
//         message: t.translate("otp_failed"),
//         type: ToastType.error,
//       );
//     }

//     setState(() => _loading = false);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final t = AppLocalizations.of(context);

//     return Scaffold(
//       appBar: AppAppBar(
//         title: t.translate("verify_otp"),
//         showBack: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "${t.translate("otp_sent_to")} ${response.mobileNo} - OTP-${response.otp}",
//               style: const TextStyle(fontSize: 16),
//             ),
//             const SizedBox(height: 20),

//             TextField(
//               controller: _otpCtrl,
//               keyboardType: TextInputType.number,
//               maxLength: 6,
//               decoration: InputDecoration(
//                 labelText: t.translate("enter_otp"),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 prefixIcon: const Icon(Icons.lock),
//               ),
//             ),

//             const SizedBox(height: 20),

//             SizedBox(
//               width: double.infinity,
//               height: 50,
//               child: ElevatedButton(
//                 onPressed: _loading ? null : () => _verifyOtp(context),
//                 child: _loading
//                     ? const CircularProgressIndicator(color: Colors.white)
//                     : Text(t.translate("verify_continue")),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


class VerifyOtpPage extends StatefulWidget {
  const VerifyOtpPage({super.key});

  @override
  State<VerifyOtpPage> createState() => _VerifyOtpPageState();
}

class _VerifyOtpPageState extends State<VerifyOtpPage> {
  final TextEditingController _otpCtrl = TextEditingController();
  bool _loading = false;

  late GenerateOtpResponse response;
  String? redirectRoute;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args =
        ModalRoute.of(context)!.settings.arguments as Map;

    response = args["response"] as GenerateOtpResponse;
    redirectRoute = args["redirectRoute"] as String?;
  }

  void _verifyOtp(BuildContext context) async {
    final t = AppLocalizations.of(context);
    final enteredOtp = _otpCtrl.text.trim();

    if (enteredOtp.length != 6) {
      AppToast.show(
        context,
        message: t.translate("invalid_otp"),
        type: ToastType.error,
      );
      return;
    }

    setState(() => _loading = true);

    if (enteredOtp == response.otp) {
      // Navigator.pushNamedAndRemoveUntil(
      //   context,
      //   redirectRoute ?? AppRoutes.mainNav,
      //   (_) => false,
      // );
      Navigator.pushReplacementNamed(
        context,
         redirectRoute ?? AppRoutes.mainNav,
    );

    } else {
      AppToast.show(
        context,
        message: t.translate("otp_failed"),
        type: ToastType.error,
      );
    }

    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppAppBar(
        title: t.translate("verify_otp"),
        showBack: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
               "${t.translate("otp_sent_to")} ${response.mobileNo} - OTP-${response.otp}",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),

            TextField(
              controller: _otpCtrl,
              keyboardType: TextInputType.number,
              maxLength: 6,
              decoration: InputDecoration(
                labelText: t.translate("enter_otp"),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.lock),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _loading ? null : () => _verifyOtp(context),
                child: _loading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : Text(t.translate("verify_continue")),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
