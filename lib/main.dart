import 'package:flutter/material.dart';

void main() => runApp(const TicTacToeGame());

class TicTacToeGame extends StatelessWidget {
  const TicTacToeGame({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Tic Tac Toe Game',
      debugShowCheckedModeBanner: false,
      home: TicTacToeScreen(),
    );
  }
}

class TicTacToeScreen extends StatefulWidget {
  const TicTacToeScreen({super.key});

  @override
  _TicTacToeScreenState createState() => _TicTacToeScreenState();
}

class _TicTacToeScreenState extends State<TicTacToeScreen> {
  late List<List<String>> board;
  late String currentPlayer;
  late bool gameEnded;

  @override
  void initState() {
    super.initState();
    startGame();
  }

  void startGame() {
    board = List.generate(3, (_) => List.filled(3, ''));
    currentPlayer = 'X';
    gameEnded = false;
  }

  void makeMove(int row, int col) {
    if (board[row][col] == '' && !gameEnded) {
      setState(() {
        board[row][col] = currentPlayer;
        if (checkWinner(row, col)) {
          gameEnded = true;
          showWinnerDialog();
        } else if (isBoardFull()) {
          gameEnded = true;
          showDrawDialog();
        } else {
          currentPlayer = (currentPlayer == 'X') ? 'O' : 'X';
        }
      });
    }
  }

  bool checkWinner(int row, int col) {
    // Check row
    if (board[row].every((element) => element == currentPlayer)) {
      return true;
    }

    // Check column
    if (List.generate(3, (i) => board[i][col])
        .every((element) => element == currentPlayer)) {
      return true;
    }

    // Check diagonals
    if ((row == col || row + col == 2) &&
        (List.generate(3, (i) => board[i][i])
                .every((element) => element == currentPlayer) ||
            List.generate(3, (i) => board[i][2 - i])
                .every((element) => element == currentPlayer))) {
      return true;
    }

    return false;
  }

  bool isBoardFull() {
    return board.every((row) => row.every((cell) => cell != ''));
  }

  void showWinnerDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Game Over'),
          content: Text('Player $currentPlayer wins!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                startGame();
              },
              child: const Text('Play Again'),
            ),
          ],
        );
      },
    );
  }

  void showDrawDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Game Over'),
          content: const Text('It\'s a draw!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                startGame();
              },
              child: const Text('Play Again'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic Tac Toe'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Player Turn: $currentPlayer',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            Column(
              children: List.generate(
                3,
                (row) => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    3,
                    (col) => GestureDetector(
                      onTap: () => makeMove(row, col),
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          border: Border.all(),
                        ),
                        child: Center(
                          child: Text(
                            board[row][col],
                            style: const TextStyle(fontSize: 30),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
