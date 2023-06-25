import 'package:flutter/material.dart';
void main() {
  runApp(mypri());
}
class mypri extends StatelessWidget {
  const mypri({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'rules page',
    home:PrivacyPolicyPage());
  }
}
class PrivacyPolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
        backgroundColor: Color.fromARGB(255, 45, 48, 46),
      ),
      backgroundColor: Color.fromARGB(255, 49, 75, 88),
      body: Container(
        decoration:const  BoxDecoration(
         
    ),
  
        padding: const  EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment:  CrossAxisAlignment.start,
          children: const [
            Text(
              'Football Fantasy App Privacy Policy:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              '1. We collect user information such as name and email address to provide services to our users.',
              style: TextStyle(fontSize: 18.0,color: Colors.white,),
            ),
            SizedBox(height: 8.0),
            Text(
              '2. We do not sell or share user information with third parties for marketing purposes.',
              style: TextStyle(fontSize: 18.0,color: Colors.white,),
            ),
            SizedBox(height: 8.0),
            Text(
              '3. We use cookies to improve user experience and track website usage.',
              style: TextStyle(fontSize: 18.0,color: Colors.white,),
            ),
            SizedBox(height: 8.0),
            Text(
              '4. We implement security measures to protect user information from unauthorized access and use.',
              style: TextStyle(fontSize: 18.0,color: Colors.white,),
            ),
            SizedBox(height: 8.0),
            Text(
              '5. We may disclose user information in response to legal requests or to comply with legal requirements.',
              style: TextStyle(fontSize: 18.0,color: Colors.white,),
            ),
            SizedBox(height: 8.0),
            Text(
              '6. We may share your personal information with third-party service providers who assist us in providing and maintaining our app.',
              style: TextStyle(fontSize: 18.0,color: Colors.white,),
            ),
          ],
        ),
      ),
    );
  }
}
