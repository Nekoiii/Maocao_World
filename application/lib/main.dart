import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import 'theme/app_theme.dart';

import 'widgets/custom_button.dart';
import 'screens/home_page.dart';

void main() => runApp(MyApp());

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
