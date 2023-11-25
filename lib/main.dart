import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(const BlocksGame());

class BlocksGame extends StatelessWidget {
  const BlocksGame({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Blocks Game',
      debugShowCheckedModeBanner: false,
      home: BlocksGameScreen(),
    );
  }
}

class BlocksGameScreen extends StatefulWidget {
  const BlocksGameScreen({super.key});

  @override
  _BlocksGameScreenState createState() => _BlocksGameScreenState();
}

class _BlocksGameScreenState extends State<BlocksGameScreen> {
  late List<List<Color>> grid;
  int rows = 8;
  int columns = 5;

  @override
  void initState() {
    super.initState();
    initializeGrid();
  }

  void initializeGrid() {
    grid = List.generate(rows, (_) => List.filled(columns, getRandomColor()));
  }

  Color getRandomColor() {
    List<Color> colors = [Colors.red, Colors.blue, Colors.green, Colors.yellow];
    return colors[Random().nextInt(colors.length)];
  }

  void onTap(int row, int col) {
    setState(() {
      grid[row][col] = Colors.transparent;
      for (int i = row; i > 0; i--) {
        grid[i][col] = grid[i - 1][col];
      }
      grid[0][col] = getRandomColor();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blocks Game'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            rows,
            (row) => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                columns,
                (col) => GestureDetector(
                  onTap: () => onTap(row, col),
                  child: Container(
                    width: 50,
                    height: 50,
                    margin: const EdgeInsets.all(4),
                    color: grid[row][col],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
