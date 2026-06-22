import 'package:flutter/material.dart';

class WeaponDetailsPage extends StatelessWidget {
  final Map<String, dynamic> weapon;

  const WeaponDetailsPage({super.key, required this.weapon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(weapon['displayName'])),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (weapon['displayIcon'] != null)
              Image.network(weapon['displayIcon'], height: 200),

            const SizedBox(height: 20),

            Text(
              weapon['displayName'],
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}