import 'package:flutter/material.dart';

class AgentDetailsPage extends StatelessWidget {
  final Map<String, dynamic> agent;

  const AgentDetailsPage({super.key, required this.agent});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(agent['displayName'])),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (agent['fullPortrait'] != null)
              Image.network(agent['fullPortrait'], height: 300),

            const SizedBox(height: 20),

            Text(
              agent['displayName'],
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Text(
              agent['description'] ?? "",
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }
}