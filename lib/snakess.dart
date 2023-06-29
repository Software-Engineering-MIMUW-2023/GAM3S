import 'dart:math';

import 'package:flutter/material.dart';

// Class that keeps a state of the game. By modifying data in it one can
// manipulate the look and functionality of screen widgets
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
  String result = "";
  bool gMobility = true;
  bool yMobility = true;
  List<List<int>> pos = [];
  List<List<bool>> gMoves = [];
  List<List<bool>> yMoves = [];
  List<List<bool>> cMoves = [];
  GState(this.greenTurn, this.gHeadX, this.gHeadY, this.yHeadX, this.yHeadY, this.row, this.col);
}

// Map for mapping the int value into colors of main buttons
Map<int, Color> setColor = {
  -1: Colors.amber,
  0: Colors.lightBlue,
  1: Colors.green,
};

// Mapping true/false value to player color
Map<bool, Color> setPlayerCol  = {
  false: Colors.amber,
  true: Colors.green,
};

// Mapping the color of first player depending of whether he can push the button.
// If button is not available for player it should turn red.
Map<bool, Color> setColorGSPlash = {
  false: Colors.redAccent,
  true: Colors.greenAccent,
};

Map<bool, Color> setColorASPlash = {
  false: Colors.redAccent,
  true: Colors.amberAccent,
};

Map<bool, Map<bool, Color>> setColorSplash  = {
  false: setColorASPlash,
  true: setColorGSPlash,
};


class MyWidget extends StatefulWidget {
  const MyWidget({super.key});
  @override
  State<StatefulWidget> createState() {
    throw UnimplementedError();
  }
}

// This function is use to modify game state. It changes the possible moves
// array for current player.
List<dynamic> UpdateXState(int row, int col, List<List<int>> pos, int xHeadX, int xHeadY){
  List<List<bool>> xMoves =   List.generate(
      row, (i) => List.filled(col, false, growable: false),
      growable: false);
  bool moves = false;

  // Horizontal position.
  for (var i = 0; i < col; i++) {
    if (pos[xHeadX][i] == 0) {
      xMoves[xHeadX][i] = true;
      moves = true;
    }
  }

  // Vertical position.
  for (var i = 0; i < row; i++) {
    if (pos[i][xHeadY] == 0) {
      xMoves[i][xHeadY] = true;
      moves = true;
    }
  }

  // Cross from left down to right up.
  int delta = min(xHeadY, row-1-xHeadX);
  int px = xHeadX + delta;
  int py = xHeadY - delta;

  while(px != -1 && py != col) {
    if (pos[px][py] == 0) {
      xMoves[px][py] = true;
      moves = true;
    }
    py+=1;
    px-=1;
  }

  // Cross from left up to right down
  delta = min(xHeadY, xHeadX);
  px = xHeadX - delta;
  py = xHeadY - delta;

  while(px != row && py != col) {
    if (pos[px][py] == 0) {
      xMoves[px][py] = true;
      moves = true;
    }
    py+=1;
    px+=1;
  }
  return [xMoves,moves];
}

// Function for generating simple mono color lists of buttons.
List<List<int>> monoListPost(int row, int col, int winner) {
  List<List<int>> ret;
  if (winner == 0) {
      ret = List.generate(
        row, (i) => List.filled(col, 1 -2* (i%2), growable: false));

  }
  else {
    ret  = List.generate(
        row, (i) => List.filled(col, winner, growable: false));
  }
   return ret;
}


// Function for generating starting state.
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
    if (i == row || col - 1 - i < 0) break;
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
    if (i == row || col - 1 - i < 0) break;
    state.gMoves[i][col - 1 - i] = true;
  }
  state.cMoves = state.gMoves;

  return state;
}

class MyFloatingActionButton extends FloatingActionButton {
  final int x;
  final int y;
  const MyFloatingActionButton(this.x, this.y,
      {super.key, required super.onPressed, super.child, super.backgroundColor, super.splashColor, super.heroTag});
}

String whereIsHead(int x, int y,GState state) {
  String ret = "";
  if (x == state.gHeadX && y == state.gHeadY) {
    ret += "S";
  }
  if (x == state.yHeadX && y == state.yHeadY) {
    ret += "S";
  }
  return ret;
}

// Functions for generating proper buttons grid.
List<SizedBox> listMaker(int row, int col, GState state,  Function(int x, int y, GState state) func) {
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
            backgroundColor: setColor[state.pos[row][i % col]],
            splashColor: (setColorSplash[state.greenTurn])![state.cMoves[row][i % col]],
            //child: Text("($row, ${i % col})"),
            heroTag: null,
            child: Text(whereIsHead(row, i % col, state)),
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
                        (j) =>Row(children: List.generate(2, (j) => SizedBox(
                        width: 20,
                        height: 20,
                        child: FloatingActionButton(heroTag:null, onPressed: () {})))) ))));
  }

  return toReturn;
}

List<Row> listMaker3(int row, int col, GState state, Function(int x, int y, GState state) func) {

  late var toReturn = List.generate(
      row,
          (i) => Row(
        children: listMaker(i, col, state, (i, col, state) => func(i, col, state)),
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

  // Game also works for any other sizes (min value is 2).
  static int row = 5;
  static int col = 5;
  late GState state = GenerateGState(row, col);

  void _makeTurn(int x, int y, GState state) {
    setState(() {
      int posToken = -1;
      List<List<bool>> allowed = state.yMoves;
      List<List<bool>> enemy_allowed = state.gMoves;
      int myHeadX = state.yHeadX;
      int myHeadY = state.yHeadY;

      int toadd = 0;
      if (state.greenTurn) {

        allowed = state.gMoves;
        enemy_allowed = state.yMoves;
        posToken = 1;
        myHeadX = state.gHeadX;
        myHeadY = state.gHeadY;
      }
      //print("HeadX: $myHeadX, HeadY: $myHeadY\n");
      //print("x: $x, y: $y\n");
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
        //print("to add $toAddX, $toAddY\n");
        do {
          if (state.pos[x][y]  == -posToken) toadd = 1;
          state.pos[x][y] = posToken;
          enemy_allowed[x][y] = false;
          allowed[x][y] = false;
          x+= toAddX;
          y+= toAddY;
          //print("Pos added x: $x, y: $y\n");
        } while (x != myHeadX || y != myHeadY);
        state.greenTurn = !state.greenTurn;

        if (state.greenTurn == true) { //ruch wykonał żółty
          state.yScore += toadd;
          state.yHeadX = newHeadX;
          state.yHeadY = newHeadY;
          var updated =  UpdateXState(state.row,state.col, state.pos, state.gHeadX, state.gHeadY);
          state.gMoves = updated[0];
          state.gMobility = updated[1];
          state.cMoves = state.gMoves;

          if (updated[1] == false) {
            state.greenTurn = false;
            var updated =  UpdateXState(state.row,state.col, state.pos, state.yHeadX, state.yHeadY);
            state.yMoves = updated[0];
            state.yMobility = updated[1];
            state.cMoves = state.yMoves;
          }
        }
        else{ //ruch wykonał zielony
          state.gHeadX = newHeadX;
          state.gHeadY = newHeadY;
          state.gScore += toadd;
          var updated = UpdateXState(state.row,state.col, state.pos, state.yHeadX, state.yHeadY);
          state.yMoves = updated[0];
          state.yMobility = updated[1];
          state.cMoves = state.yMoves;

          if (updated[1] == false) {
            state.greenTurn = true;
            var updated =  UpdateXState(state.row,state.col, state.pos, state.gHeadX, state.gHeadY);
            state.gMoves = updated[0];
            state.gMobility = updated[1];
            state.cMoves = state.gMoves;
          }
        }

        if (! state.yMobility || ! state.gMobility) {
          if (state.gScore > state.yScore && state.yMobility == false){
            state.result = "Green wins!!!";
            state.pos =  monoListPost(state.row, state.col, 1);
          }
          else if (state.gScore < state.yScore && state.gMobility == false) {
            state.result = "Yellow wins!!!";
            state.pos =  monoListPost(state.row, state.col, -1);
          }
          else if (state.gMobility == false && state.yMobility == false) {
            state.result = "Remis!!!";
            state.pos =  monoListPost(state.row, state.col, 0);
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    late var buttonColumn =
    listMaker3(row, col, state, (i, col, state) => _makeTurn(i, col, state));
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
        child: Column(children:  <Widget>[Spacer(),
          Text(
            state.result,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Spacer(),
          Expanded(flex: 10,child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                  color: Colors.lightBlueAccent,
                  child: Column(children: buttonColumn)),
            ),
          ),),
          Spacer(),
          Row(children: [
            Spacer(flex:2),
            FloatingActionButton(
              heroTag: null,
              onPressed: () {
                setState(() {


                });
              },
              tooltip: 'Player',
              backgroundColor: setPlayerCol[state.greenTurn],
              child: const Icon(Icons.accessibility_new),
            ),
            Spacer(),
            FloatingActionButton(
              heroTag: null,
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
              heroTag: null,
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
              heroTag: null,
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
      ),
    );
  }
}
