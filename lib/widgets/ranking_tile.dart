import 'package:flutter/material.dart';
import '../models/diva.dart';

class RankingTile extends StatelessWidget {
  final Diva diva;
  final int position;

  const RankingTile({
    super.key,
    required this.diva,
    required this.position,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(
            diva.imageUrl,
          ),
        ),
        title: Text(
          diva.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          'Posição #$position',
        ),
        trailing: Text(
          '${diva.votes} votos',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
