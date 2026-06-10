import 'dart:convert';

import 'services/agentservice.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

final agentService = AgentService();

enum TableStatus { idle, loading, ready, error }

enum ItemType { agent, none }

class DataService {
  final ValueNotifier<Map<String, dynamic>> tableStateNotifier =
      ValueNotifier({
    'status': TableStatus.idle,
    'dataObjects': <dynamic>[],
    'itemType': ItemType.none,
  });

  void carregar(int index) {
    carregarAgents();
  }

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
        'propertyNames': [
          "displayName",
          "description",
        ],
        'columnNames': [
          "Nome",
          "Descrição",
        ],
      };
    }).catchError((_) {
      tableStateNotifier.value = {
        'status': TableStatus.error,
      };
    });
  }
}

final dataService = DataService();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      home: Scaffold(
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
                  return const Center(
                    child: Text(
                      "Clique para carregar os agentes",
                      style: TextStyle(color: Colors.white70, fontSize: 18),
                    ),
                  );

                case TableStatus.loading:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );

                case TableStatus.ready:
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SingleChildScrollView(
                      child: DataTableWidget(
                        jsonObjects: value['dataObjects'],
                        propertyNames:
                            List<String>.from(value['propertyNames']),
                        columnNames:
                            List<String>.from(value['columnNames']),
                      ),
                    ),
                  );

                case TableStatus.error:
                  return const Center(
                    child: Text(
                      "Erro ao carregar agentes",
                      style: TextStyle(color: Colors.red),
                    ),
                  );
              }
              return const SizedBox();
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => dataService.carregar(0),
          backgroundColor: const Color(0xFFFF4655),
          child: const Icon(Icons.download),
        ),
      ),
    );
  }
}

class DataTableWidget extends StatelessWidget {
  final List jsonObjects;
  final List<String> columnNames;
  final List<String> propertyNames;

  const DataTableWidget({
    super.key,
    this.jsonObjects = const [],
    this.columnNames = const [],
    this.propertyNames = const [],
  });

  @override
  Widget build(BuildContext context) {
    return DataTable(
      headingRowColor: WidgetStateProperty.all(
        const Color(0xFF1A2634),
      ),
      columns: columnNames
          .map(
            (name) => DataColumn(
              label: Text(
                name,
                style: const TextStyle(
                  color: Color(0xFFFF4655),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
          .toList(),
      rows: jsonObjects.map<DataRow>((obj) {
        return DataRow(
          cells: propertyNames.map<DataCell>((prop) {
            return DataCell(
              Text(
                "${obj[prop] ?? ''}",
                style: const TextStyle(color: Colors.white),
              ),
            );
          }).toList(),
        );
      }).toList(),
    );
  }
}