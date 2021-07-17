import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe/src/helpers/classes/board.dart';

void main() {
  test('Test winning conditions 3x3 first row', () {
    final int cells = 3;
    final Board gameBoard = Board.empty(cells);
    gameBoard.placeSymbol(0);
    gameBoard.placeSymbol(8);
    gameBoard.placeSymbol(1);
    gameBoard.placeSymbol(7);
    gameBoard.placeSymbol(2);

    expect(
      gameBoard.checkWinner().key,
      Symbol.X,
    );

    expect(
      gameBoard.checkWinner().value,
      [0, 1, 2],
    );

    expect(gameBoard.isSolved, true);
  });

  test('Test winning conditions 3x3 second row', () {
    final int cells = 3;
    final Board gameBoard = Board.empty(cells);
    gameBoard.placeSymbol(3);
    gameBoard.placeSymbol(8);
    gameBoard.placeSymbol(4);
    gameBoard.placeSymbol(7);
    gameBoard.placeSymbol(5);

    expect(
      gameBoard.checkWinner().key,
      Symbol.X,
    );

    expect(
      gameBoard.checkWinner().value,
      [3, 4, 5],
    );

    expect(gameBoard.isSolved, true);
  });

  test('Test winning conditions 3x3 third row', () {
    final int cells = 3;
    final Board gameBoard = Board.empty(cells);
    gameBoard.placeSymbol(6);
    gameBoard.placeSymbol(1);
    gameBoard.placeSymbol(7);
    gameBoard.placeSymbol(2);
    gameBoard.placeSymbol(8);

    expect(
      gameBoard.checkWinner().key,
      Symbol.X,
    );

    expect(
      gameBoard.checkWinner().value,
      [6, 7, 8],
    );

    expect(gameBoard.isSolved, true);
  });

  test('Test winning conditions 3x3 first column', () {
    final int cells = 3;
    final Board gameBoard = Board.empty(cells);
    gameBoard.placeSymbol(0);
    gameBoard.placeSymbol(8);
    gameBoard.placeSymbol(3);
    gameBoard.placeSymbol(7);
    gameBoard.placeSymbol(6);

    expect(
      gameBoard.checkWinner().key,
      Symbol.X,
    );

    expect(
      gameBoard.checkWinner().value,
      [0, 3, 6],
    );

    expect(gameBoard.isSolved, true);
  });

  test('Test winning conditions 3x3 second column', () {
    final int cells = 3;
    final Board gameBoard = Board.empty(cells);
    gameBoard.placeSymbol(1);
    gameBoard.placeSymbol(8);
    gameBoard.placeSymbol(4);
    gameBoard.placeSymbol(5);
    gameBoard.placeSymbol(7);

    expect(
      gameBoard.checkWinner().key,
      Symbol.X,
    );

    expect(
      gameBoard.checkWinner().value,
      [1, 4, 7],
    );

    expect(gameBoard.isSolved, true);
  });

  test('Test winning conditions 3x3 third column', () {
    final int cells = 3;
    final Board gameBoard = Board.empty(cells);
    gameBoard.placeSymbol(2);
    gameBoard.placeSymbol(1);
    gameBoard.placeSymbol(5);
    gameBoard.placeSymbol(3);
    gameBoard.placeSymbol(8);

    expect(
      gameBoard.checkWinner().key,
      Symbol.X,
    );

    expect(
      gameBoard.checkWinner().value,
      [2, 5, 8],
    );

    expect(gameBoard.isSolved, true);
  });

  test('Test winning conditions 3x3 top-left diagonal', () {
    final int cells = 3;
    final Board gameBoard = Board.empty(cells);
    gameBoard.placeSymbol(0);
    gameBoard.placeSymbol(1);
    gameBoard.placeSymbol(4);
    gameBoard.placeSymbol(2);
    gameBoard.placeSymbol(8);

    expect(
      gameBoard.checkWinner().key,
      Symbol.X,
    );

    expect(
      gameBoard.checkWinner().value,
      [0, 4, 8],
    );

    expect(gameBoard.isSolved, true);
  });

  test('Test winning conditions 3x3 top-right diagonal', () {
    final int cells = 3;
    final Board gameBoard = Board.empty(cells);
    gameBoard.placeSymbol(2);
    gameBoard.placeSymbol(1);
    gameBoard.placeSymbol(4);
    gameBoard.placeSymbol(7);
    gameBoard.placeSymbol(6);

    expect(
      gameBoard.checkWinner().key,
      Symbol.X,
    );

    expect(
      gameBoard.checkWinner().value,
      [2, 4, 6],
    );

    expect(gameBoard.isSolved, true);
  });


  test(
    'Simulate fully random filled board 3x3',
    () {
      final int cells = 3;
      final Board gameBoard = Board.empty(cells);

      expect(gameBoard.turns.length, 0);
      expect(gameBoard.board.values.contains(Symbol.X), false);
      expect(gameBoard.board.values.contains(Symbol.O), false);
      expect(gameBoard.board.values.every((v) => v == Symbol.Empty), true);

      gameBoard.placeAtRandomPosition();

      expect(gameBoard.turns.length, 1);
      expect(gameBoard.board.values.contains(Symbol.X), true);
      expect(gameBoard.board.values.contains(Symbol.O), false);
      expect(gameBoard.board.values.every((v) => v == Symbol.Empty), false);

      gameBoard.placeAtRandomPosition();

      expect(gameBoard.turns.length, 2);
      expect(gameBoard.board.values.contains(Symbol.X), true);
      expect(gameBoard.board.values.contains(Symbol.O), true);
      expect(gameBoard.board.values.every((v) => v == Symbol.Empty), false);

      for (int i = 2; i < cells * cells; i++) {
        gameBoard.placeAtRandomPosition();

        expect(gameBoard.turns.length, i + 1);
        expect(gameBoard.board.values.contains(Symbol.X), true);
        expect(gameBoard.board.values.contains(Symbol.O), true);
        expect(gameBoard.board.values.every((v) => v == Symbol.Empty), false);
      }

      expect(gameBoard.turns.length, 9);
      expect(
        gameBoard.board.values.where((element) => element == Symbol.X).length,
        5,
      );
      expect(
        gameBoard.board.values.where((element) => element == Symbol.O).length,
        4,
      );

      expect(gameBoard.board.values.contains(Symbol.Empty), false);
      gameBoard.printFullBoard();
    },
  );

  test(
    'Simulate fully random filled board 4x4',
    () {
      final int cells = 4;
      final Board gameBoard = Board.empty(cells);

      expect(gameBoard.turns.length, 0);
      expect(gameBoard.board.values.contains(Symbol.X), false);
      expect(gameBoard.board.values.contains(Symbol.O), false);
      expect(gameBoard.board.values.every((v) => v == Symbol.Empty), true);

      gameBoard.placeAtRandomPosition();

      expect(gameBoard.turns.length, 1);
      expect(gameBoard.board.values.contains(Symbol.X), true);
      expect(gameBoard.board.values.contains(Symbol.O), false);
      expect(gameBoard.board.values.every((v) => v == Symbol.Empty), false);

      gameBoard.placeAtRandomPosition();

      expect(gameBoard.turns.length, 2);
      expect(gameBoard.board.values.contains(Symbol.X), true);
      expect(gameBoard.board.values.contains(Symbol.O), true);
      expect(gameBoard.board.values.every((v) => v == Symbol.Empty), false);

      for (int i = 2; i < cells * cells; i++) {
        gameBoard.placeAtRandomPosition();

        expect(gameBoard.turns.length, i + 1);
        expect(gameBoard.board.values.contains(Symbol.X), true);
        expect(gameBoard.board.values.contains(Symbol.O), true);
        expect(gameBoard.board.values.every((v) => v == Symbol.Empty), false);
      }

      expect(gameBoard.turns.length, 16);
      expect(
        gameBoard.board.values.where((element) => element == Symbol.X).length,
        8,
      );
      expect(
        gameBoard.board.values.where((element) => element == Symbol.O).length,
        8,
      );

      expect(gameBoard.board.values.contains(Symbol.Empty), false);
      gameBoard.printFullBoard();
    },
  );

  test(
    'Simulate fully random filled board 5x5',
    () {
      final int cells = 5;
      final Board gameBoard = Board.empty(cells);

      expect(gameBoard.turns.length, 0);
      expect(gameBoard.board.values.contains(Symbol.X), false);
      expect(gameBoard.board.values.contains(Symbol.O), false);
      expect(gameBoard.board.values.every((v) => v == Symbol.Empty), true);

      gameBoard.placeAtRandomPosition();

      expect(gameBoard.turns.length, 1);
      expect(gameBoard.board.values.contains(Symbol.X), true);
      expect(gameBoard.board.values.contains(Symbol.O), false);
      expect(gameBoard.board.values.every((v) => v == Symbol.Empty), false);

      gameBoard.placeAtRandomPosition();

      expect(gameBoard.turns.length, 2);
      expect(gameBoard.board.values.contains(Symbol.X), true);
      expect(gameBoard.board.values.contains(Symbol.O), true);
      expect(gameBoard.board.values.every((v) => v == Symbol.Empty), false);

      for (int i = 2; i < cells * cells; i++) {
        gameBoard.placeAtRandomPosition();

        expect(gameBoard.turns.length, i + 1);
        expect(gameBoard.board.values.contains(Symbol.X), true);
        expect(gameBoard.board.values.contains(Symbol.O), true);
        expect(gameBoard.board.values.every((v) => v == Symbol.Empty), false);
      }

      expect(gameBoard.turns.length, 25);
      expect(
        gameBoard.board.values.where((element) => element == Symbol.X).length,
        13,
      );
      expect(
        gameBoard.board.values.where((element) => element == Symbol.O).length,
        12,
      );

      expect(gameBoard.board.values.contains(Symbol.Empty), false);
      gameBoard.printFullBoard();
    },
  );


  test(
    'Simulate fully random played game with 3x3 field',
    () {
      final int cells = 3;
      final Board gameBoard = Board.empty(cells);

      MapEntry<Symbol, List<int>> winner = MapEntry(Symbol.Empty, []);

      for (int i = 0; i < cells * cells; i++) {
        gameBoard.placeAtRandomPosition();

        if (gameBoard.turns.length > 3) {
          winner = gameBoard.checkWinner();
          if (winner.key != Symbol.Empty) {
            gameBoard.printFullBoard();
            print("The winner is ${symbolToString(winner.key)}");

            break;
          }
        }

        expect(gameBoard.turns.length, i + 1);
      }

      if (winner.key == Symbol.Empty) {
        gameBoard.printFullBoard();
        print("Draw");
      }
    },
  );

  test(
    'Simulate fully random played game with 4x4 field',
    () {
      final int cells = 4;
      final Board gameBoard = Board.empty(cells);

      MapEntry<Symbol, List<int>> winner = MapEntry(Symbol.Empty, []);

      for (int i = 0; i < cells * cells; i++) {
        gameBoard.placeAtRandomPosition();

        if (gameBoard.turns.length > 3) {
          winner = gameBoard.checkWinner();
          if (winner.key != Symbol.Empty) {
            gameBoard.printFullBoard();
            print("The winner is ${symbolToString(winner.key)}");

            break;
          }
        }

        expect(gameBoard.turns.length, i + 1);
      }

      if (winner.key == Symbol.Empty) {
        gameBoard.printFullBoard();
        print("Draw");
      }
    },
  );

  test(
    'Simulate fully random played game with 5x5 field',
    () {
      final int cells = 5;
      final Board gameBoard = Board.empty(cells);

      MapEntry<Symbol, List<int>> winner = MapEntry(Symbol.Empty, []);

      for (int i = 0; i < cells * cells; i++) {
        gameBoard.placeAtRandomPosition();

        if (gameBoard.turns.length > 3) {
          winner = gameBoard.checkWinner();
          if (winner.key != Symbol.Empty) {
            gameBoard.printFullBoard();
            print("The winner is ${symbolToString(winner.key)}");

            break;
          }
        }

        expect(gameBoard.turns.length, i + 1);
      }

      if (winner.key == Symbol.Empty) {
        gameBoard.printFullBoard();
        print("Draw");
      }
    },
  );
}
