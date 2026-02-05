import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oscw/core/local_storage/preferences.dart';
import '../../../core/internet/internet_bloc.dart';
import '../../../core/internet/internet_state.dart';
import '../../../routes/app_routes.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../shared_widgets/app_toast.dart';
import '../../../shared_widgets/no_internet_banner.dart';
import '../data/auth_remote_datasource.dart';
import '../data/auth_repository_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _mobileCtrl = TextEditingController();
  bool _loading = false;

  late final AuthRepositoryImpl _authRepo;

  @override
  void initState() {
    super.initState();
    _authRepo = AuthRepositoryImpl(AuthRemoteDataSource());
  }

  @override
  void dispose() {
  _mobileCtrl.dispose();
  super.dispose();
}

void _onSkip(BuildContext context) {
  Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.mainNav,
            (_) => false,
      );
}



  Future<void> _onSendOtp(BuildContext context) async {
    final mobile = _mobileCtrl.text.trim();
    final t = AppLocalizations.of(context);

    if (mobile.isEmpty || mobile.length != 10) {
      AppToast.show(
        context,
        message: t.translate("invalid_mobile_number"),
        type: ToastType.error,
      );
      return;
    }

    setState(() => _loading = true);

    try {
     await _saveMobile(mobile);
      final response = await _authRepo.generateOtp(mobile);

      AppToast.show(
        context,
        message: response.message,
        type: ToastType.success,
      );

      // Navigator.pushNamed(
      //   context,
      //   AppRoutes.verifyOtp,
      //   arguments: response, // ✅ FULL RESPONSE
      // );
      Navigator.pushNamed(
            context,
            AppRoutes.verifyOtp,
            arguments: {
            "response": response,
            "redirectRoute": AppRoutes.mainNav, 
          },
       );

    } catch (e) {
      AppToast.show(
        context,
        message: t.translate("otp_failed"),
        type: ToastType.error,
      );
    } finally {
      setState(() => _loading = false);
    }
  }


  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// INTERNET STATUS
              BlocBuilder<InternetBloc, InternetState>(
                builder: (context, state) {
                  return NoInternetBanner(
                    visible: !state.isConnected,
                    message: t.translate("no_internet"),
                  );
                },
              ),
              const SizedBox(height: 24),

              Text(
                t.translate("login_title"),
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                t.translate("login_subtitle"),
                style: theme.textTheme.bodyMedium,
              ),

              const SizedBox(height: 36),

              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: isDark
                      ? null
                      : [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.translate("mobile_number"),
                      style: theme.textTheme.bodySmall,
                    ),
                    const SizedBox(height: 8),

                    TextField(
                      controller: _mobileCtrl,
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: InputDecoration(
                        hintText: t.translate("mobile_hint"),
                        counterText: "",
                        prefixIcon:
                        const Icon(Icons.phone_android_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // SizedBox(
                    //   width: double.infinity,
                    //   height: 52,
                    //   child: ElevatedButton(
                    //     onPressed:
                    //     _loading ? null : () => _onSendOtp(context),
                    //     child: _loading
                    //         ? const CircularProgressIndicator(
                    //       color: Colors.white,
                    //     )
                    //         : Text(
                    //       t.translate("send_otp"),
                    //       style: theme.textTheme.titleMedium
                    //           ?.copyWith(fontWeight: FontWeight.w600),
                    //     ),
                    //   ),
                    // ),

                    Row(
                      children: [
                          /// SKIP BUTTON
                         Expanded(
                            child: SizedBox(
                             height: 52,
                             child: OutlinedButton(
                             onPressed: () => _onSkip(context),
                             style: OutlinedButton.styleFrom(
                             shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            t.translate("skip"),
            style: theme.textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
      ),
    ),

    const SizedBox(width: 12),

    /// SEND OTP / LOGIN BUTTON
    Expanded(
      child: SizedBox(
        height: 52,
        child: ElevatedButton(
          onPressed: _loading ? null : () => _onSendOtp(context),
          child: _loading
              ? const SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : Text(
                  t.translate("send_otp"), // or "login"
                  style: theme.textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
        ),
      ),
    ),
  ],
),

                  ],
                ),
              ),

              const SizedBox(height: 40),

              Center(
                child: Text(
                  t.translate("app_footer"),
                  style: theme.textTheme.bodySmall,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
Future<void> _saveMobile(String mobile) async {
  final prefs = Preferences(await SharedPreferences.getInstance());
  await prefs.setMobile(mobile); 
}

}
