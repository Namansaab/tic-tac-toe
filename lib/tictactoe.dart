import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class TicTacToe extends StatefulWidget {
  const TicTacToe({Key? key}) : super(key: key);

  @override
  State<TicTacToe> createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  // final navigatorKey = GlobalKey<NavigatorState>();
  var _boardState = List.filled(9, TileState.EMPTY);
  var _currentTurn = TileState.CROSS;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "TicTaeToe",
          style: TextStyle(fontSize: 30),
        ),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(100, 20, 200, 0.5),
      ),
      drawer: Drawer(
        child: ListView(padding: EdgeInsets.zero, children: <Widget>[
          const DrawerHeader(
            child: Center(
              child: Text(
                "Developers",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
              ),
            ),
            decoration: BoxDecoration(
              color: Color.fromRGBO(100, 20, 200, 0.5),
              // image: DecorationImage(
              //           image: AssetImage("Namanpic.jpeg"),
              //              fit: BoxFit.cover)
            ),
          ),
          ListTile(
            minVerticalPadding: 2,
            contentPadding: EdgeInsets.all(6),
            leading: CircleAvatar(
              // child: Image.asset('assets/images/naman1.jpeg',fit: BoxFit.fill,),
              radius: 16.0,
              child: ClipRRect(
                child: Image.asset('assets/images/naman2.jpeg'),
                borderRadius: BorderRadius.circular(50.0),
              ),
            ),
            title: const Text('Naman Jain'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const Divider(
            thickness: 3,
          ),
          // ListTile(
          //   minVerticalPadding: 2,
          //   contentPadding: EdgeInsets.all(6),
          //   leading: CircleAvatar(
          //     // child: Image.asset('assets/images/naman1.jpeg',fit: BoxFit.fill,),
          //     radius: 16.0,
          //     child: ClipRRect(
          //       child: Image.asset('assets/images/bhavnoor1.jpeg'),
          //       borderRadius: BorderRadius.circular(50.0),
          //     ),
          //   ),
          //   title: const Text('Bhavnoor Kaur'),
          //   onTap: () {
          //     Navigator.pop(context);
          //   },
          // ),
          // const Divider(
          //   thickness: 3,
          // ),
          // ListTile(
          //   minVerticalPadding: 2,
          //   contentPadding: EdgeInsets.all(6),
          //   leading: CircleAvatar(
          //     // child: Image.asset('assets/images/naman1.jpeg',fit: BoxFit.fill,),
          //     radius: 16.0,
          //     child: ClipRRect(
          //       child: Image.asset('assets/images/simran1.jpeg'),
          //       borderRadius: BorderRadius.circular(50.0),
          //     ),
          //   ),
          //   title: const Text('Simran Garg'),
          //   onTap: () {
          //     Navigator.pop(context);
          //   },
          // ),
          ListTile(
            minVerticalPadding: 2,
            contentPadding: EdgeInsets.all(6),
            leading: CircleAvatar(
              // child: Image.asset('assets/images/naman1.jpeg',fit: BoxFit.fill,),
              radius: 16.0,
              child: ClipRRect(
                child: Image.asset('assets/images/rahul.jpeg'),
                borderRadius: BorderRadius.circular(50.0),
              ),
            ),
            title: const Text('Rahul Arya'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const Divider(
            thickness: 3,
          ),
          ListTile(
            minVerticalPadding: 2,
            contentPadding: EdgeInsets.all(6),
            leading: CircleAvatar(
              // child: Image.asset('assets/images/naman1.jpeg',fit: BoxFit.fill,),
              radius: 16.0,
              child: ClipRRect(
                child: Image.asset('assets/images/jivesh.jpeg'),
                borderRadius: BorderRadius.circular(50.0),
              ),
            ),
            title: const Text('Jivesh Nanda'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const Divider(
            thickness: 3,
          ),
          // ListTile(
          //   contentPadding: EdgeInsets.all(6),
          //   minVerticalPadding: 2,
          //   leading: CircleAvatar(
          //     // child: Image.asset('assets/images/naman1.jpeg',fit: BoxFit.fill,),
          //     radius: 16.0,
          //     child: ClipRRect(
          //       child: Image.asset('assets/images/arman1.jpeg'),
          //       borderRadius: BorderRadius.circular(50.0),
          //     ),
          //   ),
          //   title: const Text('Armaan Noor Singh Brar'),
          //   onTap: () {
          //     Navigator.pop(context);
          //   },
          // ),
          // const Divider(
          //   thickness: 3,
          // ),
          // ListTile(
          //   title: const Text('Item 2'),
          //   onTap: () {
          //     Navigator.pop(context);
          //   },
          // ),
        ]),
      ),
      body: Center(
        child: Stack(
          children: [
            Image.asset(
              'assets/images/board.png',
              fit: BoxFit.fitWidth,
            ),
            _boardTiles(),
          ],
        ),
      ),
    );
  }

  Widget _boardTiles() {
    return Builder(builder: (context) {
      final boardDimension = MediaQuery.of(context).size.width;
      final tileDimension = boardDimension / 3;
      return Container(
        width: boardDimension,
        height: boardDimension,
        child: Column(
          children: chunk(_boardState, 3).asMap().entries.map((entry) {
            final chunkIndex = entry.key;
            final tileStateChunk = entry.value;
            return Row(
              children: tileStateChunk.asMap().entries.map((innerEntry) {
                final innerIndex = innerEntry.key;
                final tileState = innerEntry.value;
                final tileIndex = (chunkIndex * 3) + innerIndex;
                return BoardTile(
                    dimension: tileDimension,
                    tileState: tileState,
                    onPressed: () => _updateTileStateForIndex(tileIndex));
              }).toList(),
            );
          }).toList(),
        ),
      );
    });
  }

  void _updateTileStateForIndex(int selectedIndex) {
    if (_boardState[selectedIndex] == TileState.EMPTY) {
      setState(() {
        _boardState[selectedIndex] = _currentTurn;
        _currentTurn = _currentTurn == TileState.CROSS
            ? TileState.CIRCLE
            : TileState.CROSS;
      });
      final winner = _findWinner();
      if (winner != null) {
        // print(winner);
        _showWinnerDialog(winner);
      }
      ;
      final tie = _findTie();
      if (tie != null && winner == null) {
        _showTie();
      }
    }
  }

  TileState? _findWinner() {
    // ignore: prefer_function_declarations_over_variables
    TileState? Function(int, int, int) winnerForMatch = (a, b, c) {
      if (_boardState[a] != TileState.EMPTY) {
        if ((_boardState[a] == _boardState[b]) &&
            (_boardState[b] == _boardState[c])) {
          return _boardState[a];
        }
      }
      return null;
    };
    final checks = [
      winnerForMatch(0, 1, 2),
      winnerForMatch(3, 4, 5),
      winnerForMatch(6, 7, 8),
      winnerForMatch(0, 3, 6),
      winnerForMatch(1, 4, 7),
      winnerForMatch(2, 5, 8),
      winnerForMatch(0, 4, 8),
      winnerForMatch(2, 4, 6),
    ];
    TileState? winner;
    for (int i = 0; i < checks.length; i++) {
      if (checks[i] != null) {
        winner = checks[i];
        break;
      }
    }
    return winner;
  }

  int? _findTie() {
    for (int i = 0; i < 9; i++) {
      if (_boardState[i] == TileState.EMPTY) {
        return null;
      }
    }
    return 1;
  }

  void _showTie() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return AlertDialog(
            title: const Text('Game Tie'),
            actions: [
              TextButton(
                  onPressed: () {
                    _resetGame();
                    Navigator.of(context).pop();
                  },
                  child: const Text('New Game'))
            ],
          );
        });
  }

  void _showWinnerDialog(TileState tileState) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return AlertDialog(
            title: const Text('Winner'),
            content: Image.asset(tileState == TileState.CROSS
                ? 'assets/images/x.png'
                : 'assets/images/o.png'),
            actions: [
              TextButton(
                  onPressed: () {
                    _resetGame();
                    Navigator.of(context).pop();
                  },
                  child: Text('New Game'))
            ],
          );
        });
  }

  void _resetGame() {
    setState(() {
      _boardState = List.filled(9, TileState.EMPTY);
      _currentTurn = TileState.CROSS;
    });
  }
}

enum TileState { EMPTY, CROSS, CIRCLE }

List<List<TileState>> chunk(List<TileState> list, int size) {
  return List.generate(
      (list.length / size).ceil(),
      (index) =>
          list.sublist(index * size, min(index * size + size, list.length)));
}

class BoardTile extends StatelessWidget {
  final TileState tileState;
  final double dimension;
  final VoidCallback onPressed;
  const BoardTile(
      {Key? key,
      required this.dimension,
      required this.tileState,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: dimension,
      height: dimension,
      child: TextButton(
        onPressed: onPressed,
        child: _widgetForTileState(),
      ),
    );
  }

  Widget _widgetForTileState() {
    Widget widget;
    switch (tileState) {
      case TileState.EMPTY:
        {
          widget = Container();
        }
        break;
      case TileState.CROSS:
        {
          widget = Image.asset('assets/images/x.png');
        }
        break;
      case TileState.CIRCLE:
        {
          widget = Image.asset('assets/images/o.png');
        }
        break;
    }
    return widget;
  }
}
