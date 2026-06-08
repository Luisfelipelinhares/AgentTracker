import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const DivasPopBattleApp());
}

class DivasPopBattleApp extends StatelessWidget {
  const DivasPopBattleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
