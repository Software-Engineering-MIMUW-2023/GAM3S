import 'package:flutter/material.dart';

class GState {
  bool greenTurn;
  int gHeadX;
  int gHeadY;
  int yHeadX;
  int yHeadY;
  int row;
  int col;
  int gScore = 0;
  int yScore = 0;
  List<List<int>> pos = [];
  List<List<bool>> gMoves = [];
  List<List<bool>> yMoves = [];
  MaterialColor c = Colors.green;
  MaterialAccentColor ac = Colors.greenAccent;
  GState(this.greenTurn, this.gHeadX, this.gHeadY, this.yHeadX, this.yHeadY, this.row, this.col);
}

Map<int, Color> setColor = {
  -1: Colors.green,
  0: Colors.lightBlue,
  1: Colors.amber,
};

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}

List<List<bool>> UpdateGState(int row, int col, List<List<int>> pos, int xHeadX, int xHeadY){
  List<List<bool>> xMoves =   List.generate(
      row, (i) => List.filled(col, false, growable: false),
      growable: false);

  // poziome ustalnie pozycji
  for (var i = 0; i < col; i++) {
    if (pos[xHeadX][i] == 0) {
      xMoves[xHeadX][i] = true;
    }
  }

  // pionowe ustalanie pozycji
  for (var i = 0; i < row; i++) {
    if (pos[i][xHeadY] == 0) {
      xMoves[i][xHeadY] = true;
    }
  }

  // na skos w prawo


  return xMoves;
}

GState GenerateGState(int row, int col) {
  GState state = GState(true, 0, col-1, row-1, 0, row, col);
  state.pos =   List.generate(
      row, (i) => List.filled(col, 0, growable: false),
      growable: false);
  state.pos[0][col-1] = 1;
  state.pos[row-1][0] = -1;

  state.yMoves =   List.generate(
      row, (i) => List.filled(col, false, growable: false),
      growable: false);
  for( var i = 1; i < col; i++ ) {
    state.yMoves[row-1][i] = true;
  }
  for( var i = 0; i < row - 1; i++ ) {
    state.yMoves[i][0] = true;
  }
  for( var i = 1; i < row - 1; i++ ) {
    state.yMoves[i][col - 1 - i] = true;
  }

  state.gMoves =   List.generate(
      row, (i) => List.filled(col, false, growable: false),
      growable: false);
  for( var i = 0; i < col-1; i++ ) {
    state.gMoves[0][i] = true;
  }
  for( var i = 1; i < row; i++ ) {
    state.gMoves[i][col-1] = true;
  }
  for( var i = 1; i < row - 1; i++ ) {
    state.gMoves[i][col - 1 - i] = true;
  }
  return state;
}

class MyFloatingActionButton extends FloatingActionButton {
  final int x;
  final int y;
  const MyFloatingActionButton(this.x, this.y,
      {super.key, required super.onPressed, super.child, super.backgroundColor, super.splashColor});
}

void matrixColorUpdate(GState state, List<List<MaterialColor>> mat) {
  List<List<int>> allowed = state.pos;

  for( var i = 0; i < state.col; i++ ) {
    for( var j = 0; j < state.row; j++ ) {
      if (allowed[j][i] == 0) {
        mat[j][i] = Colors.lightBlue;
      } else if (allowed[j][i] == 1 ) {
        mat[j][i] = Colors.green;
      } else {
        mat[j][i] = Colors.amber;
      }
    }
  }
}

List<List<MaterialColor>> matrixColorSet(GState state) {
  List<List<int>> allowed = state.pos;
  var toReturn = List.generate(
      state.row, (i) => List.filled(state.col, Colors.lightBlue, growable: false),
      growable: false);

  for( var i = 0; i < state.col; i++ ) {
    for( var j = 0; j < state.row; j++ ) {
      if (allowed[j][i] == 0) {
        toReturn[j][i] = Colors.lightBlue;
      } else if (allowed[j][i] == 1 ) {
        toReturn[j][i] = Colors.green;
      } else {
        toReturn[j][i] = Colors.amber;
      }
    }
  }

  return toReturn;
}

List<List<MaterialAccentColor>> matrixColorSplashSet(GState state) {
  List<List<bool>> allowed = state.yMoves;
  if (state.greenTurn) {
    allowed = state.gMoves;
  }
  var toReturn = List.generate(
      state.row, (i) => List.filled(state.col,Colors.redAccent, growable: true),
      growable: false);
  for( var i = 0; i < state.col; i++ ) {
    for( var j = 0; j < state.row; j++ ) {
      if (allowed[j][i] == true) toReturn[j][i] = state.ac;
    }
  }

  return toReturn;
}


void matrixColorSplashUpdate(GState state, List<List<MaterialAccentColor>> mat) {
  List<List<bool>> allowed = state.yMoves;
  if (state.greenTurn) {
    allowed = state.gMoves;
  }
  for( var i = 0; i < state.col; i++ ) {
    for( var j = 0; j < state.row; j++ ) {
      if (allowed[j][i] == true) mat[j][i] = state.ac;
    }
  }


}

List<SizedBox> listMaker(List<List<MaterialColor>> mainCM, List<List<MaterialAccentColor>> mainCS, int row, int col, GState state,  Function(int x, int y, GState state) func) {
  List<SizedBox> toReturn = List.generate(
      col,
          (i) => SizedBox(
          width: 40,
          height: 40,
          child: MyFloatingActionButton(
            row,
            i % col,
            onPressed: () {
              func(row, i % col, state);
            },
            backgroundColor: mainCM[row][i % col],
            splashColor: mainCS[row][i % col],
            child: Text("($row, ${i % col})"),
          )));

  for (var i = col - 1; i >= 1; i -= 1) {
    toReturn.insert(
        i,
        SizedBox(
            width: 40,
            height: 10,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              child: null,
            )));
  }
  return toReturn;
}

List<SizedBox> listMaker2(int row, int col, GState state,  Function(int x, int y, GState state) func) {
  List<SizedBox> toReturn = List.generate(
      col,
          (i) => SizedBox(
          width: 40,
          height: 40,
          child: Center(
              child: SizedBox(
                  width: 10,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: null,
                  )))));

  for (var i = col - 1; i >= 1; i -= 1) {
    toReturn.insert(
        i,
        SizedBox(
            width: 40,
            height: 40,
            child: Column(
                children: List.generate(
                    2,
                        (i) =>Row(children: List.generate(2, (i) => SizedBox(
                        width: 20,
                        height: 20,
                        child: FloatingActionButton(onPressed: () {})))) ))));
  }
  return toReturn;
}

List<Row> listMaker3(List<List<MaterialColor>> mainCM, List<List<MaterialAccentColor>> mainCS, int row, int col, GState state, Function(int x, int y, GState state) func) {
  late var toReturn = List.generate(
      col,
          (i) => Row(
        children: listMaker(mainCM, mainCS, i, col, state, (i, col, state) => func(i, col, state)),
      ));

  for (var i = row - 1; i >= 1; i -= 1) {
    toReturn.insert(
        i,
        Row(
          children: listMaker2(i, col, state, (i, col, state) => func(i, col, state)),
        ));
  }

  return toReturn;
}

class Snakess extends StatefulWidget {
  const Snakess({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  final String title;
  @override
  State<Snakess> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Snakess> {

  static int row = 5;
  static int col = 5;
  late GState state = GenerateGState(row, col);
  late var movesMatrix = List.generate(
      row, (i) => List.filled(col, 0, growable: false),
      growable: false);

  late var mainColorMatrix = matrixColorSet(state);
  late var mainColorSplash = matrixColorSplashSet(state);



  void _makeTurn(int x, int y, GState state) {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      int posToken = -1;
      List<List<bool>> allowed = state.yMoves;

      List<List<bool>> enemy_allowed = state.gMoves;
      int myHeadX = state.yHeadX;
      int myHeadY = state.yHeadY;
      if (state.greenTurn) {
        allowed = state.gMoves;
        enemy_allowed = state.yMoves;
        posToken = 1;
        myHeadX = state.gHeadX;
        myHeadY = state.gHeadY;
      }
      print("HeadX: $myHeadX, HeadY: $myHeadY\n");
      print("x: $x, y: $y\n");
      int newHeadX = x;
      int newHeadY = y;
      if (allowed[x][y]) {
        //poruszanie się
        int toAddX = -1;
        int toAddY = -1;
        if (x < myHeadX) {
          toAddX = 1;
        }
        if (y < myHeadY) {
          toAddY = 1;
        }
        if (x == myHeadX) {
          toAddX = 0;
        }
        if (y == myHeadY) {
          toAddY = 0;
        }
        print("to add $toAddX, $toAddY\n");
        do {

          state.pos[x][y] = posToken;
          enemy_allowed[x][y] = false;
          allowed[x][y] = false;
          x+= toAddX;
          y+= toAddY;
          print("Pos added x: $x, y: $y\n");
        } while (x != myHeadX || y != myHeadY);
        // aktualizacja allowed:
        //Uwaga!!! Od nowa trzeba zrobić cały na false!!! Najlepiej zrobić funkcję, której ”edziemożna
        // użyć też przy inicjacji i tutaj...
        //
        state.greenTurn = !state.greenTurn;
        if (state.greenTurn == true) { //ruch wykonał żółty
          state.yHeadX = newHeadX;
          state.yHeadY = newHeadY;

          state.c = Colors.green;
          state.ac = Colors.greenAccent;
        }
        else{ //ruch wykonał zielony
          state.gHeadX = newHeadX;
          state.gHeadY = newHeadY;

          state.ac = Colors.amberAccent;
          state.c = Colors.amber;
        }


      }
      mainColorMatrix = matrixColorSet(state);
      mainColorSplash = matrixColorSplashSet(state);

    });
  }



  @override
  Widget build(BuildContext context) {
    late var buttonColumn =
    listMaker3(mainColorMatrix, mainColorSplash, row, col, state, (i, col, state) => _makeTurn(i, col, state));
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
      floatingActionButton:
      Column(children: [Spacer(flex: 50),
        Text(
          '${state.greenTurn}',

        ),
        Spacer(),
        Row(children: [
          Spacer(flex:2),
          FloatingActionButton(
            onPressed: () {
              setState(() {


              });
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
                movesMatrix = List.generate(
                    row, (i) => List.filled(col, 0, growable: false),
                    growable: false);
                mainColorMatrix = matrixColorSet(state);
                mainColorSplash = matrixColorSplashSet(state);
              });
            },
            tooltip: 'Reset',
            backgroundColor: Colors.redAccent,
            child: const Icon(Icons.refresh),
          ),
          const Spacer(),
          FloatingActionButton(
            onPressed: () {
              setState(() {


              });
            },
            tooltip: 'Green_Score',
            backgroundColor: Colors.amber,
            child: Text("${state.yScore}"),
          ),
          const Spacer(),
          FloatingActionButton(
            onPressed: () {
              setState(() {


              });
            },
            tooltip: 'Green_Score',
            backgroundColor: Colors.green,
            child: Text("${state.gScore}"),
          ),

          const Spacer(flex: 2)
        ]
        ),
        Spacer()
      ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
