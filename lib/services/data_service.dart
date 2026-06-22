import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/table_status.dart';

class DataService {
  final ValueNotifier<Map<String, dynamic>> tableStateNotifier =
      ValueNotifier({
    'status': TableStatus.idle,
    'dataObjects': <dynamic>[],
  });

  void carregarAgents() {
    tableStateNotifier.value = {
      'status': TableStatus.loading,
      'dataObjects': [],
    };

    final uri = Uri.parse(
      "https://valorant-api.com/v1/agents?isPlayableCharacter=true",
    );

    http.get(uri).then((response) {
      final data = jsonDecode(response.body);

      tableStateNotifier.value = {
        'status': TableStatus.ready,
        'dataObjects': data['data'],
      };
    }).catchError((_) {
      tableStateNotifier.value = {
        'status': TableStatus.error,
        'dataObjects': [],
      };
    });
  }
}