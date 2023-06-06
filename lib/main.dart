import 'package:flutter/material.dart';
import 'tic-tac-toe.dart';
import 'dots_and_boxes.dart';
import 'snakess.dart';

const bgColor = Color(0xFFFCEE0C);
const highlightColor = Color(0xFF03D8F3);

void main() {
  runApp(const MaterialApp(
    home: Home(),
  ));
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
        ),
      ),
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
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        "GAMES :D",
                        style: TextStyle(
                          fontSize: constraints.maxWidth * 0.45,
                          color: highlightColor,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            GameButton("tic-tac-toe"),
            GameButton("dots-and-boxes"),
            GameButton("snakess"),
          ],
        ),
      ),
    );
  }
}

class GameButton extends StatelessWidget {
  final String name;

  const GameButton(this.name, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.1,
        child: ElevatedButton(
          onPressed: () {
            switch (name) {
              case "tic-tac-toe":
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const MyHomePage(title: 'Gomoku')), // or Gomoku()
                );
                break;
              case "dots-and-boxes":
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                      const DotsAndBoxes(title: 'Dots and Boxes')), // or Gomoku()
                );
                break;
              case "snakess":
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                      const Snakess(title: 'Snakess')), // or Gomoku()
                );
                break;
              // add more cases for each game
              default:
                break;
            }
          },
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(0),
            backgroundColor: MaterialStateProperty.all<Color>(highlightColor),
          ),
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  name,
                  style: TextStyle(
                    fontSize: constraints.maxHeight * 0.5,
                    color: bgColor,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
