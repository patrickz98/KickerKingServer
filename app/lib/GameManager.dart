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
    ChangeNotifier _listeners = ChangeNotifier();

    List<Game> all() => _games;

    void add(Game game)
    {
        _games.add(game);
        _listeners.notifyListeners();
    }

    void addListener(VoidCallback callback)
    {
        _listeners.addListener(callback);
    }

    void removeListener(VoidCallback callback)
    {
        _listeners.removeListener(callback);
    }
}