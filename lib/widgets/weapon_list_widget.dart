import 'package:flutter/material.dart';
import '../pages/weapon_details_page.dart';

class WeaponListWidget extends StatelessWidget {
  final List weapons;

  const WeaponListWidget({super.key, required this.weapons});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: weapons.length,
      itemBuilder: (_, i) {
        final weapon = weapons[i];

        return ListTile(
          title: Text(weapon['displayName']),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => WeaponDetailsPage(weapon: weapon),
              ),
            );
          },
        );
      },
    );
  }
}