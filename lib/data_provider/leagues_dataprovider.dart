import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/leagues.dart';
import '../utils/utils.dart';

class LeaguesDataProvider {
  static const String _leaguesBaseUrl = "http://10.0.2.2:8000/leagues/";
  static const String _playersBaseUrl = "http://10.0.2.2:8000/players/";

  static const token =
      "eyJhbGciOiAic2hhMjU2IiwgInR5cGUiOiAiand0In0=.eyJ1c2VyLWlkIjogMSwgImlhdCI6IDE2ODU3MzAzMjksICJleHAiOiA5MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAxNjg1NzMwMzI5fQ==.e90891de011e4adf5de1b2dd25c4fc160e95429967f41f21e3f87963401de978";
  static const Map<String, String> fetchHeader = {"token": token};

  Future<GetPublicLeaguesResponse> getPublicLeagues() async {
    final response =
        await http.get(Uri.parse(_leaguesBaseUrl), headers: fetchHeader);

    if (response.statusCode == 200) {
      return GetPublicLeaguesResponse.fromPublicLeaguesJson(
          jsonDecode(response.body));
    } else {
      throw Exception("Failed to load public Leagues");
    }
  }

  Future<GetPlayersResponse> filterPlayers(String position) async {
    final response =
        await http.get(Uri.parse(_playersBaseUrl), headers: fetchHeader);

    if (response.statusCode == 200) {
      GetPlayersResponse getPlayersResponse =
          GetPlayersResponse.fromFilterPlayersJson(jsonDecode(response.body));
      GetPlayersResponse filteredResponse = GetPlayersResponse(
          success: getPlayersResponse.success,
          players:
              filterPlayersByPosition(getPlayersResponse.players, position));
      return filteredResponse;
    } else {
      throw Exception("Faied to load players");
    }
  }

  Future<JoinLeagueResponse> joinLeague(
      int leagueId, String captain, String entryCode, List players) async {
    Map<String, int> captainToIndex = {
      "Goal Keeper": 0,
      "Defender": 2,
      "Midfielder": 3,
      "Attacker": 4
    };
    int captainIndex = captainToIndex[captain]!;
    List<Map<String, dynamic>> playerInfoToSend = [{}, {}, {}, {}, {}];
    for (int i = 0; i < players.length; i++) {
      if (i == 1) {
        playerInfoToSend[1] = {
          "player_id": players[1],
          "captain": 0,
          "reserve": 1,
        };
      } else {
        playerInfoToSend[i] = {
          "player_id": players[i],
          "captain": (captainIndex == i) ? 1 : 0,
          "reserve": 0
        };
      }
    }
    print("JSON BEING SENT: ${jsonEncode({
          "entry_code": entryCode,
          "players": playerInfoToSend
        })}");

    final Map<String, String> postHeader = {
      "token": token,
      "Content-Type": "application/json"
    };
    try {
      final http.Response response = await http.post(
          Uri.parse("$_leaguesBaseUrl$leagueId/teams"),
          headers: postHeader,
          body: jsonEncode(
              {"entry_code": entryCode, "players": playerInfoToSend}));

      if (response.statusCode == 200) {
        return JoinLeagueResponse.fromJoinLeaguesJson(
            jsonDecode(response.body));
      } else if (response.statusCode == 400) {
        return JoinLeagueResponse.fromJoinLeaguesJson(
            jsonDecode(response.body));
      } else {
        throw (Exception("Failed to join league"));
      }
    } catch (error, stackTrace) {
      throw Exception(error);
    }
  }
}
