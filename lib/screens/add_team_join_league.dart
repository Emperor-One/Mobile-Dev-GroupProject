import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soccer_strategist/utils/http_test.dart';

import 'add_player.dart';
import '../widgets/widgets.dart';
import '../blocs/bloc/join_bloc.dart';

const List<String> positions = [
  "Goal Keeper",
  "Defender",
  "Midfielder",
  "Attacker"
];
String captain = 'Select captain';

class AddTeamJoin extends StatefulWidget {
  bool isDropdownEnabled = false;

  AddTeamJoin({super.key});

  @override
  State<AddTeamJoin> createState() => _AddTeamJoinState();
}

class _AddTeamJoinState extends State<AddTeamJoin> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    const Color containerColor = Color.fromARGB(77, 132, 156, 220);
    const Color playerContainerColor = Color.fromARGB(140, 132, 156, 220);

    double containerWidth = MediaQuery.of(context).size.width * 0.915;
    double containerHeight = MediaQuery.of(context).size.height * 0.08;

    double dividerWidth = MediaQuery.of(context).size.width * 0.954;

    // Hard coding it like this causes issues for bigger screens
    double fieldWidth = 328.0;
    double fieldHeight = 354.1;

    double playerContainerWidth = MediaQuery.of(context).size.width * 0.248;
    double playerContainerHeight = MediaQuery.of(context).size.height * 0.14;

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
            padding: const EdgeInsets.only(top: 20.0),
            child: Text(
              "Add Team",
            ),
          ),
        ),
        body: BlocBuilder<JoinBloc, JoinState>(
          builder: (context, state) {
            print(state);
            if (state is AddLeagueState) {
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    Center(
                      child: SizedBox(
                        height: 35.0,
                        width: dividerWidth,
                        child: const Divider(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      // padding: const EdgeInsets.all( 8.0),
                      width: containerWidth,
                      height: containerHeight,
                      color: containerColor,
                      child: ListTile(
                        leading: Icon(
                          Icons.info_outline,
                          color: IconTheme.of(context).color,
                        ),
                        title: Text(
                          "You are one step away joining the  league! Just select your team and hit the ‘Add team’ button.",
                          textAlign: TextAlign.justify,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        horizontalTitleGap: 10.0,
                        minLeadingWidth: 24.0,
                        contentPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      ),
                    ),
                    SizedBox(
                      height: 80.0,
                    ),
                    Container(
                      width: fieldWidth,
                      height: fieldHeight,
                      // padding: EdgeInsets.only(top: 25.0),
                      // margin: EdgeInsets.only(bottom: 11.0),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            alignment: Alignment.center,
                            image: AssetImage("images/field.png"),
                            fit: BoxFit.contain),
                      ),
                      child: Column(
                        children: <Widget>[
                          // const SizedBox(
                          //   height: 25.0,
                          // ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                borderRadius: BorderRadius.horizontal(
                                  left: Radius.circular(15.0),
                                  right: Radius.circular(15.0),
                                ),
                                onTap: () {
                                  context
                                      .read<JoinBloc>()
                                      .add(AddingPlayer(state.leagueId, "GK"));
                                  GoRouter.of(context)
                                      .push("/addTeamJoin/addPlayer");
                                },
                                child: Container(
                                    width: playerContainerWidth,
                                    height: playerContainerHeight * 0.91,
                                    foregroundDecoration: BoxDecoration(
                                      image: redraw(
                                          state.playerId,
                                          state.position,
                                          "GK",
                                          0,
                                          state.selected),
                                      color: playerContainerColor,
                                      borderRadius: BorderRadius.horizontal(
                                        left: Radius.circular(15.0),
                                        right: Radius.circular(15.0),
                                      ),
                                    ),
                                    child: Center(
                                        child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [Text("Select"), Text("GK")],
                                    ))),
                              ),
                              InkWell(
                                borderRadius: BorderRadius.horizontal(
                                  left: Radius.circular(15.0),
                                  right: Radius.circular(15.0),
                                ),
                                onTap: () {
                                  context.read<JoinBloc>().add(
                                      AddingPlayer(state.leagueId, "Reserve"));
                                  GoRouter.of(context)
                                      .push("/addTeamJoin/addPlayer");
                                },
                                child: Container(
                                    width: playerContainerWidth,
                                    height: playerContainerHeight * 0.91,
                                    foregroundDecoration: BoxDecoration(
                                        image: redraw(
                                            state.playerId,
                                            state.position,
                                            "Reserve",
                                            1,
                                            state.selected),
                                        color: playerContainerColor,
                                        borderRadius: BorderRadius.horizontal(
                                          left: Radius.circular(15.0),
                                          right: Radius.circular(15.0),
                                        )),
                                    child: Center(
                                        child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("Select"),
                                        Text("Reserve")
                                      ],
                                    ))),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                borderRadius: BorderRadius.horizontal(
                                  left: Radius.circular(15.0),
                                  right: Radius.circular(15.0),
                                ),
                                onTap: () {
                                  context.read<JoinBloc>().add(
                                      AddingPlayer(state.leagueId, "Back"));
                                  GoRouter.of(context)
                                      .push("/addTeamJoin/addPlayer");
                                },
                                child: Container(
                                    width: playerContainerWidth,
                                    height: playerContainerHeight * 0.91,
                                    foregroundDecoration: BoxDecoration(
                                        image: redraw(
                                            state.playerId,
                                            state.position,
                                            "Back",
                                            2,
                                            state.selected),
                                        color: playerContainerColor,
                                        borderRadius: BorderRadius.horizontal(
                                          left: Radius.circular(15.0),
                                          right: Radius.circular(15.0),
                                        )),
                                    child: Center(
                                        child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [Text("Select"), Text("Back")],
                                    ))),
                              ),
                              InkWell(
                                borderRadius: BorderRadius.horizontal(
                                  left: Radius.circular(15.0),
                                  right: Radius.circular(15.0),
                                ),
                                onTap: () {
                                  context.read<JoinBloc>().add(
                                      AddingPlayer(state.leagueId, "Midfield"));
                                  GoRouter.of(context)
                                      .push("/addTeamJoin/addPlayer");
                                },
                                child: Container(
                                    width: playerContainerWidth,
                                    height: playerContainerHeight * 0.91,
                                    foregroundDecoration: BoxDecoration(
                                        image: redraw(
                                            state.playerId,
                                            state.position,
                                            "Midfield",
                                            3,
                                            state.selected),
                                        color: playerContainerColor,
                                        borderRadius: BorderRadius.horizontal(
                                          left: Radius.circular(15.0),
                                          right: Radius.circular(15.0),
                                        )),
                                    child: Center(
                                        child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("Select"),
                                        Text("Midfield")
                                      ],
                                    ))),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          InkWell(
                            borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(15.0),
                              right: Radius.circular(15.0),
                            ),
                            onTap: () {
                              context
                                  .read<JoinBloc>()
                                  .add(AddingPlayer(state.leagueId, "Forward"));
                              GoRouter.of(context)
                                  .push("/addTeamJoin/addPlayer");
                            },
                            child: Container(
                                width: playerContainerWidth,
                                height: playerContainerHeight * 0.91,
                                foregroundDecoration: BoxDecoration(
                                    image: redraw(
                                        state.playerId,
                                        state.position,
                                        "Forward",
                                        4,
                                        state.selected),
                                    color: playerContainerColor,
                                    borderRadius: BorderRadius.horizontal(
                                      left: Radius.circular(15.0),
                                      right: Radius.circular(15.0),
                                    )),
                                child: Center(
                                    child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [Text("Select"), Text("Forward")],
                                ))),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isDropdownEnabled = true;
                        });
                      },
                      child: Container(
                        width: containerWidth * 0.892,
                        height: playerContainerHeight * 0.38,
                        decoration: BoxDecoration(
                          color: containerColor,
                          borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(15.0),
                            right: Radius.circular(15.0),
                          ),
                        ),
                        child: DropdownButton<String>(
                          value: isDropdownEnabled ? null : selectedValue,
                          hint: Center(
                            child: Text(
                              "Select captain",
                              style: dropdownStyle,
                            ),
                          ),
                          underline: SizedBox(),
                          isExpanded: true,
                          iconEnabledColor: Colors.white,
                          dropdownColor: containerColor,
                          items: positions.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Center(
                                child: Text(
                                  value,
                                  style: dropdownStyle,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              selectedValue = value;
                              print(selectedValue);
                              isDropdownEnabled = false;
                            });
                          },
                        ),
                      ),
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
                          child: const Text("Add Team",
                              style: TextStyle(
                                fontFamily: "Inter",
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                              )),
                          onPressed: () {
                            if (canAddTeam(state.selected) &&
                                selectedValue != null) {
                              context
                                  .read<JoinBloc>()
                                  .add(AddAndJoin(selectedValue!));
                              GoRouter.of(context).go("/nextPage");
                            } else {
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(noAddTeam);
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}

DecorationImage? redraw(int playerId, String statePosition,
    String playerPosition, int index, List<int> selected) {
  if (statePosition == playerPosition && playerId != 0) {
    return DecorationImage(image: NetworkImage("$playersBaseUrl$playerId/pic"));
  } else if (selected[index] != 0) {
    return DecorationImage(
        image: NetworkImage("$playersBaseUrl${selected[index]}/pic"));
  } else {
    return null;
  }
}

bool canAddTeam(List<int> selected) {
  for (int playerId in selected) {
    if (playerId == 0) {
      return false;
    }
  }
  return true;
}
