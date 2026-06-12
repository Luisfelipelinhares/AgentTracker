import 'package:flutter/material.dart';
import '../pages/agent_details_page.dart';

class AgentListWidget extends StatefulWidget {
  final List agents;

  const AgentListWidget({super.key, required this.agents});

  @override
  State<AgentListWidget> createState() => _AgentListWidgetState();
}

class _AgentListWidgetState extends State<AgentListWidget> {
  String search = '';

  @override
  Widget build(BuildContext context) {
    final filtered = widget.agents.where((a) {
      final name = a['displayName'].toString().toLowerCase();
      return name.contains(search.toLowerCase());
    }).toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: TextField(
            decoration: const InputDecoration(hintText: "Pesquisar..."),
            onChanged: (v) => setState(() => search = v),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: filtered.length,
            itemBuilder: (_, i) {
              final agent = filtered[i];

              return ListTile(
                title: Text(agent['displayName']),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AgentDetailsPage(agent: agent),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}