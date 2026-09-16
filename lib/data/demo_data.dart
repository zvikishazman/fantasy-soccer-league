import 'package:flutter/material.dart';

import '../domain/fantasy_team.dart';
import '../domain/player.dart';

const List<Player> demoPlayers = <Player>[
  Player(
    id: 'noam',
    name: 'Noam Cohen',
    position: PlayerPosition.goalkeeper,
    shirtColor: Color(0xFFF8FAFC),
    value: 12,
    cleanSheets: 1,
  ),
  Player(
    id: 'daniel',
    name: 'Daniel Levi',
    position: PlayerPosition.defender,
    shirtColor: Color(0xFF111827),
    value: 18,
    assists: 1,
    cleanSheets: 1,
  ),
  Player(
    id: 'lior',
    name: 'Lior Ben-David',
    position: PlayerPosition.midfielder,
    shirtColor: Color(0xFFDC2626),
    value: 24,
    goals: 1,
    assists: 1,
  ),
  Player(
    id: 'omer',
    name: 'Omer Azulay',
    position: PlayerPosition.forward,
    shirtColor: Color(0xFFFACC15),
    value: 25,
    goals: 2,
  ),
  Player(
    id: 'itai',
    name: 'Itai Mizrahi',
    position: PlayerPosition.forward,
    shirtColor: Color(0xFF2563EB),
    value: 20,
    assists: 2,
  ),
];

const FantasyTeam demoTeam = FantasyTeam(
  name: 'Ramat Gan United',
  manager: 'Zvi',
  players: demoPlayers,
  captainId: 'omer',
);

const List<Standing> demoStandings = <Standing>[
  Standing(
      rank: 1, team: 'Ramat Gan United', manager: 'Zvi', points: 126, trend: 1),
  Standing(
      rank: 2, team: 'Pressing FC', manager: 'Amit', points: 119, trend: -1),
  Standing(
      rank: 3, team: 'Sunday XI', manager: 'Daniel', points: 111, trend: 0),
  Standing(
      rank: 4, team: 'Golden Boots', manager: 'Omer', points: 103, trend: 1),
  Standing(rank: 5, team: 'High Line', manager: 'Noam', points: 96, trend: -1),
];
