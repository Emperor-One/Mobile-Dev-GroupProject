import 'package:flutter/material.dart';
void main() {
  runApp(myterm());
}
class myterm extends StatelessWidget {
  const myterm({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'players page',
     theme: ThemeData(
         scaffoldBackgroundColor: Colors.black, 
          visualDensity: VisualDensity.adaptivePlatformDensity),
    home:TermsOfUsePage());
  }
}
class TermsOfUsePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms of Use'),
        backgroundColor: Color.fromARGB(255, 32, 34, 36),
      ),
      backgroundColor: Color.fromARGB(255, 49, 75, 88),
      body: 
       Container(
         padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Football Fantasy App Terms of Use:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              '1. Users must be at least 18 years old to use the app.',
              style: TextStyle(fontSize: 18.0,color: Colors.white,),
            ),
            SizedBox(height: 8.0),
            Text(
              '2. Users are responsible for maintaining the security of their account information.',
              style: TextStyle(fontSize: 18.0,color: Colors.white,),
            ),
            SizedBox(height: 8.0),
            Text(
              '3. Users must not use the app for any illegal or unauthorized purpose.',
              style: TextStyle(fontSize: 18.0,color: Colors.white,),
            ),
            SizedBox(height: 8.0),
            Text(
              '4. Users must not use the app to harass or intimidate others.',
              style: TextStyle(fontSize: 18.0,color: Colors.white,),
            ),
            SizedBox(height: 8.0),
            Text(
              '5. The app reserves the right to terminate user accounts that violate these terms of use.',
              style: TextStyle(fontSize: 18.0,color: Colors.white,),
            ),
          ],
        ),
      ),
    );
  }
}
