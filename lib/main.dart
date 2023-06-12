import 'package:flutter/material.dart';
import 'tic-tac-toe.dart';
import 'dots_and_boxes.dart';
import 'snakess.dart';

const bgColor =Colors.white;
const highlightColor = Colors.lightBlue;

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
            backgroundColor: highlightColor,
            elevation: 0,
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text(
                      'How to play',
                      style: TextStyle(
                        fontSize: 40,
                        color: highlightColor,
                        backgroundColor: bgColor,
                      ),
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: const Text(
                            'Tic-Tac-Toe',
                            style: TextStyle(
                              fontSize: 30,
                              color: highlightColor,
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).pop();
                            showHowToPlay(
                                context,
                                'Tic-Tac-Toe is a classic game played on a 3x3 grid. The game involves two players, represented by X and O, taking turns to mark empty cells on the grid. The objective is to form a line of three of your own marks (horizontally, vertically, or diagonally) before the opponent does.\n\n'
                                    'The game starts with an empty grid, and players take turns placing their marks in any available cell. Once a player successfully forms a line of three marks, they win the game. If all cells are filled without any player achieving a winning line, the game ends in a draw. The game can be played repeatedly, with players taking turns to make their moves until a winner is determined or the game ends in a draw.');
                          },
                        ),
                        ListTile(
                          title: const Text(
                            'Dots and Boxes',
                            style: TextStyle(
                              fontSize: 30,
                              color: highlightColor,
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).pop();
                            showHowToPlay(context, '1. Players take turns connecting two adjacent dots with a line.\n'
                            '2. When a player completes a box, they claim it and get an extra turn.\n'
                            '3. The game ends when all dots are connected.\n'
                            '4. The player with the most claimed boxes wins.\n');
                          },
                        ),
                        ListTile(
                          title: const Text(
                            'Snakess',
                            style: TextStyle(
                              fontSize: 30,
                              color: highlightColor,
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).pop();
                            showHowToPlay(context, "Snake Game Rules:\n\n"
"The Snake game is played by two players. At the beginning of the game, each player's snake is located at one of the corners of the board and consists only of a head. The head of each snake is marked with the letter 'S'.\n\n"
"During the game, players take turns moving their snakes on the board. To move a snake, a player must tap on an empty tile that is in the same row, column, or diagonal as the snake's head. The tile should not be already occupied by the other player.\n\n"
"The goal of the game is to cross the enemy snake as many times as possible. The player with the highest number of crossings wins.\n\n"
"To cross an enemy snake, a player must move their snake through the area where the enemy snake lies. This can be done by passing through the head, body, or tail of the enemy snake. In one turn, only one point can be gained by crossing the enemy snake, regardless of how many times it is crossed. There is no penalty for crossing your own snake.\n");
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            child: const Icon(
              Icons.question_mark_outlined,
              color: bgColor,
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
                                "GAMES",
                                style: TextStyle(
                                  fontSize: constraints.maxWidth * 0.45,
                                  // height: 0.5,
                                  color: highlightColor,
                                ),
                              ),
                            );
                          },
                        ))),
                GameButton("tic-tac-toe"),
                GameButton("dots-and-boxes"),
                GameButton("snakess"),
              ]),
        ));
  }

  void showHowToPlay(BuildContext context, String text) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close),
                      color: highlightColor,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
                Text(
                  text,
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
        );
      },
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
