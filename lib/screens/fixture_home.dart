import '../models/fixture_model.dart';
import 'package:flutter/material.dart';
import 'fixture_navigation_widget.dart';
import 'fixture_widget.dart';
import '../data_provider/fixture_provider.dart';


class FixtureHome extends StatefulWidget {
  const FixtureHome({super.key});

  @override
  State<FixtureHome> createState() => _FixtureHomeState();
}

class _FixtureHomeState extends State<FixtureHome> {
  late MatchGetter matchGetter;
  List fixtures =[];
  int fixture_count = 0;

  Future initialize() async {
    fixtures = await matchGetter.getMatches();
    setState(() {
      fixtures = fixtures;
      fixture_count = fixtures.length;
    });
  }
  
  
  @override
  void initState() {
    matchGetter = MatchGetter();
    initialize();
    super.initState();
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 16, 23, 41),
      appBar: AppBar(
        title: Text(
          "Fixtures",
          style: TextStyle(
            fontWeight: FontWeight.bold , 
            fontSize: 25,
            color : Color.fromARGB((255 * 0.75).toInt(), 255, 255, 255),
            ), 
          ),
        
        elevation: 0.0,
        backgroundColor: const Color.fromARGB(255, 16, 23, 41),
      ),
      body: 
          Column(
            children: [
              Divider(
                color: Color.fromARGB((255 * .45).toInt(), 255, 255, 255),
                thickness: 3,
              ),
              Text(
                "Today's Matches",
                style: TextStyle(
                  color: Color.fromARGB((255 * 0.75).toInt(), 255, 255, 255),
                  fontWeight: FontWeight.bold,
                  fontSize: 20
                ),
              ),
              Expanded(
                child:ListView.builder(
                  itemCount: (fixture_count == null) ? 0 : fixture_count,
                  itemBuilder: (BuildContext context , int position){
                    return Fixture(fixture: fixtures[position]);
                  },                  
                ),
              ),  
              Divider(
                color: Color.fromARGB((255 * .45).toInt(), 255, 255, 255),
                thickness: 3,
              ),
            ],
          ),
      bottomNavigationBar: BottomNavBar(selectedItem:1)
      );
  }
}
