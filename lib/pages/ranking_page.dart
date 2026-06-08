import 'package:flutter/material.dart';

import '../data/divas.dart';
import '../service/ranking_service.dart';

class RankingPage extends StatelessWidget {
  const RankingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final rankingService = RankingService();

    final ranking = rankingService.getRanking(divas);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ranking'),
      ),
      body: ListView.builder(
        itemCount: ranking.length,
        itemBuilder: (context, index) {

          final diva = ranking[index];

          return ListTile(
            leading: CircleAvatar(
              backgroundImage:
                  NetworkImage(diva.imageUrl),
            ),
            title: Text(diva.name),
            subtitle: Text(
              'Posição #${index + 1}',
            ),
            trailing: Text(
              '${diva.votes} votos',
            ),
          );
        },
      ),
    );
  }
}
