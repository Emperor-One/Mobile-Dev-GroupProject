import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'Registration.dart';
import 'loginForm.dart';
import 'teams.dart';
import 'setting.dart';
import 'teamss.dart';

class LeaguePage extends StatelessWidget {
  final String? username;

  LeaguePage({this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Hi , User'),
          backgroundColor: Color.fromARGB(255, 20, 26, 29),
        ),
        backgroundColor: Color.fromARGB(255, 16, 21, 24),
        body: ListView(
          children: [
            Container(
              height: 70.0,
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Managed Leagues',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  // SizedBox(height: 10.0),
                  // GestureDetector(
                  //   onTap: () {
                  //     GoRouter.of(context).push("/teamsPage");
                  //   },
                  //   child: buildLeagueContainer('League - 1', isOwned: false),
                  // ),
                  // SizedBox(height: 10.0),
                  // GestureDetector(
                  //   onTap: () {
                  //     GoRouter.of(context).push("/teamsPage");
                  //   },
                  //   child: buildLeagueContainer('League - 2', isOwned: false),
                  // ),
                ],
              ),
            ),
            Container(
              height: 70.0,
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Owned Leagues',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  // SizedBox(height: 10.0),
                  // GestureDetector(
                  //   onTap: () {
                  //     GoRouter.of(context).push("/teamssPage");
                  //   },
                  //   child: buildLeagueContainer('League - 2', isOwned: true),
                  // ),
                  // SizedBox(height: 10.0),
                  // GestureDetector(
                  //   onTap: () {
                  //     GoRouter.of(context).push("/teamssPage");
                  //   },
                  //   child: buildLeagueContainer('League - 2', isOwned: true),
                  // ),
                ],
              ),
            ),
            Container(
              height: 70.0,
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Member Leagues',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  // SizedBox(height: 10.0),
                  // GestureDetector(
                  //   onTap: () {
                  //     GoRouter.of(context).push("/teamsPage");
                  //   },
                  //   child: buildLeagueContainer('League - 1', isOwned: false),
                  // ),
                  // SizedBox(height: 10.0),
                  // GestureDetector(
                  //   onTap: () {
                  //     GoRouter.of(context).push("/teamsPage");
                  //   },
                  //   child: buildLeagueContainer('League - 2', isOwned: false),
                  // ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            GoRouter.of(context).push("/join");
          },
          child: Icon(
            Icons.add,
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
        ),
        bottomNavigationBar: Container(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
          Divider(color: Colors.white),
          BottomNavigationBar(
              backgroundColor: Color.fromARGB(255, 49, 75, 88),
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home,
                      color: Colors.white,
                    ),
                    label: 'Home'),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.calendar_month_outlined,
                    color: Colors.white,
                  ),
                  label: 'Fixtures',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.settings_outlined,
                    color: Colors.white,
                  ),
                  label: 'Settings',
                ),
              ],
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white,
              selectedLabelStyle: TextStyle(color: Colors.white),
              onTap: (index) {
                if (index == 0) {
                  GoRouter.of(context).push("/nextPage");
                } else if (index == 1) {
                  GoRouter.of(context).push("/fixtures");
                } else {
                  GoRouter.of(context).push("/account_management");
                }
              }),
        ])));
  }

  Widget buildLeagueContainer(String leagueName, {bool isOwned = false}) {
    return Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 48, 95, 117),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(leagueName,
              style: TextStyle(
                color: Colors.white,
              )),
          if (isOwned)
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    // Handle edit button tap
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    // Handle delete button tap
                  },
                ),
              ],
            ),
        ],
      ),
    );
  }
}
