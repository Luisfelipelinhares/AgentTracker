import 'package:flutter/material.dart';

import '../data/divas.dart';
import '../service/music_service.dart';
import '../widgets/diva_card.dart';

class BattlePage extends StatefulWidget {
  const BattlePage({super.key});

  @override
  State<BattlePage> createState() => _BattlePageState();
}

class _BattlePageState extends State<BattlePage> {
  final musicService = MusicService();

  @override
  Widget build(BuildContext context) {
    final diva1 = divas[0];
    final diva2 = divas[1];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Batalha'),
      ),
      body: Row(
        children: [

          Expanded(
            child: FutureBuilder<String>(
              future: musicService.getTopSong(diva1.name),
              builder: (context, snapshot) {
                return DivaCard(
                  diva: diva1,
                  song: snapshot.data ?? 'Carregando...',
                  onVote: () {
                    setState(() {
                      diva1.votes++;
                    });
                  },
                );
              },
            ),
          ),

          Expanded(
            child: FutureBuilder<String>(
              future: musicService.getTopSong(diva2.name),
              builder: (context, snapshot) {
                return DivaCard(
                  diva: diva2,
                  song: snapshot.data ?? 'Carregando...',
                  onVote: () {
                    setState(() {
                      diva2.votes++;
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}