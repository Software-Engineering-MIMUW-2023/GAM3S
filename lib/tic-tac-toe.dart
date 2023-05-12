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
  MaterialColor c = Colors.green;
  MaterialAccentColor ac = Colors.greenAccent;

  GState(this.greenTurn, this.row, this.col, this.gScore, this.yScore);
}

Map<int, Color> setColor = {
  -1: Colors.green,
  0: Colors.lightBlue,
  1: Colors.amber,
};

GState GenerateGState(int row, int col, gScore, yScore) {
  GState state = GState(true, row, col, gScore, yScore);

  state.occupied = List.generate(
      row, (i) => List.filled(col, 0, growable: false),
      growable: false);

  return state;
}

class MyFloatingActionButton extends FloatingActionButton {
  final int x;
  final int y;

  const MyFloatingActionButton(this.x, this.y,
      {super.key,
      required super.onPressed,
      super.child,
      super.backgroundColor,
      super.splashColor});
}

class Gomoku extends StatelessWidget {
  const Gomoku({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Gomoku'),
    );
  }
}

List<Padding> listMaker(
    int row, int col, GState state, Function(int x, int y, GState state) func) {
  List<Padding> toReturn = List.generate(
      col,
      (i) => Padding(
          padding: const EdgeInsets.all(2.0),
          child: SizedBox(
              width: 40,
              height: 40,
              child: MyFloatingActionButton(
                row,
                i % col,
                onPressed: () {
                  func(row, i % col, state);
                },
                backgroundColor: setColor[state.occupied[row][i % col]],
                child: Text("($row, ${i % col})"),
              ))));

  return toReturn;
}

List<Row> listMaker3(
    int row, int col, GState state, Function(int x, int y, GState state) func) {
  late var toReturn = List.generate(
      col,
      (i) => Row(
            children: listMaker(
                i, col, state, (i, col, state) => func(i, col, state)),
          ));

  return toReturn;
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static int row = 15;
  static int col = 15;
  late GState state = GenerateGState(row, col, 0, 0);

  List<Pair> sides = [Pair(-1, 0), Pair(-1, -1), Pair(0, -1), Pair(1, -1)];

  bool _isFieldOccupied(int x, int y, List<List<int>> occupied) {
    return occupied[x][y] != 0;
  }

  int checkOneSide(
      int c, List<List<int>> occupied, int x, int y, int j, int i, int fac) {
    int newX = x + j * sides[i].get(0) * fac;
    int newY = y + j * sides[i].get(1) * fac;

    return !(0 < newX || newX >= row || newY < 0 || newX >= col) &&
        c == occupied[newX][newY] ? 1 : 0;
  }

  bool _checkWinCondition(int x, int y, List<List<int>> occupied) {
    int c = occupied[x][y];

    for (int i = 0; i < 4; i++) {
      // sprawdzanie 4 opcji zwycięstwa
      int score = 0;
      // trzeba spawdzic do 4 wartości z każdej strony
      for (int j = 1; j <= 4; j++) {
        score += checkOneSide(c, occupied, x, y, j, i, 1);
        score += checkOneSide(c, occupied, x, y, j, i, -1);
      }

      if (score >= 5) {
        return true;
      }
    }

    return false;
  }

  void _makeTurn(int x, int y, GState state) {
    setState(() {
      int c = 1;
      if (state.greenTurn) {
        c = -1;
      }

      if (!_isFieldOccupied(x, y, state.occupied)) {
        state.occupied[x][y] = c;
        state.occupiedAmount++;

        if (_checkWinCondition(x, y, state.occupied)) {
          state = GenerateGState(
              row,
              col,
              state.greenTurn ? 1 + state.gScore : state.gScore,
              state.greenTurn ? state.yScore : 1 + state.yScore);
        }

        if (state.occupiedAmount >= row * col) {
          state = GenerateGState(
              row,
              col,
              state.gScore,
              state.yScore);
        }
      }

      state.greenTurn = !state.greenTurn;
    });
  }

  @override
  Widget build(BuildContext context) {
    late var buttonColumn = listMaker3(
        row, col, state, (i, col, state) => _makeTurn(i, col, state));
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Center(child: Text(widget.title)),
      ),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
                color: Colors.lightBlueAccent,
                child: Column(children: buttonColumn)),
          ),
        ),
      ),
      floatingActionButton: Column(children: [
        Spacer(flex: 50),
        Text(
          '${state.greenTurn}',
        ),
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
