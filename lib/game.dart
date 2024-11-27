import 'dart:async';

import 'package:flutter/material.dart';
import 'package:untitled/view.dart';


class Game extends StatefulWidget {
  const Game({super.key});

  @override
  State<Game> createState() => GameState();
}

class GameState extends State<Game> {
  GameViewState? _gameState;
  void addGameState(GameViewState state) => _gameState = state;

  Map<int, CellState> _cells = {};
  void addCell(CellState cell, int index) => _cells[index] = cell;

  bool _pause = true;
  bool getPause() => _pause;
  bool setPause() => _pause = !_pause;

  @override
  Widget build(BuildContext context) => MaterialApp(home: GameView(this));

  void initState() {
    startGame();
    super.initState();
  }

  void startGame() {
    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if(!_pause){
        updateGame();
      }
    });
  }

  void updateGame() {
    List<int> l = [1, -1, 9, -9, 10, -10, 11, -11];
    List<int> changed = [];
    for(int i = 0; i < _cells.length; i++){
      int count   = 0;
      for(int j = 0; j < l.length; j++){
        int index = i + l[j];
        if (index > _cells.length - 1) index -= _cells.length;
        if (index < 0) index += _cells.length;
        if(_cells[index]!.alive()) count++;
      }
      if((_cells[i]!.alive() && (count < 3 || count > 4)) || (!_cells[i]!.alive() && count > 2)) changed.add(i);
    }
    for(int i = 0; i < changed.length; i++) _cells[changed[i]]!.changeColor();
    _gameState!.appBarCheck();
  }

  bool gameCheck(){
    bool full = true;
    bool empty = true;

    for(int i = 0; i < _cells.length; i++) {
      full &= _cells[i]!.alive();
      empty &= !_cells[i]!.alive();
    }

    return full || empty;
  }
}

