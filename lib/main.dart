
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

enum TableStatus { idle, loading, ready, error }

enum ItemType { agent, none }

class DataService {
  final ValueNotifier<Map<String, dynamic>> tableStateNotifier =
      ValueNotifier({
    'status': TableStatus.idle,
    'dataObjects': <dynamic>[],
    'itemType': ItemType.none,
  });

  void carregarAgents() {
    if (tableStateNotifier.value['status'] == TableStatus.loading) return;

    tableStateNotifier.value = {
      'status': TableStatus.loading,
      'dataObjects': [],
      'itemType': ItemType.agent,
    };

    final uri = Uri.parse(
      "https://valorant-api.com/v1/agents?isPlayableCharacter=true",
    );

    http.get(uri).then((response) {
      final data = jsonDecode(response.body);
      final agents = data['data'];

      tableStateNotifier.value = {
        'status': TableStatus.ready,
        'dataObjects': agents,
        'itemType': ItemType.agent,
      };
    }).catchError((_) {
      tableStateNotifier.value = {
        'status': TableStatus.error,
        'dataObjects': [],
        'itemType': ItemType.none,
      };
    });
  }
}

final dataService = DataService();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    dataService.carregarAgents();
  }

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

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AgentTracker"),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF0F1923),
              Color(0xFF1A2634),
              Color(0xFF10263D),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ValueListenableBuilder(
          valueListenable: dataService.tableStateNotifier,
          builder: (_, value, __) {
            switch (value['status']) {
              case TableStatus.idle:
              case TableStatus.loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );

              case TableStatus.ready:
                return AgentListWidget(
                  agents: value['dataObjects'],
                );

              case TableStatus.error:
                return const Center(
                  child: Text(
                    "Erro ao carregar agentes",
                    style: TextStyle(color: Colors.red),
                  ),
                );

              default:
                return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}

class AgentListWidget extends StatefulWidget {
  final List agents;

  const AgentListWidget({
    super.key,
    required this.agents,
  });

  @override
  State<AgentListWidget> createState() => _AgentListWidgetState();
}

class _AgentListWidgetState extends State<AgentListWidget> {
  String search = '';

  @override
  Widget build(BuildContext context) {
    final filteredAgents = widget.agents.where((agent) {
      final name = agent['displayName']
          .toString()
          .toLowerCase();

      return name.contains(search.toLowerCase());
    }).toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: TextField(
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: "Pesquisar agente...",
              hintStyle: const TextStyle(
                color: Colors.white54,
              ),
              prefixIcon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
              filled: true,
              fillColor: const Color(0xFF1A2634),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onChanged: (value) {
              setState(() {
                search = value;
              });
            },
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: filteredAgents.length,
            itemBuilder: (context, index) {
              final agent = filteredAgents[index];

              return Card(
                color: const Color(0xFF1A2634),
                margin: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            AgentDetailsPage(agent: agent),
                      ),
                    );
                  },
                  leading: agent['displayIcon'] != null
                      ? CircleAvatar(
                          backgroundImage: NetworkImage(
                            agent['displayIcon'],
                          ),
                        )
                      : null,
                  title: Text(
                    agent['displayName'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    agent['description'],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white54,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class AgentDetailsPage extends StatelessWidget {
  final Map<String, dynamic> agent;

  const AgentDetailsPage({
    super.key,
    required this.agent,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(agent['displayName']),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (agent['fullPortrait'] != null)
              Image.network(
                agent['fullPortrait'],
                height: 350,
              )
            else if (agent['displayIcon'] != null)
              Image.network(
                agent['displayIcon'],
                height: 200,
              ),

            const SizedBox(height: 20),

            Text(
              agent['displayName'],
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              agent['description'],
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

