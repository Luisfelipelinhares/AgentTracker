import 'dart:convert';
import 'package:http/http.dart' as http;

class AgentService {
  Future<List<dynamic>> fetchAgents() async {
    final url = Uri.parse(
      "https://valorant-api.com/v1/agents?isPlayableCharacter=true",
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['data'];
    } else {
      throw Exception("Erro ao carregar agentes");
    }
  }
}