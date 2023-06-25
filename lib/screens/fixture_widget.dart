import 'package:flutter/material.dart';
import '../models/fixture_model.dart';

class Fixture extends StatefulWidget{
      final fixture_model fixture;
      const Fixture({super.key , required this.fixture});
      
      @override
      _FixtureState createState() => _FixtureState();
}

class _FixtureState extends State<Fixture>{
  Color fixtureColor = Color.fromARGB((255 * .30).toInt(), 132, 156, 220);
  Color textColor = Color.fromARGB((255 * 0.50).toInt(), 255, 255, 255);
  bool _collapsed = true;  
  late fixture_model fix;

  Widget _buildLogo({required int team}){
    return Image.network(
     'http://10.0.2.2:8000/clubs/$team/pic',
     width: 30,
     height: 30,
    );
  }

  Widget _buildScore({int home = -1 , int away = -1}){
    if (home == -1 || away == -1){
      return const Text('VS');
    }
    return Text('$home - $away' , style: TextStyle(color: textColor),);
  }

  Widget _stat({String StatName = '' , dynamic homeValue , dynamic awayValue}){
    
    if (StatName == ''){
      StatName = 'Nan';
      homeValue = '-';
      awayValue = '-';
    }
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      height: 18,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('$homeValue' , style: TextStyle(color: textColor),),
          Text(StatName , style:  TextStyle(fontWeight: FontWeight.bold, color: textColor),),
          Text('$awayValue' , style: TextStyle(color: textColor),)
        ],
      ),
    );
  }

  Widget _buildStats(fixture_model fix){
    return  Container(
      margin: const EdgeInsets.only(top: 5),
      padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(color: fixtureColor),
      height: 134,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _stat(StatName: 'Possesion' , homeValue: fix.possessionHome , awayValue: fix.possessionAway),
          _stat(StatName: 'Tot. Shots' , homeValue: fix.totShotHome , awayValue: fix.totShotAway),
          _stat(StatName: 'Shots on Target' , homeValue: fix.savesAway + fix.homeScore , awayValue: fix.savesHome + fix.awayScore),
          _stat(StatName: 'Saves' , homeValue: fix.savesHome , awayValue: fix.savesAway)
        ]
        ),
    );
  }
  
  void _toggleExpanded(){
    setState(() {
      _collapsed = !_collapsed;
    });
  }

  @override
  Widget build (BuildContext context){
    fix = widget.fixture;

    return GestureDetector(
      onTap : _toggleExpanded,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: MediaQuery.of(context).size.width * 0.97,
                  height: 60,
                  padding: const EdgeInsets.all(7),
                  margin: const EdgeInsets.only(top: 5),
                  decoration: BoxDecoration(color:fixtureColor),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                           Text(fix.startTime , style: TextStyle(color : textColor),),
                           Text(fix.currentState , style: TextStyle(color : textColor),)
                        ]
                      ),
                      VerticalDivider(
                        width: 15,
                        thickness: 2,
                        color : fixtureColor
                      ),
                      SizedBox(
                        width: 107,
                        child: Row(
                          children: [
                            Flexible(
                              flex: 2,
                              child:
                                 Text(
                                  fix.homeTeam,
                                  style: TextStyle(color: textColor),
                                  ),
                            ),
                            _buildLogo(team: fix.teamIdOne)
                          ],
                          ),
                        ),
                      SizedBox(
                        width: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children : [_buildScore(home: fix.homeScore, away: fix.awayScore)]),
                      ),
                      SizedBox(
                        width: 107,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildLogo(team: fix.teamIdTwo),
                            Flexible(
                              flex: 2,
                              child:
                                 Text(
                                  fix.awayTeam,
                                  style: TextStyle(color : textColor),
                                  ),
                            ),
                          ],
                          ),
                        ),
                    ],
                  )),
            ],
          ), 
          //Stats Bar
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.97,
            child: _collapsed ? const Padding(padding: EdgeInsets.only(top: 0)) : _buildStats(fix)
          )
        ],
      ) ,
    );   
  }
}




