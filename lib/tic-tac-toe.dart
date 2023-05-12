import 'package:flutter/material.dart';

class GState {
  bool greenTurn;
  int row;
  int col;
  int gScore = 0;
  int yScore = 0;
  List<List<int>> occupied = []; // -1 - green, 0 - nobody, 1 - yellow
  MaterialColor c = Colors.green;
  MaterialAccentColor ac = Colors.greenAccent;

  GState(this.greenTurn, this.row, this.col);
}

GState GenerateGState(int row, int col) {
  GState state = GState(true, row, col);

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
          padding: const EdgeInsets.all(3.0),
          child: SizedBox(
              width: 40,
              height: 40,
              child: MyFloatingActionButton(
                row,
                i % col,
                onPressed: () {
                  func(row, i % col, state);
                },
                backgroundColor: Colors.lightBlue,
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
  late GState state = GenerateGState(row, col);

  void _makeTurn(int x, int y, GState state) {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      // int posToken = -1;
      // List<List<bool>> allowed = state.yMoves;
      //
      // List<List<bool>> enemy_allowed = state.gMoves;
      // int myHeadX = state.yHeadX;
      // int myHeadY = state.yHeadY;
      // if (state.greenTurn) {
      //   allowed = state.gMoves;
      //   enemy_allowed = state.yMoves;
      //   posToken = 1;
      //   myHeadX = state.gHeadX;
      //   myHeadY = state.gHeadY;
      // }
      // print("HeadX: $myHeadX, HeadY: $myHeadY\n");
      // print("x: $x, y: $y\n");
      // int newHeadX = x;
      // int newHeadY = y;
      // if (allowed[x][y]) {
      //   //poruszanie się
      //   int toAddX = -1;
      //   int toAddY = -1;
      //   if (x < myHeadX) {
      //     toAddX = 1;
      //   }
      //   if (y < myHeadY) {
      //     toAddY = 1;
      //   }
      //   if (x == myHeadX) {
      //     toAddX = 0;
      //   }
      //   if (y == myHeadY) {
      //     toAddY = 0;
      //   }
      //   print("to add $toAddX, $toAddY\n");
      //   do {
      //
      //     state.pos[x][y] = posToken;
      //     enemy_allowed[x][y] = false;
      //     allowed[x][y] = false;
      //     x+= toAddX;
      //     y+= toAddY;
      //     print("Pos added x: $x, y: $y\n");
      //   } while (x != myHeadX || y != myHeadY);
      //   // aktualizacja allowed:
      //   //Uwaga!!! Od nowa trzeba zrobić cały na false!!! Najlepiej zrobić funkcję, której ”edziemożna
      //   // użyć też przy inicjacji i tutaj...
      //   //
      //   state.greenTurn = !state.greenTurn;
      //   if (state.greenTurn == true) { //ruch wykonał żółty
      //     state.yHeadX = newHeadX;
      //     state.yHeadY = newHeadY;
      //
      //     state.c = Colors.green;
      //     state.ac = Colors.greenAccent;
      //   }
      //   else{ //ruch wykonał zielony
      //     state.gHeadX = newHeadX;
      //     state.gHeadY = newHeadY;
      //
      //     state.ac = Colors.amberAccent;
      //     state.c = Colors.amber;
      //   }
      //
      //
      // }
      // mainColorMatrix = matrixColorSet(state); // aktualizuje macierz kolorow
      // mi nie potrzbna
      // mainColorSplash = matrixColorSplashSet(state);
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
                state = GenerateGState(row, col);
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
