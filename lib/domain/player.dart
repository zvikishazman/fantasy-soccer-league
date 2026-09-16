import 'package:flutter/material.dart';

enum PlayerPosition { goalkeeper, defender, midfielder, forward }

@immutable
class Player {
  const Player({
    required this.id,
    required this.name,
    required this.position,
    required this.shirtColor,
    required this.value,
    this.goals = 0,
    this.assists = 0,
    this.cleanSheets = 0,
  });

  final String id;
  final String name;
  final PlayerPosition position;
  final Color shirtColor;
  final int value;
  final int goals;
  final int assists;
  final int cleanSheets;

  String get positionLabel => switch (position) {
    PlayerPosition.goalkeeper => 'GK',
    PlayerPosition.defender => 'DEF',
    PlayerPosition.midfielder => 'MID',
    PlayerPosition.forward => 'FWD',
  };

  Player copyWith({int? goals, int? assists, int? cleanSheets}) {
    return Player(
      id: id,
      name: name,
      position: position,
      shirtColor: shirtColor,
      value: value,
      goals: goals ?? this.goals,
      assists: assists ?? this.assists,
      cleanSheets: cleanSheets ?? this.cleanSheets,
    );
  }
}
