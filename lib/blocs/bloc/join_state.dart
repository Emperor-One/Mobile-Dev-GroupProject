part of 'join_bloc.dart';

@immutable
abstract class JoinState extends Equatable {
  const JoinState();

  @override
  List<Object> get props => [];
}

class JoinInitial extends JoinState {}

class AddLeagueState extends JoinState {
  final String leagueName;
  final bool isCreated;
  final String entryCode;
  final int private;
  final int leagueId;
  final int playerId;
  final String position;
  final List<int> selected;

  const AddLeagueState(
      {required this.leagueName,
      required this.isCreated,
      required this.entryCode,
      required this.private,
      required this.leagueId,
      required this.playerId,
      required this.position,
      required this.selected});

  @override
  List<Object> get props => [
        leagueName,
        isCreated,
        entryCode,
        private,
        leagueId,
        playerId,
        position,
        selected
      ];
}

class JoinedState extends JoinState {
  final int leagueId;

  const JoinedState({required this.leagueId});

  @override
  List<Object> get props => [leagueId];
}

class PlayersState extends JoinState {
  final String leagueName;
  final bool isCreated;
  final String entryCode;
  final int private;
  final int leagueId;
  final int playerId;
  final String playerName;
  final String position;
  final List<int> selected;

  const PlayersState(
      {required this.leagueName,
        required this.isCreated,
      required this.entryCode,
      required this.private,
      required this.leagueId,
      required this.playerId,
      required this.playerName,
      required this.position,
      required this.selected});

  @override
  List<Object> get props => [
        leagueName,
        isCreated,
        entryCode,
        private,
        leagueId,
        playerId,
        playerName,
        position,
        selected
      ];
}
