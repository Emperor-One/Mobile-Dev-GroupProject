import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../repository/leagues_repository.dart';

part 'join_event.dart';
part 'join_state.dart';

class JoinBloc extends Bloc<JoinEvent, JoinState> {
  final LeaguesRepository leaguesRepository;

  JoinBloc({required this.leaguesRepository}) : super(JoinInitial()) {
    // on<InitialEvent>((event, emit) {});
    on<JoinButtonPressed>((event, emit) async {
      if (state is JoinInitial || state is JoinedState) {
        await Future.delayed(Duration(seconds: 1));
        emit(AddLeagueState(
            private: 0,
            entryCode: "",
            leagueId: event.leagueId,
            playerId: 0,
            position: "",
            selected: [0, 0, 0, 0, 0]));
      } else if (state is AddLeagueState || state is PlayersState) {
        await Future.delayed(Duration(seconds: 1));
        emit(AddLeagueState(
            private: 0,
            entryCode: "",
            leagueId: event.leagueId,
            playerId: 0,
            position: "",
            selected: [0, 0, 0, 0, 0]));
      }
    });
    on<AddingPlayer>((event, emit) {
      if (state is AddLeagueState) {
        final state = this.state as AddLeagueState;
        emit(PlayersState(
            entryCode: state.entryCode,
            private: state.private,
            playerId: state.playerId,
            playerName: "",
            leagueId: state.leagueId,
            position: event.playerPosition,
            selected: state.selected));
        // leagueID: state.leagueID,
        // playerIDs: List.from(state.playerIDs)..add(event.playerId)));
      }
    });

    on<SelectPlayer>((event, emit) {
      if (state is PlayersState) {
        final state = this.state as PlayersState;
        int index = 0;
        switch (state.position) {
          case "GK":
            index = 0;
            break;

          case "Reserve":
            index = 1;
            break;

          case "Back":
            index = 2;
            break;

          case "Midfield":
            index = 3;
            break;

          case "Forward":
            index = 4;
            break;
        }

        state.selected[index] = event.playerId;
        emit(AddLeagueState(
            entryCode: state.entryCode,
            private: state.private,
            leagueId: state.leagueId,
            playerId: event.playerId,
            position: state.position,
            selected: state.selected));
      }
    });
    on<PlayerInfoPressed>((event, emit) {
      if (state is PlayersState) {
        final state = this.state as PlayersState;
        emit(PlayersState(
          entryCode: state.entryCode,
          private: state.private,
          leagueId: state.leagueId,
          playerId: event.playerId,
          playerName: event.playerName,
          position: state.position,
          selected: state.selected,
        ));
      }
    });

    on<AddAndJoin>((event, emit) async{
      if (state is AddLeagueState) {
        final state = this.state as AddLeagueState;
        await leaguesRepository.joinLeague(state.leagueId, event.captain, state.entryCode, state.selected);
        emit(JoinedState(leagueId: state.leagueId));
      }
    });

    on<JoinPrivateLeague>((event, emit) {
      if (state is JoinInitial || state is JoinedState) {
        emit(AddLeagueState(
            entryCode: event.entryCode,
            private: 1,
            leagueId: event.leagueId,
            playerId: 0,
            position: "",
            selected: [0, 0, 0, 0, 0]));
      }
    });
  }
}
