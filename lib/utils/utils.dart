import 'dart:convert';

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

String utfFormatting(String playerNames) {
  return utf8.decode(playerNames.runes.toList());
}

String alexOxladeChamberlain(String playerNames) {
  // making sure there are no super long names
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
