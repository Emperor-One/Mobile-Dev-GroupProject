import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'repository/leagues_repository.dart';
import 'data_provider/leagues_dataprovider.dart';
import 'blocs/bloc/join_bloc.dart';
import 'models/fixture_model.dart';

import 'screens/join_league.dart';
import 'screens/page_view.dart';
import 'screens/create_league.dart';
import 'screens/add_team_create_league.dart';
import 'screens/add_team_join_league.dart';
import 'screens/add_player.dart';
import 'screens/player_info.dart';
import 'screens/leagues.dart';
import 'screens/loginForm.dart';
import 'screens/Registration.dart';
import 'screens/rules.dart';
import 'screens/setting.dart';
import 'screens/privacy.dart';
import 'screens/teams.dart';
import 'screens/teamss.dart';
import 'screens/terms.dart';
import 'screens/account_management.dart';
import 'screens/delete_account.dart';
import 'screens/password_change.dart';
import 'screens/fixture_widget.dart';
import 'screens/fixture_home.dart';

void main() {
  final LeaguesRepository leaguesRepository =
      LeaguesRepository(LeaguesDataProvider());
  return runApp(App(leaguesRepository: leaguesRepository));
}

String leagueName = "League - 1";

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) =>
          MaterialPage(child: Scaffold(body: LoginForm())),
    ),
    GoRoute(
        path: "/join",
        builder: (context, state) => const CustomPageView(),
        routes: [
          GoRoute(
            path: "addTeamJoin",
            builder: (context, state) => AddTeamJoin(),
            routes: [
              GoRoute(
                path: "addPlayer",
                builder: (context, state) => AddPlayer(),
                routes: [
                  GoRoute(
                    path: "playerInfo",
                    builder: (context, state) => const PlayerInfo(),
                  ),
                ],
              )
            ],
          ),
        ]),
    GoRoute(
      path: "/create",
      builder: (context, state) => const CreateLeaguePage(),
      routes: [
        GoRoute(
          path: "addTeamCreate",
          builder: (context, state) => const AddTeamCreate(),
          routes: [
            GoRoute(
              path: "addPlayer",
              builder: (context, state) => const AddPlayer(),
              routes: [
                GoRoute(
                  path: "playerInfo",
                  builder: (context, state) => const PlayerInfo(),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: "/addTeamJoin",
      builder: (context, state) => AddTeamJoin(),
      routes: [
        GoRoute(
          path: "addPlayer",
          builder: (context, state) => AddPlayer(),
          routes: [
            GoRoute(
              path: "playerInfo",
              builder: (context, state) => const PlayerInfo(),
            ),
          ],
        )
      ],
    ),
    GoRoute(
      path: '/nextPage',
      pageBuilder: (context, state) => MaterialPage(child: LeaguePage()),
    ),
    GoRoute(
      path: '/registrationPage',
      pageBuilder: (context, state) => MaterialPage(child: RegistrationPage()),
    ),
    GoRoute(
      path: '/LoginFormPage',
      pageBuilder: (context, state) => MaterialPage(child: LoginForm()),
    ),
    GoRoute(
      path: '/teamsPage',
      pageBuilder: (context, state) =>
          MaterialPage(child: TeamsPage(leagueName: leagueName)),
    ),
    GoRoute(
      path: '/settingsPage',
      pageBuilder: (context, state) => MaterialPage(child: SettingScreen()),
    ),
    GoRoute(
      path: '/homePage',
      pageBuilder: (context, state) => MaterialPage(child: LoginForm()),
    ),
    GoRoute(
      path: '/rulesPage',
      pageBuilder: (context, state) => MaterialPage(child: RulesPage()),
    ),
    GoRoute(
      path: '/termsPage',
      pageBuilder: (context, state) => MaterialPage(child: TermsOfUsePage()),
    ),
    GoRoute(
      path: '/privacyPage',
      pageBuilder: (context, state) => MaterialPage(child: PrivacyPolicyPage()),
    ),
    GoRoute(
      path: '/teamssPage',
      pageBuilder: (context, state) =>
          MaterialPage(child: TeamssPage(leagueName: leagueName)),
    ),
    GoRoute(
      path: '/delete_account',
      builder: (context, state) => const DeleteAccount(),
    ),
    GoRoute(
      path: '/change_password',
      builder: (context, state) => const ChangePassword(),
    ),
    GoRoute(
      path: '/account_management',
      builder: (context, state) => const AccountManage(),
    ),
    GoRoute(
      path: '/fixtures',
      builder: (context, state) => const FixtureHome(),
    ),
  ],
);

class App extends StatelessWidget {
  final LeaguesRepository leaguesRepository;
  const App({super.key, required this.leaguesRepository});
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: leaguesRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) =>
                  JoinBloc(leaguesRepository: leaguesRepository)),
        ],
        child: MaterialApp.router(
          routerConfig: _router,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            textTheme: TextTheme(
              bodyMedium: TextStyle(
                fontFamily: "Inter",
                fontSize: 15,
                color: Colors.white,
              ),
              bodyLarge: TextStyle(
                fontFamily: "Inter",
                fontSize: 20,
                color: Colors.white,
              ),
              headlineMedium: TextStyle(
                fontFamily: "Inter",
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            dropdownMenuTheme: DropdownMenuThemeData(
              inputDecorationTheme: InputDecorationTheme(
                filled: true,
                fillColor: const Color.fromARGB(77, 132, 156, 220),
              ),
            ),
            textSelectionTheme: TextSelectionThemeData(
              cursorColor: Colors.white,
              selectionColor: Color.fromARGB(255, 16, 23, 41),
              selectionHandleColor: Color.fromARGB(255, 16, 23, 41),
            ),
            iconTheme: IconThemeData(
              color: Colors.white,
            ),
            scaffoldBackgroundColor: const Color.fromARGB(255, 16, 23, 41),
            appBarTheme: const AppBarTheme(
              elevation: 0,
              centerTitle: true,
              backgroundColor: Color.fromARGB(255, 16, 23, 41),
              titleTextStyle: TextStyle(
                fontFamily: "Inter",
                fontWeight: FontWeight.w700,
                fontSize: 25.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
