import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'game/game_lib.dart';
import 'package:provider/provider.dart';
import 'package:mini_game_2/soundPage.dart';


class MiniGameEngine extends GameEngine {
  @override
  void stateChanged(GameState oldState, GameState newState) {
    // do nothing
  }

  @override
  void updatePhysicsEngine(int tickCounter) {
    notifyListeners();
  }
}

class MiniGameView extends GameView {
  final myController = TextEditingController();

  MiniGameView(String title) : super(title);

  @override
  Widget getStartPageContent(BuildContext context) {
    GameEngine engine = Provider.of<GameEngine>(context);
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('ALIEN', textScaleFactor: 5),
            Text('INVADERS', textScaleFactor: 5),
            Image.asset('assets/images/ufo.png'),
            Container(
              width: 300.0,
              height: 100.0,
              child: TextField(
                controller: myController,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter your username',
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () => { engine.gameState = GameState.running },
                child: Text('Start game')
            )
          ],
        )
    );
  }

  @override
  Widget getRunningPageContent(BuildContext context) {
    GameEngine engine = Provider.of<GameEngine>(context);

    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("USERNAME"),
            Image.asset('assets/images/alien.png'),
            Text('time ${engine.tickCounter}', textScaleFactor: 2.5, ),
            ElevatedButton(
                onPressed: () => {print("Ume")},
                child: Text ('Sound!!!')
            ),
            ElevatedButton(
              onPressed: () => { engine.gameState = GameState.endOfGame },
              child: Text ('End game')
            ),
          ],
        ));
  }

  @override
  Widget getEndOfGamePageContent(BuildContext context) {
    GameEngine engine = Provider.of<GameEngine>(context);
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('GAME', textScaleFactor: 5),
              Text('OVER', textScaleFactor: 5),
              Container(
              width: 300.0,
                child:
                Image.asset('assets/images/alien.png'),
              ),
              ElevatedButton(
                  onPressed: () => { engine.gameState = GameState.running},
                  child: Text('Play again')),
              ElevatedButton(
                  onPressed: () => { engine.gameState = GameState.waitForStart },
                  child: Text('Back to Startpage')
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SoundPage()));
                  },
                  child: Text('SoundPage'))
            ]
        )
    );
  }
}