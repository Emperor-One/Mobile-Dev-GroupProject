import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'account_management.dart';

class DeleteAccount extends StatelessWidget {
  const DeleteAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(16, 23, 41, 1),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color.fromRGBO(255, 255, 255, 0.45),
            size: 25,
            weight: 1.0,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AccountManage(),
              ),
            );
          },
        ),
        title: const Text('Delete Account'),
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
            const Card(
              color: Color.fromRGBO(132, 156, 220, 0.30),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                  ),
                  Column(
                    children: [
                      Icon(
                        Icons.info_outline,
                        size: 20,
                        color: Color.fromRGBO(255, 255, 255, 0.45),
                      ),
                      Padding(padding: EdgeInsets.fromLTRB(0, 25, 0, 20))
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  ),
                  Expanded(
                    child: Text(
                      'Note that once you delete your account, your whole record will be lost. If you are sure, fill in your password and hit the delete button.',
                      style:
                          TextStyle(color: Color.fromRGBO(255, 255, 255, 0.45)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20.0),
            ),
            const Text(
              'Enter password for confirmation',
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.45),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 40.0),
            ),
            const TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.vpn_key_outlined,
                    color: Color.fromRGBO(255, 255, 255, 0.45)),
                labelText: 'Password',
                labelStyle:
                    TextStyle(color: Color.fromRGBO(255, 255, 255, 0.45)),
                border: OutlineInputBorder(),
                focusColor: Color.fromRGBO(255, 255, 255, 0),
                fillColor: Color.fromRGBO(132, 156, 220, 0.30),
                filled: true,
                // disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(15),)
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20.0),
            ),
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
                  context.go("/homePage");
                },
                child: const Text(
                  'Delete account',
                  style: TextStyle(
                    color: Color.fromRGBO(16, 23, 41, 1),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
