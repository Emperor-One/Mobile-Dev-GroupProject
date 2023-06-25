import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavBar extends StatelessWidget {
  BottomNavBar({super.key, int this.selectedItem = 0});

  int selectedItem;

  @override
  Widget build(BuildContext context) {
    return BottomNavBarI(
      currentIndex: selectedItem,
    );
  }
}

class BottomNavBarI extends StatefulWidget {
  BottomNavBarI({super.key, int this.currentIndex = 0});
  int currentIndex;

  @override
  State<BottomNavBarI> createState() =>
      _BottomNaBarI(currentIndex: currentIndex);
}

class _BottomNaBarI extends State<BottomNavBarI> {
  _BottomNaBarI({this.currentIndex = 0});
  int currentIndex;
  late int selectedItem;

  @override
  void initState() {
    selectedItem = currentIndex;
    super.initState();
  }

  void _onItemTapped(int index) {
    if (index == 0) {
      GoRouter.of(context).push("/nextPage");
    } else if (index == 1) {
      GoRouter.of(context).push("/fixtures");
    } else {
      GoRouter.of(context).push("/account_management");
    }

    setState(() {
      selectedItem = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined), label: 'Fixtures'),
        BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined), label: 'Settings'),
      ],
      onTap: _onItemTapped,
      currentIndex: selectedItem,
      backgroundColor: const Color.fromARGB(255, 16, 23, 41),
      unselectedItemColor: Color.fromARGB((255 * .45).toInt(), 255, 255, 255),
    );
  }
}
