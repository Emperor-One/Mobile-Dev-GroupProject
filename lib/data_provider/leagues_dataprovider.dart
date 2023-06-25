import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/leagues.dart';
import '../utils/utils.dart';

class LeaguesDataProvider {
  static const String _leaguesBaseUrl = "http://10.0.2.2:8000/leagues/";
  static const String _playersBaseUrl = "http://10.0.2.2:8000/players/";

  static const token =
      "eyJhbGciOiAic2hhMjU2IiwgInR5cGUiOiAiand0In0=.eyJ1c2VyLWlkIjogMiwgImlhdCI6IDE2ODc2MDI1OTksICJleHAiOiA5MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAxNjg3NjAyNTk5fQ==.fe85c21e22c89c1927e8861b74624569962f718c7b8d89764f203ad85749ffc2";
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

  Future<JoinLeagueResponse> joinLeague(int leagueId, String captain,
      String entryCode, List players, bool isCreated, String leagueName) async {
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

    if (isCreated) {
      final http.Response response =
          await http.post(Uri.parse("$_leaguesBaseUrl"),
              headers: postHeader,
              body: jsonEncode({
                "name": leagueName,
                "tournament_id": 17,
                "entry_code": entryCode,
                "players": playerInfoToSend
              }));
    }
    try {
      if (isCreated) {
        throw ("Created leagued! No Need to call join!");
      }
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

class UserDataProvider {
  final String _baseUrl = 'http://10.0.2.2:8000/users';

  //login
  Future<User> login(String email, String password) async {
    try {
      final http.Response response = await http.post(
          Uri.parse('$_baseUrl/login'),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(
              <String, String>{"email": email, "password": password}));

      return User.fromJson(jsonDecode(response.body));
    } catch (error) {
      throw (error);
    }
  }

  //createAccount
  Future<String> createAccount(
      String email, String password, String UserName) async {
    final http.Response response = await http.post(Uri.parse('$_baseUrl/'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(
            {"userName": UserName, "password": password, "email": email}));

    if (response.statusCode == 201) {
      return 'Account created successfully!';
    }
    {
      throw Exception(jsonDecode(response.body)['detail']);
    }
  }
}
