import 'package:flutter/material.dart';
import 'package:tic_tac_toe/src/helpers/classes/board.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  Board board = Board.empty();
  int cells = 3;

  void placeRandom() {
    if (!board.isSolved) {
      setState(() {
        board.placeAtRandomPosition();
      });
    }
  }

  void placeSymbol(int index) {
    if (!board.isSolved)
      setState(() {
        try {
          board.placeSymbol(index);
        } catch (e) {
          print(e);
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    final Size deviceSize = MediaQuery.of(context).size;
    final double deviceWidth = deviceSize.width;
    final double deviceHeight = deviceSize.height;
    final double shortestSide = deviceSize.shortestSide;
    final double longestSide = deviceSize.longestSide;

    final double widthBlock = deviceWidth * 0.01;
    final double heightBlock = deviceHeight * 0.01;
    final double shortestBlock = shortestSide * 0.01;
    final double longestBlock = longestSide * 0.01;

    final MapEntry<Symbol, List<int>> winner = board.checkWinner();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic Tac Toe'),
        brightness: Brightness.light,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: longestSide > 1400
                ? shortestBlock * 66
                : longestSide > 1000
                    ? shortestBlock * 75
                    : shortestSide,
            height: longestSide > 1400
                ? shortestBlock * 66
                : longestSide > 1000
                    ? shortestBlock * 75
                    : shortestSide,
            child: GridView.builder(
              padding: EdgeInsets.all(8),
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: board.cells,
                mainAxisSpacing: widthBlock * 6 / board.cells,
                crossAxisSpacing: widthBlock * 6 / board.cells,
              ),
              itemBuilder: (BuildContext context, int index) {
                Color containerColor = board.board[index] == Symbol.Empty
                    ? Colors.grey
                    : Colors.grey.shade300;

                if (winner.key != Symbol.Empty) {
                  if (winner.value.contains(index)) {
                    containerColor = Colors.green;
                  }
                }

                return InkWell(
                  onTap: () {
                    placeSymbol(index);
                  },
                  child: AnimatedContainer(
                    key: Key('$index'),
                    duration: Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                    color: containerColor,
                    child: board.board[index] == Symbol.Empty
                        ? Container()
                        : FittedBox(
                            child: Text(
                              '${symbolToString(board.board[index]!)}',
                              // style: TextStyle(fontSize: ),
                            ),
                          ),
                  ),
                );
              },
              itemCount: board.maxCells,
            ),
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  if (cells > 2)
                    setState(() {
                      cells--;
                      board = Board.empty(cells);
                    });
                },
                icon: const Icon(Icons.remove_circle_outline),
              ),
              Text(
                "$cells",
                style: TextStyle(fontSize: 24),
              ),
              IconButton(
                onPressed: () {
                  if (cells < 50)
                    setState(() {
                      cells++;
                      board = Board.empty(cells);
                    });
                },
                icon: const Icon(Icons.add_circle_outline),
              ),
            ],
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    board = Board.empty(cells);
                  });
                },
                icon: const Icon(Icons.refresh),
              ),
              Text(
                "${symbolToString(board.getCurrentSymbol)}",
                style: TextStyle(fontSize: 24),
              ),
              IconButton(
                onPressed: placeRandom,
                icon: const Icon(Icons.shuffle),
              ),
            ],
          ),
          Spacer(),
        ],
      ),
    );
  }
}
