import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'rules.dart';
import 'privacy.dart';
import 'terms.dart';
import 'leagues.dart';

void main() {
  runApp(mysetting());
}

class mysetting extends StatelessWidget {
  const mysetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Soccer Strategist',
      theme: ThemeData(visualDensity: VisualDensity.adaptivePlatformDensity),
      home: SettingScreen(),
    );
  }
}

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);
  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool _isDarkModeEnabled = false;
  bool _areNotificationsEnabled = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
          backgroundColor: Color.fromARGB(255, 92, 86, 86),
        ),
        backgroundColor: Color.fromARGB(255, 49, 75, 88),
        body: ListView(children: [
          ListTile(
            title: const Text(
              'Rules',
              style: TextStyle(color: Colors.white),
            ),
            leading: const Icon(Icons.rule_rounded, color: Colors.white),
            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white),
            onTap: () {
              Navigator.pushNamed(context, '/rulesPage');
            },
          ),
          ListTile(
            title: const Text(
              'Privacy policy',
              style: TextStyle(color: Colors.white),
            ),
            subtitle: const Text(
              'Read our privacy policy',
              style: TextStyle(color: Colors.white),
            ),
            leading: const Icon(Icons.privacy_tip, color: Colors.white),
            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white),
            onTap: () {
              Navigator.pushNamed(context, '/privacyPage');
            },
          ),
          ListTile(
              title: const Text(
                'Terms of Use',
                style: TextStyle(color: Colors.white),
              ),
              leading: const Icon(Icons.privacy_tip, color: Colors.white),
              trailing:
                  const Icon(Icons.arrow_forward_ios, color: Colors.white),
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => TermsOfUsePage()),
                GoRouter.of(context).push("/termsPage");
              })
        ]));
  }
}
