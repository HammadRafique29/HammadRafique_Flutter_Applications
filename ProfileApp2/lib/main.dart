import 'package:flutter/material.dart';

void main() {
  runApp(const Profile());
}

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            Container(
              height: MediaQuery.sizeOf(context).height,
              color: Colors.white54,
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.sizeOf(context).height * 0.4,
                    color: Colors.blue,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 80,
                            backgroundImage: AssetImage("images/hammad.png"),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Text(
                              "Hammad Rafique",
                              style:
                                  TextStyle(fontSize: 25, color: Colors.white),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Text(
                              "Python Developer",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: MediaQuery.sizeOf(context).height * 0.35,
              left: MediaQuery.sizeOf(context).width * 0.1,
              child: Container(
                width: MediaQuery.sizeOf(context).width * 0.8,
                height: MediaQuery.sizeOf(context).height * 0.63,
                // color: Colors.white54,
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.sizeOf(context).width * 0.7,
                      height: MediaQuery.sizeOf(context).height * 0.09,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(color: Colors.black38, blurRadius: 5)
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Photo Uploads",
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Color.fromRGBO(174, 177, 181, 1),
                                ),
                              ),
                              Text(
                                "150+",
                                style: TextStyle(fontSize: 20),
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Followers",
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Color.fromRGBO(174, 177, 181, 1),
                                ),
                              ),
                              Text(
                                "1036",
                                style: TextStyle(fontSize: 20),
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Following",
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Color.fromRGBO(174, 177, 181, 1),
                                ),
                              ),
                              Text(
                                "256",
                                style: TextStyle(fontSize: 20),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      width: MediaQuery.sizeOf(context).width * 0.9,
                      height: MediaQuery.sizeOf(context).height * 0.49,
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            width: MediaQuery.sizeOf(context).width * 0.7,
                            height: MediaQuery.sizeOf(context).height * 0.04,
                            child: Text(
                              "User Information",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(color: Colors.black12, blurRadius: 7)
                            ]),
                            child: Card(
                              child: SizedBox(
                                height: MediaQuery.sizeOf(context).height * 0.1,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ListTile(
                                      leading: Image(
                                          width: 40,
                                          height: 40,
                                          image: AssetImage("images/home.png")),
                                      title: Text("Location"),
                                      subtitle:
                                          Text("Kacha Khuh, Punjab, Pakistan"),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(color: Colors.black12, blurRadius: 7)
                            ]),
                            child: Card(
                              child: SizedBox(
                                height: MediaQuery.sizeOf(context).height * 0.1,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ListTile(
                                      leading: Image(
                                          width: 40,
                                          height: 40,
                                          image:
                                              AssetImage("images/skills2.png")),
                                      title: Text("Skills"),
                                      subtitle: Text(
                                          "Python Scripting, UI & UX Designing, App Development"),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(color: Colors.black12, blurRadius: 7)
                            ]),
                            child: Card(
                              child: SizedBox(
                                height: MediaQuery.sizeOf(context).height * 0.1,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ListTile(
                                      leading: Image(
                                          width: 40,
                                          height: 40,
                                          image: AssetImage("images/love.png")),
                                      title: Text("Hobbies"),
                                      subtitle: Text(
                                          "Writing Python Scripts, Solving Puzzles"),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(color: Colors.black12, blurRadius: 7)
                            ]),
                            child: Card(
                              child: SizedBox(
                                height: MediaQuery.sizeOf(context).height * 0.1,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ListTile(
                                      leading: Image(
                                          width: 40,
                                          height: 40,
                                          image:
                                              AssetImage("images/email.png")),
                                      title: Text("Contact"),
                                      subtitle:
                                          Text("pythondeveloper029@gmail.com"),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
