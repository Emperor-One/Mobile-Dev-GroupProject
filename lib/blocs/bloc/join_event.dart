part of 'join_bloc.dart';

@immutable
abstract class JoinEvent extends Equatable {
  const JoinEvent();

  @override
  List<Object> get props => [];
}

class InitialEvent extends JoinEvent {
  const InitialEvent();

  @override
  List<Object> get props => [];
}

class JoinButtonPressed extends JoinEvent {
  final int leagueId;

  const JoinButtonPressed(this.leagueId);

  @override
  List<Object> get props => [leagueId];
}

class JoinPrivateLeague extends JoinEvent {
  final int leagueId;
  final String entryCode;

  const JoinPrivateLeague(this.leagueId, this.entryCode);

  @override
  List<Object> get props => [leagueId, entryCode];
}

class AddingPlayer extends JoinEvent {
  final int leagueId;
  final String playerPosition;

  const AddingPlayer(this.leagueId, this.playerPosition);

  @override
  List<Object> get props => [leagueId, playerPosition];
}

class SelectPlayer extends JoinEvent {
  final int playerId;

  const SelectPlayer(this.playerId);

  @override
  List<Object> get props => [playerId];
}

class PlayerInfoPressed extends JoinEvent {
  final int playerId;
  final String playerName;
  final String position;

  const PlayerInfoPressed(this.playerId, this.playerName, this.position);

  @override
  List<Object> get props => [playerId, playerName, position];
}

class AddAndJoin extends JoinEvent {
  String captain;
  AddAndJoin(this.captain);

  @override
  List<Object> get props => [captain];
}
