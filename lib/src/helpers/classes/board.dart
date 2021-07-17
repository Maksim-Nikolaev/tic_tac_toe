import 'dart:math' show sqrt, Random;

class Board {
  /// Create an Empty Board 3x3
  Board.empty([this.cells = 3])
      : board = Map.fromEntries(
          List.generate(
            cells * cells,
            (index) => MapEntry(index, Symbol.Empty),
          ),
        ),
        turns = <Turn>[];

  /// Generate the board from given JSON
  Board.fromJson(Map<String, dynamic> json)
      : board = json['board'],
        turns = json['turns'],
        cells = json['cells'] ?? sqrt((json['board'] as Map).length);

  /// 2D N * N field (where N - amount of cells in a row / table)
  /// 0 1 2
  /// 3 4 5
  /// 6 7 8
  final Map<int, Symbol> board;

  /// Track all the turns
  final List<Turn> turns;

  /// Amount of cells in a row / table
  final int cells;

  int get maxCells => this.cells * this.cells;

  /// Get the list of available positions where we can place new Symbol
  List<int> get getAvailablePositions => this
      .board
      .entries
      .where((element) => element.value == Symbol.Empty)
      .map((e) => e.key)
      .toList();

  /// Get current active symbol.
  /// If first turn: Symbol.X
  /// If not first turn: Check the previous symbol and set to another
  Symbol get getCurrentSymbol => this.turns.isEmpty
      ? Symbol.X
      : this.turns.last.symbol == Symbol.X
          ? Symbol.O
          : Symbol.X;

  /// Place current active Symbol at random position
  void placeAtRandomPosition() {
    // Check to make sure game is not exceeded over 9 turns
    if (turns.length < this.maxCells) {
      List<int> emptyPositions = this.getAvailablePositions;
      int randomPosition = emptyPositions[Random().nextInt(
        emptyPositions.length,
      )];

      this.placeSymbol(randomPosition);
    }
  }

  /// Place current active Symbol at given position
  void placeSymbol(int position) {
    if (turns.length > this.maxCells) {
      throw Exception("Too many turns: ${turns.length}");
    }

    if (position < 0) {
      throw Exception("Position can't be less than 0: $position");
    }

    if (position >= this.maxCells) {
      throw Exception(
        "Position should be less than ${this.maxCells}: $position",
      );
    }

    if (this.board[position] != Symbol.Empty) {
      throw Exception(
        "Selected cell is not empty: $position ${symbolToString(this.board[position]!)}",
      );
    }

    final Symbol currentSymbol = this.getCurrentSymbol;

    this.board[position] = currentSymbol;
    this.turns.add(Turn(position, currentSymbol));
  }

  void printFullBoard() {
    final List<Symbol> symbols = this.board.values.toList();

    for (int i = 0; i < this.cells; i++) {
      print(
        symbols
            .sublist(i * this.cells, (i + 1) * this.cells)
            .toList()
            .map(symbolToString),
      );
    }
  }

  bool get isSolved => this.checkWinner().key != Symbol.Empty;

  MapEntry<Symbol, List<int>> checkWinner() {
    for (int i = 0; i < cells; i++) {
      MapEntry<Symbol, List<int>> winnerColumn = checkColumn(i);
      MapEntry<Symbol, List<int>> winnerRow = checkRow(i);
      MapEntry<Symbol, List<int>> winnerDiagonals = checkDiagonals();

      if (winnerColumn.key != Symbol.Empty) return winnerColumn;
      if (winnerRow.key != Symbol.Empty) return winnerRow;
      if (winnerDiagonals.key != Symbol.Empty) return winnerDiagonals;
    }

    return MapEntry<Symbol, List<int>>(Symbol.Empty, []);
  }

  MapEntry<Symbol, List<int>> checkRow(int row) {
    final int startingPosition = row * cells; // 0, 3, 6 etc

    Symbol winningSymbol = Symbol.Empty;

    if (row < 0 || startingPosition > maxCells) {
      throw Exception("Row out of length");
    }


    if (this.board[startingPosition] == Symbol.Empty) {
      return MapEntry(winningSymbol, []);
    }

    // Starting position for the row
    final List<Symbol> rowSymbols = [];
    final List<int> indexes = [];

    // Row values are [0, 1, 2], [3, 4, 5], [6, 7, 8] etc
    for (int i = startingPosition; i < startingPosition + cells; i++) {
      indexes.add(i);
      rowSymbols.add(this.board.values.elementAt(i));
    }

    winningSymbol = checkWinningSymbol(rowSymbols);
    if (winningSymbol == Symbol.Empty) {
      indexes.clear();
    }

    return MapEntry(winningSymbol, indexes);
  }

  MapEntry<Symbol, List<int>> checkColumn(int column) {
    Symbol winningSymbol = Symbol.Empty;
    if (column < 0 || column > cells) {
      throw Exception("Row out of length");
    }

    if (this.board[column] == Symbol.Empty) {
      return MapEntry(winningSymbol, []);
    }

    // Starting position for the column
    final List<Symbol> columnSymbols = [];
    final List<int> indexes = [];

    // Column symbols are at [0, 3, 6], [1, 4, 7], [2, 5, 8] etc
    for (int i = column; i < maxCells; i = i + cells) {
      indexes.add(i);
      columnSymbols.add(this.board.values.elementAt(i));
    }

    winningSymbol = checkWinningSymbol(columnSymbols);
    if (winningSymbol == Symbol.Empty) {
      indexes.clear();
    }
    return MapEntry(winningSymbol, indexes);
  }

  MapEntry<Symbol, List<int>> checkDiagonals() {
    Symbol winningSymbol = Symbol.Empty;

    final List<int> indexes = [];
    // Top-Left diagonal
    if (this.board.values.elementAt(0) != Symbol.Empty) {
      final List<int> indexes = [];
      final List<Symbol> topLeftDiagonalSymbols = [];

      for (int i = 0; i < maxCells; i = i + cells + 1) {
        indexes.add(i);
        topLeftDiagonalSymbols.add(this.board.values.elementAt(i));
      }

      winningSymbol = checkWinningSymbol(topLeftDiagonalSymbols);

      if (winningSymbol != Symbol.Empty) {
        return MapEntry(winningSymbol, indexes);
      } else {
        indexes.clear();
      }
    }

    // Top-Right diagonal
    if (this.board.values.elementAt(cells - 1) != Symbol.Empty) {
      final List<Symbol> topRightDiagonalSymbols = [];

      for (int i = 1; i < cells + 1; i++) {
        indexes.add(cells * i - i);
        topRightDiagonalSymbols.add(this.board.values.elementAt(cells * i - i));
      }

      winningSymbol = checkWinningSymbol(topRightDiagonalSymbols);
    }

    if (winningSymbol == Symbol.Empty) {
      indexes.clear();
    }
    return MapEntry(winningSymbol, indexes);
  }

  Symbol checkWinningSymbol(List<Symbol> symbols) {
    if (symbols.every((element) => element == Symbol.X)) {
      return Symbol.X;
    }

    if (symbols.every((element) => element == Symbol.O)) {
      return Symbol.O;
    }

    return Symbol.Empty;
  }
}

class Turn {
  Turn(this.position, this.symbol);

  final int position;
  final Symbol symbol;
}

enum Symbol {
  X,
  O,
  Empty,
}

String symbolToString(Symbol symbol) {
  return symbol.toString().split('.').last.substring(0, 1);
}
