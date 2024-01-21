import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Audio Player'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () => audioPlayer
                .play('http://localhost:8000/static/audios/test-song-1.mp3'),
            // onPressed: () => audioPlayer
            //     .play('http://10.0.2.2:8000/static/audios/test-song-1.mp3'),
            child: Text('Play Audio ！'),
          ),
        ),
      ),
    );
  }
}
