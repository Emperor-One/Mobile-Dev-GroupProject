import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/bloc/join_bloc.dart';
import 'package:soccer_strategist/utils/http_test.dart';

const List<String> positions = ["GK", "Reserve", "Back", "Midfield", "Forward"];
bool isDropdownEnabled = false;
String? selectedOption;

final TextStyle dropdownStyle = TextStyle(
  fontFamily: "Inter",
  fontSize: 17,
  color: Colors.white,
);

SnackBar snackBar = SnackBar(
  content: const Text(
    'Player already selected',
    style: TextStyle(color: Colors.black),
  ),
  backgroundColor: Colors.white,
  showCloseIcon: true,
  duration: Duration(seconds: 30),
);

class AddPlayer extends StatelessWidget {
  const AddPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    const Color containerColor = Color.fromARGB(77, 132, 156, 220);

    double containerWidth = MediaQuery.of(context).size.width * 0.894;
    double containerHeight = MediaQuery.of(context).size.height * 0.265;

    double dividerWidth = MediaQuery.of(context).size.width * 0.954;

    return BlocBuilder<JoinBloc, JoinState>(
      builder: (context, state) {
        if (state is PlayersState) {
          return WillPopScope(
            onWillPop: () async {
              context.read<JoinBloc>().add(SelectPlayer(0));
              GoRouter.of(context).pop();
              return false;
            },
            child: Scaffold(
              appBar: AppBar(
                leading: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      context.read<JoinBloc>().add(SelectPlayer(0));

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
                    "Add Player",
                  ),
                ),
              ),
              body: Column(
                children: <Widget>[
                  Center(
                    child: SizedBox(
                      height: 35.0,
                      width: dividerWidth,
                      child: const Divider(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 0.39,
                        color: containerColor,
                        child: DropdownButton(
                          isExpanded: true,
                          alignment: Alignment.center,
                          underline: SizedBox(),
                          iconDisabledColor: containerColor,
                          disabledHint: Text(
                            state.position,
                            style: dropdownStyle,
                          ),
                          dropdownColor: Theme.of(context)
                              .dropdownMenuTheme
                              .inputDecorationTheme!
                              .fillColor,
                          hint: Text(
                            "Position",
                            style: dropdownStyle,
                          ),
                          onChanged: null,
                          items: positions.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.39,
                        color: containerColor,
                        child: DropdownButton(
                          isExpanded: true,
                          alignment: Alignment.center,
                          underline: SizedBox(),
                          iconEnabledColor: Colors.white,
                          hint: Text(
                            "Team",
                            style: dropdownStyle,
                          ),
                          dropdownColor: Theme.of(context)
                              .dropdownMenuTheme
                              .inputDecorationTheme!
                              .fillColor,
                          style: dropdownStyle,
                          onChanged: (e) {},
                          items: positions.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Expanded(
                    child: Container(
                      width: containerWidth,
                      color: containerColor,
                      padding:
                          EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.only(bottom: 8.0, top: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  width: containerWidth * 0.1,
                                ),
                                Text("Name",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium),
                                SizedBox(
                                  width: containerWidth * 0.19,
                                ),
                                Text(
                                  "Pos.",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 0,
                            child: Divider(
                              color: Colors.white,
                            ),
                          ),
                          FutureBuilder(
                            future: filterPlayers(state.position),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                var players = snapshot.data!.players;

                                return SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.65,
                                  child: ListView.separated(
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            ScaffoldMessenger.of(context)
                                                .hideCurrentSnackBar();

                                            final playerId =
                                                players[index]["id"];
                                            if (canAddPlayer(
                                                playerId, state.selected)) {
                                              context
                                                  .read<JoinBloc>()
                                                  .add(SelectPlayer(playerId));
                                              GoRouter.of(context).pop();
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                            }
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10.0),
                                            child: ListTile(
                                              leading: CircleAvatar(
                                                radius: 33,
                                                backgroundImage: NetworkImage(
                                                    "$playersBaseUrl${players[index]['id']}/pic"),
                                                backgroundColor: Colors.white,
                                              ),
                                              title: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                        utfFormatting(
                                                            players[index]
                                                                ["name"]),
                                                        style: TextStyle(
                                                            fontFamily: "Inter",
                                                            fontSize: 19,
                                                            color: Colors.white,
                                                            overflow:
                                                                TextOverflow
                                                                    .visible)),
                                                  ),
                                                  // SizedBox(
                                                  //   width: containerWidth * 0.15,
                                                  // ),
                                                  Text(
                                                    shortToMed(players[index]
                                                        ["position"]),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge,
                                                  ),
                                                ],
                                              ),
                                              trailing: InkWell(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                onTap: () {
                                                  context.read<JoinBloc>().add(
                                                      PlayerInfoPressed(
                                                          players[index]["id"],
                                                          players[index]
                                                              ["name"],
                                                          medToLong(players[
                                                                  index]
                                                              ["position"])));
                                                  GoRouter.of(context).push(
                                                      "/addTeamJoin/addPlayer/playerInfo");
                                                },
                                                child: Icon(Icons.info_outline,
                                                    color: Colors.white54),
                                              ),
                                              contentPadding: EdgeInsets.all(0),
                                              minLeadingWidth: 0,
                                            ),
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context, index) {
                                        return const SizedBox(
                                            height: 1.0,
                                            child: Divider(
                                              color: Colors.white,
                                            ));
                                      },
                                      itemCount: players.length),
                                );
                              } else if (snapshot.hasError) {
                                return Center(
                                    child: Text(snapshot.error.toString()));
                              } else {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

bool canAddPlayer(int playerId, List<int> selected) {
  for (int selectedId in selected) {
    if (playerId == selectedId) {
      return false;
    }
  }
  return true;
}
