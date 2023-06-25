import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'dart:convert';

import '/blocs/bloc/join_bloc.dart';
import '../widgets/widgets.dart';
import '../utils/http_test.dart';

class JoinLeaguePage extends StatefulWidget {
  const JoinLeaguePage({super.key});

  @override
  State<JoinLeaguePage> createState() => _JoinLeaguePageState();
}

class _JoinLeaguePageState extends State<JoinLeaguePage> {
  TextEditingController _textEditingController = TextEditingController();

  void _onSubmit() {
    String inputValue = _textEditingController.text;
    print(inputValue);
    inputValue = inputValue.replaceAll(" ", "");
    if (inputValue.length < 1) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(emptySnackBar);
    }
    for (int i = 0; i < inputValue.length; i++) {
      print(inputValue[i]);
      if (inputValue[i] == "-") {
        print(inputValue.substring(0, i));
        int leagueId = int.parse(inputValue.substring(0, i));
        String entryCode = inputValue.substring(
          i + 1,
        );
        _textEditingController.clear();
        FocusScope.of(context).unfocus();

        context.read<JoinBloc>().add(JoinPrivateLeague(leagueId, entryCode));
        GoRouter.of(context).push("/addTeamJoin");
        return;
      }
    }
    _textEditingController.clear();
    FocusScope.of(context).unfocus();
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double dividerWidth = MediaQuery.of(context).size.width * 0.954;
    double containerWidth = MediaQuery.of(context).size.width * 0.861;
    double containerHeight = MediaQuery.of(context).size.height * 0.31;
    Orientation deviceOrientation = MediaQuery.of(context).orientation;
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 20.0,
              ),
              // Join Private League Container
              Container(
                color: const Color.fromARGB(77, 132, 156, 220),
                width: containerWidth,
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      "Join Private League",
                      style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      child: Divider(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Simply enter the private league’s ID and secret code separated by a ‘-’ in the box below and click the ‘Join private league’ button. ",
                      textAlign: TextAlign.justify,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Center(
                      child: SizedBox(
                        width: containerWidth * 0.892,
                        height: containerHeight * 0.165,
                        child: TextField(
                          controller: _textEditingController,
                          onSubmitted: (input) {
                            FocusScope.of(context).unfocus();
                            _onSubmit();
                          },
                          style: TextStyle(color: Colors.white),
                          // cursorColor: Colors.white,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            filled: true,
                            fillColor: const Color.fromARGB(77, 132, 156, 220),
                            contentPadding: const EdgeInsets.all(0.0),
                            hintText: "League ID - Secret Code",
                            hintStyle: const TextStyle(
                              color: Color.fromARGB(115, 255, 255, 255),
                            ),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Center(
                      child: SizedBox(
                        width: containerWidth * 0.892,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                            foregroundColor:
                                MaterialStateProperty.all(Colors.black),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(19.0))),
                          ),
                          child: const Text(
                            "Join Private League",
                            style: TextStyle(
                              fontFamily: "Inter",
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          onPressed: () {
                            _onSubmit();
                            // GoRouter.of(context).push("/addTeamJoin");
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              // Public Leauges Container
              Expanded(
                child: Container(
                  color: const Color.fromARGB(77, 132, 156, 220),
                  width: containerWidth,
                  // height: 225,
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                  child: LayoutBuilder(builder: (context, constraints) {
                    print(constraints.maxHeight);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: const Text(
                            "Public Leagues",
                            style: TextStyle(
                                fontFamily: "Inter",
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        const SizedBox(
                          child: Divider(
                            height: 0,
                            color: Colors.white,
                          ),
                        ),
                        FutureBuilder(
                          future: getPublicLeagues(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<dynamic> publicLeagues =
                                  snapshot.data!.publicLeagues;
                              print(publicLeagues.length);
                              return SizedBox(
                                height: constraints.maxHeight * 0.9,
                                child: ListView.separated(
                                  itemBuilder: (context, index) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          utf8.decode(publicLeagues[index]
                                                  ["name"]
                                              .runes
                                              .toList()),
                                          style: const TextStyle(
                                            fontFamily: "Inter",
                                            fontSize: 20.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            int leagueId =
                                                publicLeagues[index]["id"];
                                            context.read<JoinBloc>().add(
                                                JoinButtonPressed(leagueId));
                                            GoRouter.of(context)
                                                .push("/addTeamJoin");
                                          },
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.white),
                                            foregroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.black),
                                            shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            19.0))),
                                          ),
                                          child: const Text(
                                            "Join",
                                            style: TextStyle(
                                              fontFamily: "Inter",
                                              fontSize: 15,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                  itemCount: publicLeagues.length,
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(
                                      child: Divider(
                                        color: Colors.white,
                                      ),
                                    );
                                  },
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return Center(
                                  child: Text(snapshot.error.toString()));
                            } else {
                              return Center(child: CircularProgressIndicator());
                            }
                          },
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
