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

  test('calculates a team total with exactly one captain bonus', () {
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

  test('scores a complete five-player squad including an inactive player', () {
    final List<Player> squad = <Player>[
      player,
      for (int i = 2; i <= 4; i++)
        Player(
          id: '$i',
          name: 'Player $i',
          position: PlayerPosition.forward,
          shirtColor: Colors.white,
          value: 20,
          goals: 1,
        ),
      const Player(
        id: '5',
        name: 'Inactive player',
        position: PlayerPosition.goalkeeper,
        shirtColor: Colors.blue,
        value: 20,
      ),
    ];
    expect(
      scoring.teamPoints(
        FantasyTeam(
          name: 'Five',
          manager: 'Manager',
          players: squad,
          captainId: '1',
        ),
      ),
      18,
    );
    expect(scoring.playerPoints(squad.last, isCaptain: true), 0);
  });
}
