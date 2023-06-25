class fixture_model {
  late int id;
  late int teamIdOne;
  late int teamIdTwo;
  late int homeScore;
  late int awayScore;
  late String homeTeam;
  late String awayTeam;
  late String startTime;
  late String currentState;
  late int totShotHome;
  late int totShotAway;
  late double possessionHome;
  late double possessionAway;
  late int savesHome;
  late int savesAway;

  fixture_model({required this.id , required this.homeScore, required this.awayScore , required this.homeTeam , required this.awayTeam , required this.startTime , required this.currentState , required this.totShotHome , required this.totShotAway , required this.possessionHome , required this.possessionAway , required this.savesHome , required this.savesAway , required this.teamIdOne , required this.teamIdTwo});

  factory fixture_model.fromJSON(Map<String , dynamic> json){
    return fixture_model( 
    id : json['id'],
    teamIdOne : json['teamIdOne'],
    teamIdTwo : json['teamIdTwo'],
    homeScore : json['homeScore'],
    awayScore : json['awayScore'],
    homeTeam : json['homeTeam'],
    awayTeam : json['awayTeam'],
    startTime : json['startTime'],
    currentState : (json['finished'] == 1) ? 'FT' : json['currentState'].toString(),
    totShotHome : json['totShotHome'],
    totShotAway : json['totShotAway'],
    possessionAway : json['possessionAway'].toDouble(),
    possessionHome : json['possessionHome'].toDouble(),
    savesHome : json['savesHome'],
    savesAway : json['savesAway']
    );
  }
}