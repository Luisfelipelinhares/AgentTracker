import 'package:flutter/material.dart';

import 'battle_page.dart';
import 'ranking_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Divas Pop Battle'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const Icon(
              Icons.music_note,
              size: 100,
              color: Colors.pink,
            ),

            const SizedBox(height: 20),

            const Text(
              'Divas Pop Battle',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 40),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const BattlePage(),
                  ),
                );
              },
              child: const Text('Iniciar Batalha'),
            ),

            const SizedBox(height: 15),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const RankingPage(),
                  ),
                );
              },
              child: const Text('Ver Ranking'),
            ),
          ],
        ),
      ),
    );
  }
}