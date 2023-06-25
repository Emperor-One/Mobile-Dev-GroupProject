import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/bloc/join_bloc.dart';
import '../utils/http_test.dart';

import '../widgets/widgets.dart';

class PlayerInfo extends StatelessWidget {
  const PlayerInfo({super.key});

  @override
  Widget build(BuildContext context) {
    double dividerWidth = MediaQuery.of(context).size.width * 0.954;
    double appBarHeight = MediaQuery.of(context).size.height * 0.15;

    double containerWidth = MediaQuery.of(context).size.width * 0.862;

    const Color containerColor = Color.fromARGB(77, 132, 156, 220);

    return BlocBuilder<JoinBloc, JoinState>(
      builder: (context, state) {
        if (state is PlayersState) {
          return Scaffold(
            appBar: AppBar(
              titleSpacing: 0.0,
              // leadingWidth: 30.0,
              leading: Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: GestureDetector(
                  onTap: () {
                    print("PRESSING");
                    // context.read<JoinBloc>().add(BackFromInfo(0,""));
                    GoRouter.of(context).pop();
                  },
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    size: 30,
                  ),
                ),
              ),
              toolbarHeight: appBarHeight,
              // centerTitle: true,
              title: Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: appBarHeight * 0.4,
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(
                        "http://10.0.2.2:8000/players/${state.playerId}/pic"),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.1,
                  ),
                  Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(alexOxladeChamberlain(state.playerName)),
                      // SizedBox(height: appBarHeight * 0.087,),
                      Text(state.position,
                          style: Theme.of(context).textTheme.bodyLarge),
                    ],
                  )
                ],
              ),
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: SizedBox(
                    // width: dividerWidth,
                    child: Divider(color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  width: containerWidth,
                  padding: EdgeInsets.all(10.0),
                  color: containerColor,
                  child: Column(children: [
                    PlayerInfoRow(
                      stat: "Goals",
                      statCount: "23",
                    ),
                    PlayerInfoRow(
                      stat: "Assists",
                      statCount: "23",
                    ),
                    PlayerInfoRow(
                      stat: "Yellow Cards",
                      statCount: "23",
                    ),
                    PlayerInfoRow(
                      stat: "Red Cards",
                      statCount: "23",
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Games",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Text(
                            "23",
                            style: Theme.of(context).textTheme.bodyLarge,
                          )
                        ],
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          );
        } else {
          return Scaffold(
              body: SizedBox(
                  width: containerWidth, child: CircularProgressIndicator()));
        }
      },
    );
  }
}

