import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'game/game_lib.dart';
import 'minigame.dart';

void main() {
  Game game = Game(MiniGameView('Mini Game'), MiniGameEngine());
  runApp(MyApp(game));
}

class MyApp extends StatelessWidget {
  final Game game;

  MyApp(this.game);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(value: game.gameEngine,
        child: MaterialApp(
            title: game.gameView.title,
            theme: ThemeData(
              primarySwatch: Colors.green,
              scaffoldBackgroundColor: Colors.grey,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: game.gameView));
  }
}