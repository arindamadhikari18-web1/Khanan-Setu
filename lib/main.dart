import 'package:flutter/material.dart';

import 'screens/app_data.dart';
import 'screens/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load saved profiles from SharedPreferences
  await AppData.initialize();

  runApp(const KhananSetuApp());
}

class KhananSetuApp extends StatelessWidget {
  const KhananSetuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Khanan Setu',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0B5D3B),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}