import 'package:flutter/foundation.dart';

import 'player.dart';

@immutable
class FantasyTeam {
  const FantasyTeam({
    required this.name,
    required this.manager,
    required this.players,
    required this.captainId,
  });

  final String name;
  final String manager;
  final List<Player> players;
  final String captainId;

  int get budgetUsed =>
      players.fold(0, (int sum, Player player) => sum + player.value);
}

@immutable
class Standing {
  const Standing({
    required this.rank,
    required this.team,
    required this.manager,
    required this.points,
    required this.trend,
  });

  final int rank;
  final String team;
  final String manager;
  final int points;
  final int trend;
}
