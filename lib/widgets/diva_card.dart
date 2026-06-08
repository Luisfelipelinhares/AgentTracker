import 'package:flutter/material.dart';
import '../models/diva.dart';

class DivaCard extends StatelessWidget {
  final Diva diva;
  final String song;
  final VoidCallback onVote;

  const DivaCard({
    super.key,
    required this.diva,
    required this.song,
    required this.onVote,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 4,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              child: Image.network(
                diva.imageUrl,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),

          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    diva.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    '🎵 $song',
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 8),

                  Text(
                    '${diva.votes} votos',
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 12),

                  ElevatedButton.icon(
                    onPressed: onVote,
                    icon: const Icon(Icons.favorite),
                    label: const Text('Votar'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}