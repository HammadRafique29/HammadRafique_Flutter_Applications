import 'package:flutter/material.dart';
import 'Models/libs.dart';
import 'Models/functions.dart';
import 'Models/settings.dart';
import 'Settings.dart';
import 'dart:io';
import 'package:open_file/open_file.dart';
import 'api.dart';

class CommadChat extends StatefulWidget {
  const CommadChat({super.key});

  @override
  State<CommadChat> createState() => _CommadChatState();
}

class _CommadChatState extends State<CommadChat> {
  CheckPermission permission = CheckPermission();
  TextEditingController userCommandInputField = TextEditingController();
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    // Your code to load chat history data...

    Future.delayed(Duration.zero, () {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: secClr,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_rounded, color: whiteClr),
        ),
        title: cstmTextBox("Mag - Window Automator", whiteClr, 19),
        actions: [
          GestureDetector(
              onTap: () {
                setState(() {
                  chatHistory = [{}];
                });
              },
              child: cstmIcon(Icons.restart_alt_rounded, whiteClr)),
          Padding(
            padding: cstmPadAll(10.0),
            child: GestureDetector(
                onTap: () {
                  try {
                    setState(() async {
                      var result = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SettingsPage()),
                      );
                      setState(() {});
                    });
                  } catch (e) {}
                },
                child: cstmIcon(Icons.settings, whiteClr)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Container(
          margin: cstmPad(10, 0, 0, 0),
          child: Column(children: listHistory(context)),
        ),
      ),
      floatingActionButton: Container(
        width: cstmWidth(context, 0.97),
        height: 45,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: cstmWidth(context, 0.75),
              decoration: cstmBoxDec(secClr, 1, whiteClr, 10, 2, shadowClr),
              padding: cstmPad(0, 5, 0, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: cstmWidth(context, 0.6),
                    child: TextField(
                      controller: userCommandInputField,
                      style: TextStyle(color: whiteClr, fontSize: 14),
                      decoration: InputDecoration(
                          hintText: "Enter your command ...",
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: whiteClr, fontSize: 15)),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.attachment,
                      color: whiteClr,
                    ),
                  ),
                  // GestureDetector(
                  //   onTap: () {},
                  //   child: Icon(
                  //     Icons.mic,
                  //     color: whiteClr,
                  //   ),
                  // )
                ],
              ),
            ),
            Container(
              child: ElevatedButton(
                onPressed: () async {
                  print("@@Here ${chatHistory}");
                  if (userCommandInputField.text != "") {
                    List<dynamic> date = getCurrentDateTime();

                    await sendDataToApi({
                      "text": userCommandInputField.text,
                      "sender": "user",
                      "dateTime": date[1].toString()
                    });

                    if (chatHistory[0].isNotEmpty) {
                      if (chatHistory[0].containsKey(date[0].toString())) {
                        setState(() {
                          chatHistory[0][date[0].toString()].add(
                            {
                              "text": userCommandInputField.text,
                              "sender": "user",
                              "dateTime": date[1].toString()
                            },
                          );
                          userCommandInputField.text = "";
                        });
                      } else {
                        setState(() {
                          chatHistory[0].addAll({
                            "text": userCommandInputField.text,
                            "sender": "user",
                            "dateTime": date[1].toString()
                          });
                          userCommandInputField.text = "";
                        });
                      }
                    } else {
                      setState(() {
                        chatHistory[0] = ({
                          date[0].toString(): [
                            {
                              "text": userCommandInputField.text,
                              "sender": "user",
                              "dateTime": date[1].toString()
                            }
                          ]
                        });
                        userCommandInputField.text = "";
                      });
                    }
                  }
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromRGBO(217, 217, 217, 1)),
                ),
                child: cstmTextBox("Send", blackClr, 15),
              ),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  List<Widget> listHistory(context) {
    List<Widget> chatHistoryWidgets = [];

    try {
      for (var key in chatHistory[0].keys) {
        print(key);
        chatHistoryWidgets.add(dateWidget(context, key));
        for (var data in chatHistory[0][key]) {
          if (data.containsKey('text')) {
            chatHistoryWidgets.add(TextMessage(
                context, data['text'], data['sender'], data["dateTime"]));
          } else if (data.containsKey('image')) {
            chatHistoryWidgets.add(graphicMessage(
                context,
                data['image'],
                data['sender'],
                data["dateTime"],
                data["filePath"],
                Icon(Icons.image, color: whiteClr, size: 90)));
          } else if (data.containsKey('video')) {
            chatHistoryWidgets.add(graphicMessage(
                context,
                data['video'],
                data['sender'],
                data["dateTime"],
                data["filePath"],
                Icon(Icons.play_circle_fill_outlined,
                    color: whiteClr, size: 60)));
          }
          chatHistoryWidgets.add(const SizedBox(height: 5));
        }
        chatHistoryWidgets.add(SizedBox(height: 60));
      }
    } catch (e) {}

    return chatHistoryWidgets;
  }

  Widget TextMessage(context, message, sender, tme) {
    double contWidth = 0;
    double contHeight = 0;
    Color conColor = sender == 'user'
        ? const Color.fromRGBO(50, 47, 47, 1)
        : const Color.fromRGBO(33, 32, 32, 1);
    EdgeInsetsGeometry mar = EdgeInsets.zero; // Default margin

    if (message.length < 8) {
      contWidth = cstmWidth(context, 0.06 * message.length);
      contHeight = cstmHeight(context, 0.06);
    } else if (message.length < 20) {
      contWidth = cstmWidth(context, 0.036 * message.length);
      contHeight = cstmHeight(context, 0.06);
    } else if (message.length >= 20 && message.length < 50) {
      contWidth = cstmWidth(context, 0.022 * message.length);
      contHeight = cstmHeight(context, 0.06);
    } else if (message.length > 50) {
      contWidth = cstmWidth(context, 0.6);
      contHeight = cstmHeight(context, 0.1);
      print(mar);
    }
    mar = sender == 'user'
        ? EdgeInsets.only(left: cstmWidth(context, 0.95) - contWidth)
        : mar = EdgeInsets.only(right: cstmWidth(context, 0.90) - contWidth);

    return Column(
      children: [
        Container(
          width: contWidth,
          decoration: cstmBoxDec(conColor, 1, conColor, 10, 2, conColor),
          height: contHeight,
          padding: cstmPad(0, 0, 0, 10),
          margin: mar,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Icon(Icons.person, color: whiteClr),
                  const SizedBox(width: 10),
                  Container(
                    padding: cstmPad(0, 10, 0, 0),
                    width: contWidth - 50, // Adjust the width as needed
                    child: Text(
                      message,
                      style: TextStyle(color: whiteClr),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 5),
        Container(
          width: contWidth, // layout[0],
          decoration: cstmBoxDec(Colors.transparent, 1, Colors.transparent, 10,
              2, Colors.transparent),
          height: 20,
          padding: cstmPad(0, 0, 0, 10),
          margin: mar,
          child: Text(
            tme.toString(),
            style: const TextStyle(
                color: Color.fromARGB(255, 145, 143, 143), fontSize: 10),
            textAlign: sender == 'user' ? TextAlign.right : TextAlign.left,
          ),
          // child: cstmTextBox(tme.toString(), whiteClr, 10),
        )
      ],
    );
  }

  Widget dateWidget(context, date) {
    Widget datetimeWidget = Container();
    datetimeWidget = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          // color: Colors.amber,/
          width: cstmWidth(context, 0.95),
          height: cstmHeight(context, 0.04),
          child: cstmCenteredTextBox(date, secClr, 15),
        ),
      ],
    );
    return datetimeWidget;
  }

  void openfile(filePath) async {
    requestPermissions().grantPermissions();
    await OpenFile.open(filePath);
    print("fff $filePath");
  }

  Widget graphicMessage(context, message, sender, tme, filePath, icn) {
    requestPermissions().grantPermissions();

    double contWidth = 0;
    double contHeight = 0;
    Color conColor = sender == 'user'
        ? const Color.fromRGBO(50, 47, 47, 1)
        : const Color.fromRGBO(33, 32, 32, 1);
    EdgeInsetsGeometry mar = EdgeInsets.zero; // Default margin

    if (message.length < 20) {
      contWidth = cstmWidth(context, 0.35);
      contHeight = cstmHeight(context, 0.15);
    } else if (message.length >= 20 && message.length < 50) {
      contWidth = cstmWidth(context, 0.022 * message.length);
      contHeight = cstmHeight(context, 0.15);
    }
    if (sender == 'user') {
      mar = EdgeInsets.only(left: cstmWidth(context, 0.95) - contWidth);
    } else {
      mar = EdgeInsets.only(right: cstmWidth(context, 0.90) - contWidth);
    }
    var data = getCurrentDateTime();
    print(data);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () async {
            var path = await DirectoryPath().getPath();
            print(path);
            openfile("/Internal storage/Download/example.txt");
          },
          child: Container(
            width: contWidth, // layout[0],
            decoration: cstmBoxDec(conColor, 1, conColor, 10, 2, conColor),
            height: contHeight,
            // padding: cstmPad(0, 0, 0, 10),
            margin: mar,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(width: 10),
                    Column(
                      children: [
                        icn,
                        const SizedBox(height: 5),
                        Text(message,
                            textAlign: TextAlign.start,
                            style: TextStyle(color: secClr)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 5),
        Container(
          width: contWidth, // layout[0],
          decoration: cstmBoxDec(Colors.transparent, 1, Colors.transparent, 10,
              2, Colors.transparent),
          height: 20,
          padding: cstmPad(0, 0, 0, 10),
          margin: mar,
          child: Text(
            tme.toString(),
            style: const TextStyle(
                color: Color.fromARGB(255, 145, 143, 143), fontSize: 10),
            textAlign: sender == 'user' ? TextAlign.right : TextAlign.left,
          ),
        )
      ],
    );
  }

  List<dynamic> senderLayout(message, sender) {
    double contWidth = 0;
    double contHeight = 0;
    Color conColor = sender == 'user'
        ? const Color.fromRGBO(50, 47, 47, 1)
        : const Color.fromRGBO(33, 32, 32, 1);
    EdgeInsetsGeometry mar = EdgeInsets.zero; // Default margin

    if (message.length < 20) {
      contWidth = cstmWidth(context, 0.036 * message.length);
      contHeight = cstmHeight(context, 0.06);
    } else if (message.length >= 20 && message.length < 50) {
      contWidth = cstmWidth(context, 0.022 * message.length);
      contHeight = cstmHeight(context, 0.06);
    }
    if (sender == 'user') {
      mar = EdgeInsets.only(left: cstmWidth(context, 0.95) - contWidth);
    } else {
      mar = EdgeInsets.only(right: cstmWidth(context, 0.90) - contWidth);
    }
    return [contWidth, contHeight, conColor, mar];
  }
}
