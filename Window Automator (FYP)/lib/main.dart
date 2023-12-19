// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'Models/libs.dart';
import 'Models/functions.dart';
import 'tapToSpeask.dart';
import 'Models/settings.dart';
import 'Settings.dart';
import 'chat.dart';
import 'api.dart';
// import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
  // runApp(WhispherAPI());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
      theme: ThemeData(
        scaffoldBackgroundColor: priClr, // Replace with your desired color
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController textCommand = TextEditingController();
  bool clearText = false;

  void openDialog(BuildContext context) {
    textCommand.text = userCommand;
    userCommand.isNotEmpty ? clearText = true : clearText = false;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: const Color.fromARGB(0, 255, 255, 255),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: SingleChildScrollView(
            child: Container(
                width: cstmWidth(context, 0.8),
                height: 50,
                padding: cstmPad(0, 10, 0, 10),
                decoration: cstmBoxDec(secClr, 1, whiteClr, 10, 2, shadowClr),
                child: Row(
                  children: [
                    Expanded(
                      //   child: RawKeyboardListener(
                      // focusNode: FocusNode(),
                      // onKey: (RawKeyEvent event) {
                      //   if (event is RawKeyDownEvent) {
                      //     if (event.logicalKey == LogicalKeyboardKey.backspace) {
                      //       setState(() {
                      //         clearText = true;
                      //       });
                      //       print("## Backspace key pressed!");
                      //     } else {
                      //       setState(() {
                      //         clearText = false;
                      //       });
                      //     }
                      //   }
                      // },
                      child: TextField(
                        controller: textCommand,
                        style: TextStyle(color: whiteClr),
                        decoration: InputDecoration(
                          hintText: "Enter your command ...",
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: whiteClr),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          userCommand = textCommand.text;
                          Navigator.pop(context, textCommand.text);
                        });
                      },
                      child: Icon(
                        Icons.send_rounded,
                        color: whiteClr,
                      ),
                    )
                  ],
                )),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var checkAllPermissions = CheckPermission();
    var getPathFile = DirectoryPath();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: secClr,
          title: cstmTextBox("Mag - Window Automator", whiteClr, 19),
          actions: [
            Padding(
              padding: cstmPadAll(10.0),
              child: GestureDetector(
                  onTap: () {
                    try {
                      // settingsPageButton(context);
                      setState(() async {
                        var result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SettingsPage()),
                        );
                        setState(() {
                          print("@@ Loaded");
                        });
                      });
                    } catch (e) {
                      print("@@ Error Occured");
                    }
                    ;
                  },
                  child: cstmIcon(Icons.settings, whiteClr)),

              // child: cstmGstDect(settingsPageButton,
              //     cstmIcon(Icons.settings, whiteClr), context),
            ),
          ],
        ),
        body: GestureDetector(
          onHorizontalDragEnd: (details) async {
            if (details.primaryVelocity! < 0) {
              setState(() async {
                var result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CommadChat()),
                );
                setState(() {});
              });
            }
          },
          child: Container(
            color: priClr,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  taskBarWidget(context),
                  systemInfo_CommadProcesing_Widget(context),
                  predefinedCommandWidget(context),
                  textualCommandWidget(context),
                ],
              ),
            ),
          ),
        ));
  }

  Widget textualCommandWidget(context) {
    return Container(
      padding: cstmPad(0, 5, 0, 5),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: cstmPadAll(12),
              decoration: cstmBoxDec(secClr, 1, whiteClr, 10, 2, shadowClr),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(
                          () {
                            openDialog(context);
                          },
                        );
                      },
                      child: cstmTextBox(
                        userCommand != ""
                            ? userCommand.length > 35
                                ? "${userCommand.substring(0, 35)}..."
                                : userCommand
                            : "Enter your command...",
                        whiteClr,
                        15,
                      ),
                    ),
                  ),
                  userCommand.isNotEmpty
                      ? GestureDetector(
                          onTap: () {
                            setState(() {
                              if (clearText) {
                                userCommand = "";
                                textCommand.text = "";
                                clearText = false;
                              } else {
                                userCommand = textCommand.text;
                              }
                            });
                          },
                          child: Icon(Icons.clear_sharp, color: whiteClr),
                        )
                      : Container()
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            onPressed: () {
              sendCommandButton();
            },
            child: const Text("Send"),
          ),
        ],
      ),
    );
  }
}

// ################################################################
//          Task Bar Command Processing Widget
Widget taskBarWidget(context) {
  return Container(
    width: cstmWidth(context, 1),
    height: 40,
    color: priClr,
    child: Center(
      child: cstmTextBox(processingCommandMessage, taskBarClr, 13.0),
    ),
  );
}

// ################################################################
//      System Information AND Mic Listening Widget
Widget systemInfo_CommadProcesing_Widget(context) {
  return Container(
    width: cstmWidth(context, 1),
    height: cstmHeight(context, 0.6),
    // color: Colors.greenAccent,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        showSystemUsageInfo ? systemInfo(context, systemUsage) : Container(),
        const SizedBox(height: 40),
        Mice()
      ],
    ),
  );
}

Widget systemInfo(BuildContext context, Map<String, int> data) {
  List<Widget> info = [];

  data.forEach((key, value) {
    info.add(Container(
      width: cstmWidth(context, 0.28),
      padding: cstmPadAll(5.0),
      margin: cstmPad(0, 10, 0, 0),
      decoration: cstmBoxDec(
          priClr, 1.0, shadowClr, 10.0, 0, Color.fromRGBO(255, 218, 218, 1)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          cstmTextBox(key, Colors.white, 12),
          cstmTextBox("${value}%", Colors.white, 12),
        ],
      ),
    ));
  });
  return Row(mainAxisAlignment: MainAxisAlignment.center, children: info);
}

// ################################################################
//              Predefined Commands Widget
Widget predefinedCommandWidget(context) {
  return Container(
    padding: cstmPad(cstmWidth(context, 0.06), 0, cstmWidth(context, 0.06), 0),
    width: cstmWidth(context, 1),
    height: cstmHeight(context, 0.2),
    // color: Colors.blueAccent,
    child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: predefinedCommands(context),
      ),
    ),
  );
}

List<Widget> predefinedCommands(BuildContext context) {
  List<Widget> commands = [];
  predefinedCommandsDataset.forEach((key, value) {
    commands.add(
      Padding(
        padding: cstmPad(0, 0, 0, 15),
        child: GestureDetector(
          onTap: value,
          child: cstmTextBox(key, textClr1, 17),
        ),
      ),
    );
  });
  return commands;
}
