import 'package:flutter/material.dart';
import '../main.dart';
import '../models/table_status.dart';
import '../widgets/agent_list_widget.dart';

class AgentsPage extends StatefulWidget {
  const AgentsPage({super.key});

  @override
  State<AgentsPage> createState() => _AgentsPageState();
}

class _AgentsPageState extends State<AgentsPage> {
  @override
  void initState() {
    super.initState();
    dataService.carregarAgents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Agents")),
      body: ValueListenableBuilder(
        valueListenable: dataService.tableStateNotifier,
        builder: (_, value, __) {
          switch (value['status']) {
            case TableStatus.loading:
              return const Center(child: CircularProgressIndicator());

            case TableStatus.error:
              return const Center(child: Text("Erro ao carregar agents"));

            case TableStatus.ready:
              return AgentListWidget(agents: value['dataObjects']);

            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}