// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyWidget());
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: Stack(
            children: [
              Container(
                child: Column(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                          width: MediaQuery.sizeOf(context).width,
                          // Image(image: AssetImage("images/background.jpg")),
                          color: Colors.green,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 75,
                                  backgroundImage:
                                      AssetImage("images/hammad.png"),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                  child: Text(
                                    "Hammad Rafique",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                  child: Text(
                                    "Python Develoepr",
                                    style: TextStyle(
                                      color: const Color.fromARGB(
                                          255, 209, 206, 206),
                                      fontSize: 18,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )),
                    ),
                    Expanded(
                      flex: 5,
                      child: Container(
                        color: Colors.grey[200],
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                top: MediaQuery.sizeOf(context).height * 0.31,
                left: 50,
                right: 50,
                child: Container(
                  height: MediaQuery.sizeOf(context).height * 0.66,
                  // color: Colors.black,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(10),
                        width: MediaQuery.sizeOf(context).width,
                        height: 110,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(color: Colors.grey, blurRadius: 5.0)
                            ]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                  child: Text(
                                    "Projects",
                                    style: TextStyle(
                                      color: Colors.grey[400],
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                Text(
                                  "22",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                )
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                  child: Text(
                                    "Birthday",
                                    style: TextStyle(
                                      color: Colors.grey[400],
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                Text(
                                  "January 22",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                )
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                  child: Text(
                                    "Age",
                                    style: TextStyle(
                                      color: Colors.grey[400],
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                Text(
                                  "22 yrs",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                          width: MediaQuery.sizeOf(context).width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(color: Colors.grey, blurRadius: 5.0)
                              ]),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    // color: Colors.amber,
                                  ),
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    "Information",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey,
                                              blurRadius: 5.0),
                                        ]
                                        // color: Colors.grey,
                                        ),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(20, 0, 0, 0),
                                          child: Image(
                                            image:
                                                AssetImage("images/home.png"),
                                            width: 80,
                                            height: 80,
                                          ),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  10, 0, 10, 0),
                                              child: Text(
                                                "Home Address",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  10, 0, 10, 0),
                                              child: Text(
                                                "Kacha Khu, Khanewal, Punjab, Pakistan",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey,
                                              blurRadius: 5.0),
                                        ]
                                        // color: Colors.green,
                                        ),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(20, 0, 0, 0),
                                          child: Image(
                                            image: AssetImage(
                                                "images/skills2.png"),
                                            width: 80,
                                            height: 80,
                                          ),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  10, 0, 10, 0),
                                              child: Text(
                                                "Skills",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  10, 0, 10, 0),
                                              child: Text(
                                                "Python Scripting, UI & UX Designing, App Development",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey,
                                              blurRadius: 5.0),
                                        ]
                                        // color: Colors.green,
                                        ),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(20, 0, 0, 0),
                                          child: Image(
                                            image:
                                                AssetImage("images/love.png"),
                                            width: 80,
                                            height: 80,
                                          ),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  10, 0, 10, 0),
                                              child: Text(
                                                "Hobbies",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  10, 0, 10, 0),
                                              child: Text(
                                                "Writing Python Scripts, Open-Source Project Contributions",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(20, 5, 20, 10),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey,
                                              blurRadius: 5.0),
                                        ]
                                        // color: Colors.green,
                                        ),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(20, 0, 0, 0),
                                          child: Image(
                                            image:
                                                AssetImage("images/email2.png"),
                                            width: 80,
                                            height: 80,
                                          ),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  10, 0, 10, 0),
                                              child: Text(
                                                "Contact Me",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  10, 0, 10, 0),
                                              child: Text(
                                                "pythondeveloper029@gmail.com",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            backgroundColor: Colors.green,
            child: Icon(Icons.add),
          )),
    );
  }
}
