import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mini_game_2/game/game_lib.dart';
import 'package:provider/provider.dart';
import 'package:mini_game_2/soundPage.dart';
import 'package:mini_game_2/game/size_provider.dart';


class MiniGameEngine extends GameEngine {
  Size? _gameViewSize;
  double _targetPositionX = 10.0;
  double _targetPositionY = 0.0;

  double get targetPosX => _targetPositionX;
  double get targetPosY => _targetPositionY;

  @override
  void stateChanged(GameState oldState, GameState newState) {
    if (newState == GameState.running) {
      _targetPositionX = 10.0;
      _targetPositionY = 0.0;
    }
  }

  @override
  void updatePhysicsEngine(int tickCounter) {
    _targetPositionY += 2;
    if (_gameViewSize!= null && _targetPositionY > _gameViewSize!.height) {
      _targetPositionY = -20.0;
    }
    notifyListeners();
  }

  void setGameViewSize(Size? size) {
    if (size != null) {
      _gameViewSize = size;
    }else{
      print('Oops');
    }
  }

}

class MiniGameView extends GameView {
  final MiniGameEngine gameEngine;
  final myController = TextEditingController();

  MiniGameView(String title, this.gameEngine) : super(title);

  @override
  Widget getStartPageContent(BuildContext context) {
    GameEngine engine = Provider.of<GameEngine>(context);
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget> [
        Align(
          alignment: Alignment.topCenter,
            child: Column(
              children: [
                SizedBox(height: 30),
                Text('ALIEN', textScaleFactor: 3),
                Text('INVADERS', textScaleFactor: 3),
                Container(
                  padding: EdgeInsets.only(top: 40),
                  width: 300.0,
                  child: Image.asset('assets/images/ufo.png'),
                ),
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
        )),

      ],
    );
  }

  @override
  Widget getRunningPageContent(BuildContext context) {
    return SizeProviderWidget(
        onChildSize: (size) {
          gameEngine.setGameViewSize(size);
        },
        child: Stack(
            children: [
              Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Time: ${gameEngine.tickCounter}'),
                        ElevatedButton(
                            child: Text('End Game'),
                            onPressed: () {
                              gameEngine.gameState = GameState.endOfGame;
                            })
                      ]
                  )
              ),
              Positioned(
                top: gameEngine.targetPosY,
                left: gameEngine.targetPosX,
                child: Container(
                  color: Colors.red,
                  child: SizedBox(
                    height: 20,
                    width: 20,
                  )
                ),
              )
            ]
        )
    );
  }
/**
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
    */

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