import 'package:flutter/material.dart';

class Pair {
  final int first;
  final int second;

  int get(int i) {
    return i == 0 ? first : second;
  }

  Pair(this.first, this.second);
}

class GState {
  bool greenTurn;
  int row;
  int col;
  int gScore;
  int yScore;
  int occupiedAmount = 0;
  List<List<int>> occupied = []; // -1 - green, 0 - nobody, 1 - yellow
  Color c = Colors.green;
  MaterialAccentColor ac = Colors.greenAccent;

  GState(this.greenTurn, this.row, this.col, this.gScore, this.yScore);
}

Map<int, Color> setColor = {
  -1: Colors.green,
  0: Colors.lightBlue,
  1: Colors.amber,
  2: Colors.white
};

class MyFloatingActionButton extends FloatingActionButton {
  final int x;
  final int y;

  const MyFloatingActionButton(this.x, this.y,
      {super.key,
        required super.onPressed,
        super.child,
        super.backgroundColor,
        super.splashColor,
        super.shape});
}

List<SizedBox> listMaker(
    int row, int col, GState state, Function(int x, int y, GState state) func) {
  List<SizedBox> toReturn = List.generate(
      col,
          (i) => const SizedBox(
          width: 20,
        height: 20,
      ));

  for (var i = col - 1; i >= 1; i -= 1) {
    toReturn.insert(
        i,
        SizedBox(
            width: 50,
            height: 20,
            child: MyFloatingActionButton(
              row,
              i,
              onPressed: () {
                func(row, 2*i-1, state);
              },
              backgroundColor: setColor[state.occupied[row][2*i-1]],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            )));
  }
  return toReturn;
}

List<SizedBox> listMaker2(
    int row, int col, GState state, Function(int x, int y, GState state) func) {
  late var toReturn = <SizedBox>[];

  for (var i = 0; i <= 2 * col - 2; i += 2) {
    toReturn.insert(i, SizedBox(
        width: 20,
        height: 50,
        child: MyFloatingActionButton(
          row,
          i,
          onPressed: () {
            func(row, i, state);
          },
          backgroundColor: setColor[state.occupied[row][i]],
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)),

        )));
    //i+= 1;
    if (i < 2 * col - 2) {
      toReturn.insert(
          i + 1,
          SizedBox(
              width: 50,
              height: 50,
              child: Container(
                decoration: BoxDecoration(
                    color: (setColor[state.occupied[row][i+1]])!,
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
              )));
    }
  }

  return toReturn;
}

List<Row> listMaker3(
    int row, int col, GState state, Function(int x, int y, GState state) func) {
  late var toReturn = <Row>[];
  for (var i = 0; i < 2 * row - 2; i += 1) {
    toReturn.insert(i, Row(
      children: listMaker(
          i, col, state, (i, col, state) => func(i, col, state)),
    ));
    i += 1;
    toReturn.insert(i, Row(
      children: listMaker2(
          i, col, state, (i, col, state) => func(i, col, state)),
    ));
  }
  toReturn.insert(10, Row(
    children: listMaker(
        10, col, state, (i, col, state) => func(i, col, state)),
  ));
  return toReturn;
}

class DotsAndBoxes extends StatefulWidget {
  const DotsAndBoxes({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  final String title;

  @override
  State<DotsAndBoxes> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<DotsAndBoxes> {
  static int row = 6;
  static int col = 6;
  late GState state = GenerateGState(row, col, 0, 0);

  List<Pair> sides = [Pair(-1, 0), Pair(-1, -1), Pair(0, -1), Pair(1, -1)];

  GState GenerateGState(int row, int col, gScore, yScore) {
    GState state = GState(true, row, col, gScore, yScore);

    state.occupied = List.generate(
        2*row-1, (i) => List.filled(2*col-1, 0, growable: false),
        growable: false);

    for (int i = 0; i < 2 * row - 2; i += 1) {
      for (int j = 0; j < 2 * col - 2; j += 1) {
        if (i % 2 == 1 && j % 2 == 1) {
          state.occupied[i][j] = 2;
        }
      }
    }

    return state;
  }

  bool _isFieldOccupied(int x, int y, List<List<int>> occupied) {
    return occupied[x][y] != 0 && occupied[x][y] != 2;
  }

  int checkOneSide(
      int c, List<List<int>> occupied, int x, int y, int j, int i, int fac) {
    int newX = x + j * sides[i].get(0) * fac;
    int newY = y + j * sides[i].get(1) * fac;

    return !(0 > newX || newX >= row || newY < 0 || newY >= col) &&
        c == occupied[newX][newY]
        ? 1
        : 0;
  }

  bool _checkWinCondition(int x, int y, List<List<int>> occupied) {
    int toWin = 13;
    return (state.gScore >= toWin || state.yScore >= toWin);
  }

  void _add_point() {
    state.occupiedAmount++;
    if (state.greenTurn) {
      state.gScore += 1;
    }
    else {
      state.yScore += 1;
    }
  }

  bool _check_borders(int x, int y, int c) {
    if (x % 2 == 0) {
      if (x - 2 >= 0) {
        if (_isFieldOccupied(x - 1, y - 1, state.occupied) &&
            _isFieldOccupied(x - 1, y + 1, state.occupied) &&
            _isFieldOccupied(x - 2, y, state.occupied)) {
          state.occupied[x-1][y] = c;
          _add_point();
          return true;
        }
      }
      if (x + 2 <= 2 * row - 2) {
        if (_isFieldOccupied(x + 1, y - 1, state.occupied) &&
            _isFieldOccupied(x + 1, y + 1, state.occupied) &&
            _isFieldOccupied(x + 2, y, state.occupied)) {
          state.occupied[x+1][y] = c;
          _add_point();
          return true;
        }
      }
    }
    else {
      if (y - 2 >= 0) {
        if (_isFieldOccupied(x - 1, y - 1, state.occupied) &&
            _isFieldOccupied(x + 1, y - 1, state.occupied) &&
            _isFieldOccupied(x, y - 2, state.occupied)) {
          state.occupied[x][y - 1] = c;
          _add_point();
          return true;
        }
      }
      if (y + 2 <= 2 * col - 2) {
        if (_isFieldOccupied(x - 1, y + 1, state.occupied) &&
            _isFieldOccupied(x + 1, y + 1, state.occupied) &&
            _isFieldOccupied(x, y + 2, state.occupied)) {
          state.occupied[x][y + 1] = c;
          _add_point();
          return true;
        }
      }
    }
    return false;
  }

  void _makeTurn(int x, int y, GState stateLoc) {
    setState(() {
      int c = 1;
      if (state.greenTurn) {
        c = -1;
      }

      if (!_isFieldOccupied(x, y, state.occupied)) {
        state.occupied[x][y] = c;
        bool point = _check_borders(x, y, c);
        if (_checkWinCondition(x, y, state.occupied)) {
          state = GenerateGState(
              row,
              col,
              0,
              0);
        } else {
          if (state.occupiedAmount == (row-1) * (col-1)) {
            state = GenerateGState(row, col, state.gScore, state.yScore);
          }
        }
        if (!point) {
          state.c = (setColor[-1 * c])!;
          state.greenTurn = !state.greenTurn;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    late var buttonColumn = listMaker3(
        row, col, state, (i, col, state) => _makeTurn(i, col, state));

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.title)),
      ),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
                color: Colors.white,
                child: Column(children: buttonColumn)),
          ),
        ),
      ),
      floatingActionButton: Column(children: [
        Spacer(flex: 50),
        Spacer(),
        Row(children: [
          Spacer(flex: 2),
          FloatingActionButton(
            onPressed: () {
              setState(() {});
            },
            tooltip: 'Player',
            backgroundColor: state.c,
            child: const Icon(Icons.accessibility_new),
          ),
          Spacer(),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                state = GenerateGState(row, col, 0, 0);
              });
            },
            tooltip: 'Reset',
            backgroundColor: Colors.redAccent,
            child: const Icon(Icons.refresh),
          ),
          const Spacer(),
          FloatingActionButton(
            onPressed: () {
              setState(() {});
            },
            tooltip: 'Green_Score',
            backgroundColor: Colors.amber,
            child: Text("${state.yScore}"),
          ),
          const Spacer(),
          FloatingActionButton(
            onPressed: () {
              setState(() {});
            },
            tooltip: 'Green_Score',
            backgroundColor: Colors.green,
            child: Text("${state.gScore}"),
          ),
          const Spacer(flex: 2)
        ]),
        Spacer()
      ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}