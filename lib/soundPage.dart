import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

void main() => runApp(SoundPage());

class SoundPage extends StatefulWidget {
  @override
  _SoundPage createState() => _SoundPage();
}

class _SoundPage extends State<SoundPage> {

  late AudioPlayer player;
  late AudioPlayer player2;

  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
    player2 = AudioPlayer();
  }

  @override
  void dispose() {
    player.dispose();
    player2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  await player.setAsset('assets/test2.mp3');
                  player.play();
                },
                child: Text('OK'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () async {
                  await player2.setAsset('assets/test.mp3');
                  player2.play();
                },
                child: Text('Bruh'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}