import 'package:flutter/material.dart';
import 'package:tic_tac_toe/src/helpers/classes/board.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  Board board = Board.empty();
  int cells = 3;

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
    final double widthBlock = MediaQuery.of(context).size.width * 0.01;
    final MapEntry<Symbol, List<int>> winner = board.checkWinner();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic Tac Toe'),
        brightness: Brightness.light,
      ),
      body: SizedBox.expand(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 10,
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
                Expanded(
                  flex: 3,
                  child: IconButton(
                    onPressed: () {
                      if (cells > 1)
                        setState(() {
                          cells--;
                          board = Board.empty(cells);
                        });
                    },
                    icon: const Icon(Icons.remove_circle_outline),
                  ),
                ),
                Expanded(child: FittedBox(child: Text("$cells"))),
                Expanded(
                  flex: 3,
                  child: IconButton(
                    onPressed: () {
                      if (cells < 50)
                        setState(() {
                          cells++;
                          board = Board.empty(cells);
                        });
                    },
                    icon: const Icon(Icons.add_circle_outline),
                  ),
                ),
              ],
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 3,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        board = Board.empty(cells);
                      });
                    },
                    icon: const Icon(Icons.refresh),
                  ),
                ),
                Expanded(
                  child: FittedBox(
                    child: Text(
                      "${symbolToString(board.getCurrentSymbol)}",
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        board.placeAtRandomPosition();
                      });
                    },
                    icon: const Icon(Icons.add),
                  ),
                ),
              ],
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
