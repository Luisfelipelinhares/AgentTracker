import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'services/data_service.dart';
import 'services/weaponservice.dart';

final dataService = DataService();
final weaponService = WeaponService();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "AgentTracker",
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0F1923),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFFF4655),
          secondary: Color(0xFF00D4FF),
          surface: Color(0xFF1A2634),
        ),
      ),
      home: const HomePage(),
    );
  }
}