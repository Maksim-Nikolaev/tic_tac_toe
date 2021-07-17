import 'package:flutter/material.dart';
import 'package:tic_tac_toe/src/screens/game_screen.dart';

class InitApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      theme: ThemeData(
        primarySwatch: Colors.blue,

      ),
      home: GameScreen(),
    );
  }
}
