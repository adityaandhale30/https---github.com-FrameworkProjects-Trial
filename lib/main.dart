import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const CandyCrushApp());
}

class CandyCrushApp extends StatelessWidget {
  const CandyCrushApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CandyCrushGame(),
    );
  }
}

class CandyCrushGame extends StatefulWidget {
  const CandyCrushGame({super.key});

  @override
  _CandyCrushGameState createState() => _CandyCrushGameState();
}

class _CandyCrushGameState extends State<CandyCrushGame> {
  static const int gridSize = 8;
  static const int candyTypes = 5;
  late List<List<int>> grid;

  @override
  void initState() {
    super.initState();
    grid = _generateGrid();
  }

  List<List<int>> _generateGrid() {
    final random = Random();
    return List.generate(
      gridSize,
      (_) => List.generate(gridSize, (_) => random.nextInt(candyTypes)),
    );
  }

  void _swapCandies(int row1, int col1, int row2, int col2) {
    setState(() {

      final temp = grid[row1][col1];
      grid[row1][col1] = grid[row2][col2];
      grid[row2][col2] = temp;
    });
    _checkAndClearMatches();
  }

  void _checkAndClearMatches() {
    final matched = List.generate(gridSize, (_) => List.generate(gridSize, (_) => false));

    // Check for horizontal matches
    for (int row = 0; row < gridSize; row++) {
      for (int col = 0; col < gridSize - 2; col++) {
        
        
        if (grid[row][col] == grid[row][col + 1] && grid[row][col] == grid[row][col + 2]) {
          matched[row][col] = matched[row][col + 1] = matched[row][col + 2] = true;
        }
      }
    }

    // Check for vertical matches
    for (int col = 0; col < gridSize; col++) {
      for (int row = 0; row < gridSize - 2; row++) {
        if (grid[row][col] == grid[row + 1][col] && grid[row][col] == grid[row + 2][col]) {
          matched[row][col] = matched[row + 1][col] = matched[row + 2][col] = true;
        }
      }
    }

    // Clear matched candies and drop new ones
    setState(() {
      for (int row = 0; row < gridSize; row++) {
        for (int col = 0; col < gridSize; col++) {
          if (matched[row][col]) {
            grid[row][col] = -1; // Mark as cleared
          }
        }
      }

      _dropCandies();
    });
  }

  void _dropCandies() {
    final random = Random();
    for (int col = 0; col < gridSize; col++) {
      int emptySpaces = 0;

      for (int row = gridSize - 1; row >= 0; row--) {
        if (grid[row][col] == -1) {
          emptySpaces++;
        } else if (emptySpaces > 0) {
          grid[row + emptySpaces][col] = grid[row][col];
          grid[row][col] = -1;
        }
      }

      // Generate new candies at the top
      for (int row = 0; row < emptySpaces; row++) {
        grid[row][col] = random.nextInt(candyTypes);
      }
    }
  }

  Widget _buildCandy(int row, int col) {
    final colors = [Colors.red, Colors.green, Colors.blue, Colors.yellow, Colors.purple];
    final candyColor = grid[row][col] == -1 ? Colors.white : colors[grid[row][col]];

    return DragTarget<Map<String, int>>(
      onAccept: (data) {
        _swapCandies(data['row']!, data['col']!, row, col);
      },
      builder: (context, candidateData, rejectedData) {
        return Draggable<Map<String, int>>(
          data: {'row': row, 'col': col},
          feedback: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: candyColor.withOpacity(0.7),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.black),
            ),
          ),
          childWhenDragging: Container(
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.black),
            ),
          ),
          child: Container(
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: candyColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.black),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Candy Crush - Draggable'),
      ),
      body: Center(
        child: GridView.builder(
          padding: const EdgeInsets.all(10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: gridSize,
            childAspectRatio: 1,
          ),
          itemCount: gridSize * gridSize,
          itemBuilder: (context, index) {
            final row = index ~/ gridSize;
            final col = index % gridSize;
            return _buildCandy(row, col);
          },
        ),
      ),
    );
  }
}
