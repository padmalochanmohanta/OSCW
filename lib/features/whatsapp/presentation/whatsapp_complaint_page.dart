import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/theme/app_text_styles.dart';

class WhatsAppComplaintPage extends StatefulWidget {
  const WhatsAppComplaintPage({super.key});

  @override
  State<WhatsAppComplaintPage> createState() => _WhatsAppComplaintPageState();
}

class _WhatsAppComplaintPageState extends State<WhatsAppComplaintPage> {
  /// 🔹 WhatsApp open logic (official & safe)
  Future<void> _openWhatsApp() async {
    const String phoneNumber = '918763543013'; // country code + number
    const String message =
        'Hello, I want to register a complaint through WhatsApp.';

    final String encodedMessage = Uri.encodeComponent(message);
    final Uri whatsappUri =
    Uri.parse('https://wa.me/$phoneNumber?text=$encodedMessage');

    if (!await launchUrl(
      whatsappUri,
      mode: LaunchMode.externalApplication,
    )) {
      debugPrint('WhatsApp not installed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WhatsApp Complaint'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.chat,
              size: 80,
              color: Colors.green,
            ),
            const SizedBox(height: 20),

            const Text(
              'Register Complaint via WhatsApp',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 12),

            const Text(
              'Tap the button below to open WhatsApp and send your complaint message.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.chat,
                  color: Colors.white,
                ),
                label: const Text(
                  'Open WhatsApp',
                  style: AppTextStyles.button,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),

                onPressed: _openWhatsApp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
