import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'game/game_lib.dart';
import 'minigame.dart';

void main() {
  var gameEngine= MiniGameEngine();
  Game game = Game(MiniGameView('Mini Game', gameEngine), MiniGameEngine());
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
              brightness: Brightness.dark,
              primaryColor: Colors.blue[900],
              primarySwatch: Colors.yellow,
              scaffoldBackgroundColor: Colors.blue[900],

              fontFamily: 'Robotic',

              textTheme: TextTheme(
                /** Font-Color **/
              ),

              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: game.gameView));
  }
}