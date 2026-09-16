import 'fantasy_team.dart';
import 'player.dart';

class ScoringService {
  const ScoringService();

  static const int goalPoints = 2;
  static const int assistPoints = 1;
  static const int cleanSheetPoints = 1;
  static const int captainMultiplier = 2;

  int playerPoints(Player player, {bool isCaptain = false}) {
    final int points = player.goals * goalPoints +
        player.assists * assistPoints +
        player.cleanSheets * cleanSheetPoints;
    return isCaptain ? points * captainMultiplier : points;
  }

  int teamPoints(FantasyTeam team) {
    return team.players.fold(
      0,
      (int total, Player player) =>
          total + playerPoints(player, isCaptain: player.id == team.captainId),
    );
  }
}
