import 'package:flutter/material.dart';
import '../main.dart';
import '../models/table_status.dart';
import '../widgets/weapon_list_widget.dart';

class WeaponsPage extends StatefulWidget {
  const WeaponsPage({super.key});

  @override
  State<WeaponsPage> createState() => _WeaponsPageState();
}

class _WeaponsPageState extends State<WeaponsPage> {
  @override
  void initState() {
    super.initState();
    weaponService.carregarWeapons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Weapons")),
      body: ValueListenableBuilder(
        valueListenable: weaponService.tableStateNotifier,
        builder: (_, value, __) {
          switch (value['status']) {
            case TableStatus.loading:
              return const Center(child: CircularProgressIndicator());

            case TableStatus.error:
              return const Center(child: Text("Erro ao carregar weapons"));

            case TableStatus.ready:
              return WeaponListWidget(weapons: value['dataObjects']);

            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}