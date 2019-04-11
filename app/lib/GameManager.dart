import 'package:flutter/material.dart';

class Game
{
    final List<String> winner;
    final List<String> looser;
    final int winnerPoints;
    final int looserPoints;
    final DateTime date;

    Game({
        @required this.winner,
        @required this.looser,
        @required this.winnerPoints,
        @required this.looserPoints,
        @required this.date,
    }) : assert(
        winner != null &&
        looser != null &&
        winner.length > 0 &&
        looser.length > 0 &&
        date != null &&
        winnerPoints > looserPoints &&
        looserPoints >= 0
    );

    Game.fromJson(Map<String, dynamic> json)
        : winner = json[ "winner" ],
          looser = json[ "looser" ],
          winnerPoints = json[ "winnerPoints" ],
          looserPoints = json[ "looserPoints" ],
          date = DateTime.fromMicrosecondsSinceEpoch(json[ "date" ]);

    Map<String, dynamic> toJson() =>
    {
        "winner": winner,
        "looser": looser,
        "winnerPoints": winnerPoints,
        "looserPoints": looserPoints,
        "date": date.millisecondsSinceEpoch,
    };
}

class GameManager
{
    List<Game> _games = [];

    List<Game> all() => _games;

    GameManager()
    {
        Game game1 = Game(
            winner: ["Patrick"],
            looser: ["Ole"],
            winnerPoints: 10,
            looserPoints: 9,
            date: DateTime.now(),
        );

        _games.add(game1);

        Game game2 = Game(
            winner: ["Patrick", "Daniel"],
            looser: ["Ole", "Thomas"],
            winnerPoints: 10,
            looserPoints: 5,
            date: DateTime.now(),
        );

        _games.add(game2);

        Game game3 = Game(
            winner: ["Daniel"],
            looser: ["Thomas"],
            winnerPoints: 10,
            looserPoints: 6,
            date: DateTime.now(),
        );

        _games.add(game3);
    }
}