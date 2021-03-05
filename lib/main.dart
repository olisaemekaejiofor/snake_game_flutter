import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Snake',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainGame(),
    );
  }
}

class MainGame extends StatefulWidget {
  @override
  _MainGameState createState() => _MainGameState();
}

class _MainGameState extends State<MainGame> {
  static List<int> snakePosition = [];
  int numberOfBoxes = 252;

  static var randomNumber = Random();
  int food = randomNumber.nextInt(252);

  void generateFood() {
    food = randomNumber.nextInt(252);
  }

  void startGame() {
    snakePosition = [];
    const duration = const Duration(milliseconds: 300);
    Timer.periodic(duration, (Timer timer) {
      // updateSnake();
      // if (passedOver()) {
      //   timer.cancel();
      //   _showGameOverScreen();
      // }
    });

    var direction = 'right';
    void updateSnake() {
      setState(() {
        switch (direction) {
          case 'down':
            if (snakePosition.last > 252) {
              snakePosition.add(snakePosition.last * 20 - 252);
            } else {
              snakePosition.add(snakePosition.last * 20);
            }
            break;

          case 'up':
            if (snakePosition.last < 20) {
              snakePosition.add(snakePosition.last - 20 * 252);
            } else {
              snakePosition.add(snakePosition.last - 20);
            }
            break;

          case 'left':
            if (snakePosition.last % 20 == 0) {
              snakePosition.add(snakePosition.last - 1 - 20);
            } else {
              snakePosition.add(snakePosition.last - 1);
            }
            break;

          case 'right':
            if (snakePosition.last % 20 == 0) {
              snakePosition.add(snakePosition.last * 1 - 20);
            } else {
              snakePosition.add(snakePosition.last * 1);
            }
            break;

          default:
        }

        if (snakePosition.last == food) {
          generateNewFood();
        } else {
          snakePosition.removeAt(0);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 100,
            width: double.infinity,
            color: Color(0xff4A752C),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 30.0,
                vertical: 10.0,
              ),
              child: Row(),
            ),
          ),
          Expanded(
            child: Container(
              color: Color(0xff578A34),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 30,
                ),
                child: Expanded(
                  child: GestureDetector(
                    onVerticalDragUpdate: (details) {
                    //   if (direction != 'up' && details.delta.dy > 0) {
                    //     direction = 'down';
                    //   } else if (direction != 'down' && details.delta.dy < 0) {
                    //     direction = 'up';
                    //   }
                    // },

                    // onHorizontalDragUpdate: (details){
                    //   if (direction != 'left' && details.delta.dx > 0) {
                    //     direction = 'right';
                    //   } else if (direction != 'right' && details.delta.dx < 0) {
                    //     direction = 'left';
                    //   }
                    // },
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xffAAD751),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: numberOfBoxes,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 12),
                        itemBuilder: (BuildContext context, int index) {
                          if (snakePosition.contains(index)) {
                            return Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xff4674E9),
                                  borderRadius: BorderRadius.circular(7),
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
