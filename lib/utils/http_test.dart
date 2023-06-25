import 'dart:convert';
import 'package:http/http.dart' as http;

String leaguesBaseUrl = "http://10.0.2.2:8000/leagues/";
String playersBaseUrl = "http://10.0.2.2:8000/players/";

class GetPublicLeaguesResponse {
  bool success;
  List<dynamic> publicLeagues;

  GetPublicLeaguesResponse(
      {required this.success, required this.publicLeagues});

  factory GetPublicLeaguesResponse.fromPublicLeaguesJson(
      Map<String, dynamic> json) {
    return GetPublicLeaguesResponse(
      success: json['success'],
      publicLeagues: json['leagues'],
    );
  }
}

Future<GetPublicLeaguesResponse> getPublicLeagues() async {
  final Map<String, String> headers = {
    "token":
        "eyJhbGciOiAic2hhMjU2IiwgInR5cGUiOiAiand0In0=.eyJ1c2VyLWlkIjogMiwgImlhdCI6IDE2ODc2MDI1OTksICJleHAiOiA5MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAxNjg3NjAyNTk5fQ==.fe85c21e22c89c1927e8861b74624569962f718c7b8d89764f203ad85749ffc2"
  };
  final response = await http.get(Uri.parse(leaguesBaseUrl), headers: headers);

  if (response.statusCode == 200) {
    return GetPublicLeaguesResponse.fromPublicLeaguesJson(
        jsonDecode(response.body));
  } else {
    throw Exception("Failed to load public Leagues");
  }
}

class GetPlayersResponse {
  bool success;
  List<dynamic> players;
  String? detail;

  GetPlayersResponse(
      {required this.success, required this.players, this.detail});

  factory GetPlayersResponse.fromFilterPlayersJson(Map<String, dynamic> json) {
    return GetPlayersResponse(
        success: json["success"], players: json["players"]);
  }
}

Future<GetPlayersResponse> filterPlayers(String position) async {
  final Map<String, String> headers = {
    "token":
        "eyJhbGciOiAic2hhMjU2IiwgInR5cGUiOiAiand0In0=.eyJ1c2VyLWlkIjogMiwgImlhdCI6IDE2ODc2MDI1OTksICJleHAiOiA5MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAxNjg3NjAyNTk5fQ==.fe85c21e22c89c1927e8861b74624569962f718c7b8d89764f203ad85749ffc2"
  };
  final response = await http.get(Uri.parse(playersBaseUrl), headers: headers);

  if (response.statusCode == 200) {
    GetPlayersResponse getPlayersResponse =
        GetPlayersResponse.fromFilterPlayersJson(jsonDecode(response.body));
    GetPlayersResponse filteredResponse = GetPlayersResponse(
        success: getPlayersResponse.success,
        players: filterPlayersByPosition(getPlayersResponse.players, position));
    return filteredResponse;
  } else {
    throw Exception("Faied to load players");
  }
}

class JoinLeagueResponse {
  bool success;
  String uri;
  String? detail;

  JoinLeagueResponse({required this.success, required this.uri, this.detail});

  factory JoinLeagueResponse.fromJoinLeaguesJson(Map<String, dynamic> json) {
    return JoinLeagueResponse(
      success: json['success'],
      uri: json['uri'],
      detail: json['uri'],
    );
  }
}

String utfFormatting(String playerNames) {
  // making sure there are no super long names
  return utf8.decode(playerNames.runes.toList());
}

String alexOxladeChamberlain(String playerNames){
    return (playerNames.length > 16)
      ? utf8.decode(playerNames.runes.toList()).substring(0, 15)
      : utf8.decode(playerNames.runes.toList());
}

String shortToMed(String position) {
  String formattedPosition = position;
  switch (formattedPosition) {
    case "G":
      return "GK";

    case "D":
      return "Def";

    case "M":
      return "Mid";

    case "F":
      return "Att";
  }
  return "";
}

String medToLong(String position) {
  String formattedPosition = position;
  switch (formattedPosition) {
    case "GK":
      return "Goal Keeper";

    case "Back":
      return "Defender";

    case "Midfield":
      return "Midfielder";

    case "Att":
      return "Attacker";
  }
  return "";
}

String awkwardToShort(String position) {
  String formattedPosition = position;
  switch (formattedPosition) {
    case "GK":
      return "G";

    case "Back":
      return "D";

    case "Midfield":
      return "M";

    case "Forward":
      return "F";
  }
  return "";
}

List<dynamic> filterPlayersByPosition(List<dynamic> players, String position) {
  List<dynamic> filteredList = [];
  if (position == "Reserve") {
    return players;
  }
  for (Map<String, dynamic> player in players) {
    if (player["position"] == awkwardToShort(position)) {
      filteredList.add(player);
    }
  }
  return filteredList;
}


// void main() async {
//   var lel = await getPublicLeagues();
//   print(lel.publicLeagues);
// }
