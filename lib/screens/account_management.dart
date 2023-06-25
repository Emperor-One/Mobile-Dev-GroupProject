import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'delete_account.dart';
import 'password_change.dart';

class AccountManage extends StatelessWidget {
  const AccountManage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(16, 23, 41, 1),
      appBar: AppBar(
        title: const Text(
          'Account Management',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                context.go("/homePage");
              },
              icon: const Icon(
                Icons.logout,
                color: Color.fromRGBO(255, 255, 255, 0.45),
                size: 28,
                weight: 1.0,
              ))
        ],
        backgroundColor: const Color.fromRGBO(16, 23, 41, 1),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2.0),
          child: Container(
            color: const Color.fromRGBO(255, 255, 255, 0.45),
            height: 1.0,
            margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(10, 20, 10, 0),
        child: Column(
          children: [
            Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
              color: Color.fromRGBO(132, 156, 220, 0.3),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
                  ),
                  const Expanded(
                    child: Text(
                      'Change password',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  IconButton(
                    alignment: Alignment.centerRight,
                    onPressed: () {
                      GoRouter.of(context).push('/change_password');
                    },
                    icon: const Icon(
                      Icons.chevron_right,
                      color: Color.fromRGBO(255, 255, 255, 0.45),
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            ),
            Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
              color: const Color.fromRGBO(132, 156, 220, 0.3),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
                  ),
                  const Expanded(
                    child: Text(
                      'Delete account',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  IconButton(
                    alignment: Alignment.centerRight,
                    onPressed: () {
                      GoRouter.of(context).push('/delete_account');
                    },
                    icon: const Icon(
                      Icons.chevron_right,
                      color: Color.fromRGBO(255, 255, 255, 0.45),
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
            const Padding(padding: EdgeInsets.fromLTRB(0, 50, 0, 0)),
            SizedBox(
              width: 230.0,
              height: 30.0,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed)) {
                        return const Color.fromRGBO(255, 255, 255, 0.5);
                      }
                      return Colors.white;
                    },
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                ),
                onPressed: () {
                  GoRouter.of(context).go("/homePage");
                },
                child: const Text(
                  'Log out',
                  style: TextStyle(
                    color: Color.fromRGBO(16, 23, 41, 1),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedIconTheme: const IconThemeData(
          color: Color.fromRGBO(255, 255, 255, 1),
        ),
        selectedItemColor: Colors.white,
        backgroundColor: const Color.fromRGBO(16, 23, 41, 1),
        unselectedIconTheme: const IconThemeData(
          color: Color.fromRGBO(255, 255, 255, 0.45),
        ),
        unselectedItemColor: const Color.fromRGBO(255, 255, 255, 0.45),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.calendar_month_outlined,
            ),
            label: 'Fixtures',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings_outlined,
            ),
            label: 'Settings',
          )
        ],
        currentIndex: 2,
        onTap: (index) {
          if (index == 0) {
            GoRouter.of(context).push("/nextPage");
          } else if (index == 1) {
            GoRouter.of(context).push("/fixtures");
          } else {
            GoRouter.of(context).push("/account_management");
          }
        },
      ),
    );
  }
}
