import '../models/diva.dart';

class RankingService {
  List<Diva> getRanking(List<Diva> divas) {
    final ranking = List<Diva>.from(divas);

    ranking.sort(
      (a, b) => b.votes.compareTo(a.votes),
    );

    return ranking;
  }
}