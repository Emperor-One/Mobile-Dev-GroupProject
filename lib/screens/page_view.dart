import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'create_league.dart';
import 'join_league.dart';

class CustomPageView extends StatefulWidget {
  const CustomPageView({Key? key}) : super(key: key);

  @override
  State<CustomPageView> createState() => _CustomPageViewState();
}

class _CustomPageViewState extends State<CustomPageView> {
  final PageController _controller = PageController();
  int currentPageIndex = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double dividerWidth = MediaQuery.of(context).size.width * 0.954;
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: GestureDetector(
            onTap: () {
              // context.read<JoinBloc>().add(AddLoaded(leagueId: leagueId, playerPosition: playerPosition),
              GoRouter.of(context).pop();
            },
            child: Icon(
              Icons.arrow_back_ios_new,
              size: 30,
            ),
          ),
        ),
        title: Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: Text(
            "League Management",
          ),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 35.0,
              width: dividerWidth,
              child: Divider(
                color: Colors.white,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    setState(() {
                      currentPageIndex = 0;
                    });
                    _controller.animateToPage(
                      0,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Join League",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w600,
                          fontSize: 20.0,
                        ),
                      ),
                      SizedBox(
                        width: 120,
                        child: Divider(
                          color: currentPageIndex == 0
                              ? Colors.white
                              : Color.fromARGB(255, 16, 23, 41),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      currentPageIndex = 1;
                    });
                    _controller.animateToPage(
                      1,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: Column(
                    children: <Widget>[
                      const Text(
                        "Create League",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w600,
                          fontSize: 20.0,
                        ),
                      ),
                      SizedBox(
                        width: 140,
                        child: Divider(
                          color: currentPageIndex == 1
                              ? Colors.white
                              : Color.fromARGB(255, 16, 23, 41),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: PageView(
                controller: _controller,
                onPageChanged: (index) {
                  setState(() {
                    currentPageIndex = index;
                  });
                },
                children: <Widget>[
                  JoinLeaguePage(),
                  const CreateLeaguePage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
