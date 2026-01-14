// lib/main.dart
import 'package:flutter/material.dart';
import 'app.dart';
import 'core/di/injector.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize GetIt DI
  await initializeDependencies();

  runApp(const OSCWApp());
}
