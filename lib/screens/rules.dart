import 'package:flutter/material.dart';
void main() {
  runApp(myrule());
}
class myrule extends StatelessWidget {
  const myrule({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'players page',
    home:RulesPage());
  }
}
class RulesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rules'),
        backgroundColor: Color.fromARGB(255, 46, 48, 51),
      ),
      backgroundColor: Color.fromARGB(255, 49, 75, 88),
      body: Container(
       padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Football Fantasy App Rules:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              '1. Create a team by selecting players from different teams.',
              style: TextStyle(fontSize: 18.0,color:Colors.white
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              '2. Select a captain and vice-captain for your team.',
              style: TextStyle(fontSize: 18.0,color:Colors.white),
            ),
            SizedBox(height: 8.0),
            Text(
              '3. Join leagues and compete with other users.',
              style: TextStyle(fontSize: 18.0,color:Colors.white),
            ),
            SizedBox(height: 8.0),
            Text(
              '4. Earn points based on the performance of your selected players in real matches.',
              style: TextStyle(fontSize: 18.0,color:Colors.white),
            ),
            SizedBox(height: 8.0),
            Text(
              '5. The user with the highest points at the end of the league wins.',
              style: TextStyle(fontSize: 18.0,color:Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
