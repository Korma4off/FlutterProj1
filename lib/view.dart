import 'package:flutter/material.dart';

import 'game.dart';

class GameView extends StatefulWidget {
  GameView(this.parent);

  GameState parent;

  @override
  State<GameView> createState() => GameViewState(parent);
}

class GameViewState extends State<GameView> {
  final List<IconData> _icons = [Icons.play_arrow, Icons.pause];
  GameViewState(this.parent);
  String _gameStatus = '';
  GameState parent;

  @override
  Widget build(BuildContext context) {
    parent.addGameState(this);
    return Scaffold(
        appBar: AppBar(
            title: Text(_gameStatus),
        ),
        body: Center(child: body()),
        backgroundColor: Colors.grey,
        floatingActionButton: FloatingActionButton(
          onPressed: () => pauseButton(),
          child: Icon(_icons[parent.getPause() ? 0 : 1]),
        ),
      );
  }

  Widget body() {
    return Container(
      width: 400,
      height: 400,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 10),
        itemCount: 100,
        itemBuilder: (context, index) => Cell(parent, index)
      ),
    );
  }

  void appBarCheck() => setState(() { _gameStatus = parent.gameCheck() ? "Game end" : "";});
  void pauseButton() => setState(() { parent.setPause();});
}

class Cell extends StatefulWidget {
  Cell(this.parent, this.index);
  GameState parent;
  int index;

  @override
  State<Cell> createState() => CellState(parent, index);
}

class CellState extends State<Cell> {
  CellState(this.parent, this.index);

  GameState parent;
  int index;

  List<Color> _colors = [Colors.white, Colors.red];
  bool _alive = false;

  bool alive() => _alive;

  void changeColor() => setState(() { _alive = !_alive; });

  @override
  Widget build(BuildContext context) {
    parent.addCell(this, index);
    return FloatingActionButton(
      onPressed: changeColor,
      backgroundColor: _colors[_alive ? 1 : 0],
    );
  }
}

