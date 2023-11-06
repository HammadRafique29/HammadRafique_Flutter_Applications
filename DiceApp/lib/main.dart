import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MaterialApp(home: DiceGame()));
}

class DiceGame extends StatefulWidget {
  const DiceGame({super.key});

  @override
  State<DiceGame> createState() => _DiceGameState();
}

class _DiceGameState extends State<DiceGame> {
  int diceFace = 1;

  Map<String, List> diceData = {
    "Player 1": [1, 0],
    "Player 2": [1, 0],
    "Player 3": [1, 0],
    "Player 4": [1, 0],
  };
  Map<String, List> PlayerScore = {
    "Winning": ['Player 1', 0],
    "2nd Position": ['Player 2', 0],
    "3rd Position": ['Player 3', 0],
    "4th Position": ['Player 4', 0],
  };
  String playerTurn = "Player 1";
  int temp = 1;
  int TotalTurns = 2;

  void changeDiceFace(String Player) {
    setState(() {
      if (Player == playerTurn) {
        diceFace = Random().nextInt(6) + 1;
        diceData[Player]?[1] += diceFace;
        diceData[Player]?[0] = diceFace;

        var sortedEntries = diceData.entries.toList()
          ..sort((a, b) => b.value[1].compareTo(a.value[1]));

        print(sortedEntries);
        if (temp < 4) {
          temp = temp + 1;
          playerTurn = "Player ${temp}";
        } else {
          playerTurn = "Player 1";
          temp = 1;
        }

        print("$playerTurn  $temp");

        for (var i = 0; i < sortedEntries.length; i++) {
          var player = sortedEntries[i].key;
          var score = sortedEntries[i].value[1];
          var position = '';

          if (i == 0) {
            position = "Winning";
          } else if (i == 1) {
            position = "2nd Position";
          } else if (i == 2) {
            position = "3rd Position";
          } else {
            position = "4th Position";
          }
          PlayerScore[position] = [player, score];
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            image: const AssetImage("images/background.png"),
            fit: BoxFit.fill,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.035),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      // width: 170.0,
                      height: 90.0,
                      // color: Colors.amber,
                      child: Row(
                        children: [
                          const Image(
                            width: 90.0,
                            height: 90.0,
                            image: AssetImage("images/player1.png"),
                            fit: BoxFit.fill,
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 10.0, top: 0.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    changeDiceFace("Player 1");
                                    // print("$diceFace");
                                  },
                                  child: Image(
                                      width: 40.0,
                                      height: 40.0,
                                      image: AssetImage(
                                          "images/dice${diceData['Player 1']?[0]}.png")),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 5.0),
                                  child: Text(
                                    "Score:",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 0.0),
                                  child: Text(
                                    "${diceData['Player 1']?[1]} Points",
                                    style: TextStyle(
                                      color: const Color.fromARGB(
                                          255, 230, 221, 197),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      // width: 170.0,
                      height: 90.0,
                      // color: Colors.amber,
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 10.0, top: 3.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    changeDiceFace("Player 2");
                                    // print("$diceFace");
                                  },
                                  child: Image(
                                      width: 40.0,
                                      height: 40.0,
                                      image: AssetImage(
                                          "images/dice${diceData['Player 2']?[0]}.png")),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 5.0),
                                  child: Text(
                                    "Score:",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 2.0),
                                  child: Text(
                                    "${diceData['Player 2']?[1]} Points",
                                    style:
                                        TextStyle(color: Colors.amber.shade500),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Image(
                            width: 90.0,
                            height: 90.0,
                            image: AssetImage("images/player2.png"),
                            fit: BoxFit.fill,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      // width: 170.0,
                      height: 90.0,
                      // color: Colors.amber,
                      child: Container(
                        // margin: EdgeInsets.only(top: 200.0),
                        child: Row(
                          children: [
                            const Image(
                              width: 90.0,
                              height: 90.0,
                              image: AssetImage("images/player3.png"),
                              fit: BoxFit.fill,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10.0, top: 3.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      changeDiceFace("Player 3");
                                      // print("$diceFace");
                                    },
                                    child: Image(
                                        width: 40.0,
                                        height: 40.0,
                                        image: AssetImage(
                                            "images/dice${diceData['Player 3']?[0]}.png")),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 5.0),
                                    child: Text(
                                      "Score:",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 2.0),
                                    child: Text(
                                      "${diceData['Player 3']?[1]} Points",
                                      style: TextStyle(
                                        color: Colors.amber.shade500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )),
                  Container(
                    // width: 170.0,
                    height: 90.0,
                    // color: Colors.amber,
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 10.0, top: 3.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  changeDiceFace("Player 4");
                                  // print("$diceFace");
                                },
                                child: Image(
                                    width: 40.0,
                                    height: 40.0,
                                    image: AssetImage(
                                        "images/dice${diceData['Player 4']?[0]}.png")),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 5.0),
                                child: Text(
                                  "Score:",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 2.0),
                                child: Text(
                                  "${diceData['Player 4']?[1]} Points",
                                  style:
                                      TextStyle(color: Colors.amber.shade500),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Image(
                          width: 90.0,
                          height: 90.0,
                          image: AssetImage("images/player4.png"),
                          fit: BoxFit.fill,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.2,
            left: MediaQuery.of(context).size.width * 0.14,
            child: Container(
                width: MediaQuery.of(context).size.width * 0.75,
                height: MediaQuery.of(context).size.height * 0.55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: const Color.fromRGBO(86, 174, 255, 1),
                ),
                child: Container(
                    margin: const EdgeInsets.only(top: 30.0, bottom: 10.0),
                    child: Wrap(
                      children: [
                        Column(
                          children: [
                            const Text("Player Board",
                                style: TextStyle(
                                    fontSize: 25, color: Colors.white)),
                            Container(
                              margin: EdgeInsets.only(top: 10.0),
                              width: MediaQuery.sizeOf(context).width * 0.8,
                              height: 100.0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image(
                                      width: 80,
                                      height: 80,
                                      image: AssetImage("images/1_pos.png")),
                                  Container(
                                    margin: EdgeInsets.only(left: 10.0),
                                    width: 180.0,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              width: 65.0,
                                              child: Text(
                                                "Winning",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color:
                                                        Colors.amber.shade500),
                                              ),
                                            ),
                                            Container(
                                              width: 100.0,
                                              child: Text(
                                                "${PlayerScore?['Winning']?[0]}",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "Score: ${PlayerScore?['Winning']?[1]}",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.sizeOf(context).width * 0.8,
                              height: 100.0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image(
                                      width: 80,
                                      height: 80,
                                      image: AssetImage("images/2_pos.png")),
                                  Container(
                                    margin: EdgeInsets.only(left: 10.0),
                                    width: 180.0,
                                    // color: Colors.white,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              width: 90.0,
                                              child: Text(
                                                "2nd Position",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color:
                                                        Colors.amber.shade500),
                                              ),
                                            ),
                                            Container(
                                              width: 80.0,
                                              child: Text(
                                                "${PlayerScore?['2nd Position']?[0]}",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "Score: ${PlayerScore?['2nd Position']?[1]}",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              // color: Colors.white,
                              // width: MediaQuery.sizeOf(context).width * 0.8,
                              height: 100.0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image(
                                      width: 80,
                                      height: 80,
                                      image: AssetImage("images/3_pos.png")),
                                  Container(
                                    margin: EdgeInsets.only(left: 10.0),
                                    width: 180.0,
                                    // color: Colors.white,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              width: 90.0,
                                              child: Text(
                                                "3rd Position",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color:
                                                        Colors.amber.shade500),
                                              ),
                                            ),
                                            Container(
                                              width: 80.0,
                                              child: Text(
                                                "${PlayerScore?['3rd Position']?[0]}",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "Score: ${PlayerScore?['3rd Position']?[1]}",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: 270.0,
                              height: 100.0,
                              child: Row(
                                children: [
                                  Image(
                                      width: 80,
                                      height: 80,
                                      image: AssetImage("images/4_pos.png")),
                                  Container(
                                    margin: EdgeInsets.only(left: 10.0),
                                    width: 180.0,
                                    // color: Colors.white,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              width: 90.0,
                                              child: Text(
                                                "4th Position",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color:
                                                        Colors.amber.shade500),
                                              ),
                                            ),
                                            Container(
                                              width: 80.0,
                                              child: Text(
                                                "${PlayerScore?['4th Position']?[0]}",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "Score: ${PlayerScore?['4th Position']?[1]}",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ))),
          ),
        ],
      ),
    );
  }
}
