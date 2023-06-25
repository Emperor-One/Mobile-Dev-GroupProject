import '../data_provider/leagues_dataprovider.dart';
import '../models/leagues.dart';

class LeaguesRepository {
  final LeaguesDataProvider dataProvider;
  LeaguesRepository(this.dataProvider);

  Future<JoinLeagueResponse> joinLeague(
      int leagueId, String captain, String entryCode, List players, bool isCreated, String leagueName) {
    return dataProvider.joinLeague(leagueId, captain, entryCode, players, isCreated, leagueName);
  }

  Future<GetPlayersResponse> filterPlayers(String position) async {
    return dataProvider.filterPlayers(position);
  }

  Future<GetPublicLeaguesResponse> getPublicLeagues() async {
    return dataProvider.getPublicLeagues();
  }
}
