import 'package:flutter/material.dart';


class CustomSnackBar extends StatelessWidget {
  final String message;
  const CustomSnackBar({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return SnackBar(
  content: Text(
    message,
    style: TextStyle(color: Colors.black),
  ),
  backgroundColor: Colors.white,
  showCloseIcon: true,
  duration: Duration(seconds: 30),
);
  }
}

  final emptySnackBar = SnackBar(
    content: Text(
      "Please enter league ID and secret code",
      style: TextStyle(color: Colors.black),
    ),
    backgroundColor: Colors.white,
    showCloseIcon: true,
    duration: Duration(seconds: 30),
  );

    final snackBar = SnackBar(
    content: Text(
      "Invalid Format",
      style: TextStyle(color: Colors.black),
    ),
    backgroundColor: Colors.white,
    showCloseIcon: true,
    duration: Duration(seconds: 30),
  );

      final noAddTeam = SnackBar(
    content: Text(
      "You need to select your team and choose a captain",
      style: TextStyle(color: Colors.black),
    ),
    backgroundColor: Colors.white,
    showCloseIcon: true,
    duration: Duration(seconds: 30),
  );

  class PlayerInfoRow extends StatelessWidget {
  final String stat;
  final String statCount;

  const PlayerInfoRow({required this.stat, required this.statCount, super.key});

  @override
  Widget build(BuildContext context) {
    double containerWidth = MediaQuery.of(context).size.width * 0.862;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: SizedBox(
            width: containerWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  stat,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  statCount,
                  style: Theme.of(context).textTheme.bodyLarge,
                )
              ],
            ),
          ),
        ),
        SizedBox(
          child: Divider(color: Colors.white),
        )
      ],
    );
  }
}
