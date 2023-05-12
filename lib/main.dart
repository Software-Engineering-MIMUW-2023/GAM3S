import 'package:flutter/material.dart';

import 'package:io_app/tic-tac-toe.dart';

const bgColor = Color(0xFFFCEE0C);
const highlightColor = Color(0xFF03D8F3);

void main() {
  runApp(const MaterialApp(
    home: Gomoku(),
  ));

  // runApp(const MaterialApp(
  //   home: Home(),
  // ));
}


class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor,
        floatingActionButton: FloatingActionButton(
            backgroundColor: bgColor,
            elevation: 0,
            onPressed: () {},
            child: const Icon(
              Icons.settings,
              color: highlightColor,
              size: 50,
            )),
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        body: Center(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                        width: double.infinity,
                        child: LayoutBuilder(
                          builder: (BuildContext context,
                              BoxConstraints constraints) {
                            return FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                "GAMES :D",
                                style: TextStyle(
                                  fontSize: constraints.maxWidth * 0.45,
                                  // height: 0.5,
                                  color: highlightColor,
                                ),
                              ),
                            );
                          },
                        ))),
                GameButton("game 1"),
                GameButton("game 2"),
                GameButton("game 3"),
              ]),
        ));
  }
}

class GameButton extends StatelessWidget {
  final String name;

  const GameButton(this.name, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.1,
          child: ElevatedButton(
              onPressed: () {
                // todo add code to start game
              },
              style: const ButtonStyle(
                elevation: MaterialStatePropertyAll(0),
                backgroundColor:
                    MaterialStatePropertyAll<Color>(highlightColor),
              ),
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(name,
                          style: TextStyle(
                            fontSize: constraints.maxHeight * 0.5,
                            color: bgColor,
                          )));
                },
              )),
        ));
  }
}
