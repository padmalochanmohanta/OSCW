import 'package:flutter/material.dart';

class SafetyTipsPage extends StatelessWidget {
  const SafetyTipsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text("Safety Tips")),
      body: Center(child: Text("Safety Guidelines")),
    );
  }
}
