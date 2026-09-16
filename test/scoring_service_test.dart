import 'package:fantasy_soccer_league/domain/fantasy_team.dart';
import 'package:fantasy_soccer_league/domain/player.dart';
import 'package:fantasy_soccer_league/domain/scoring_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const ScoringService scoring = ScoringService();
  const Player player = Player(
    id: '1',
    name: 'Test Player',
    position: PlayerPosition.midfielder,
    shirtColor: Colors.red,
    value: 20,
    goals: 2,
    assists: 1,
    cleanSheets: 1,
  );

  test('calculates the original product scoring rules', () {
    expect(scoring.playerPoints(player), 6);
  });

  test('doubles the captain score', () {
    expect(scoring.playerPoints(player, isCaptain: true), 12);
  });

  test('calculates a five-player team total', () {
    const Player teammate = Player(
      id: '2',
      name: 'Second Player',
      position: PlayerPosition.defender,
      shirtColor: Colors.white,
      value: 15,
      goals: 1,
    );
    const FantasyTeam team = FantasyTeam(
      name: 'Test XI',
      manager: 'Manager',
      players: <Player>[player, teammate],
      captainId: '1',
    );

    expect(scoring.teamPoints(team), 14);
  });
}
