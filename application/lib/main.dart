import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import 'theme/app_theme.dart';

import 'screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Maocao World',
      theme: AppTheme.lightTheme,
      home: HomePage(),
    );
  }
}
