import 'dart:convert';
import 'package:http/http.dart' as http;

class MusicService {
  Future<String> getTopSong(String artist) async {
    final response = await http.get(
      Uri.parse(
        'https://itunes.apple.com/search?term=$artist&entity=song&limit=1',
      ),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data['resultCount'] > 0) {
        return data['results'][0]['trackName'];
      }
    }

    return 'Não encontrada';
  }
}