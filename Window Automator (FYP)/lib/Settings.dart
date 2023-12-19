import 'package:flutter/material.dart';
import 'Models/libs.dart';
import 'Models/settings.dart';
// import 'Models/functions.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  TextEditingController assistantController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    assistantController.text = assistantName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: secClr,
        title: cstmTextBox("Mag - Window Automator", whiteClr, 19),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: cstmIcon(Icons.arrow_back, whiteClr),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: cstmWidth(context, 1),
          margin: cstmPad(cstmHeight(context, 0.05), 0, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: cstmWidth(context, 0.9),
                height: 60,
                decoration:
                    cstmBoxDec(whiteClr, 1, shadowClr, 10, 2, shadowClr),
                child: ListTile(
                  title: Text(
                    "Tap to Speak",
                    style: TextStyle(color: blackClr, fontSize: 18),
                  ),
                  trailing: Switch(
                    activeColor: secClr,
                    value: taoToSpeak,
                    onChanged: (newValue) {
                      setState(
                        () {
                          taoToSpeak = newValue;
                          // Dataset["Vibration"] = newValue;
                        },
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Container(
                width: cstmWidth(context, 0.9),
                height: 60,
                decoration:
                    cstmBoxDec(whiteClr, 1, shadowClr, 10, 2, shadowClr),
                child: ListTile(
                  title: Text(
                    "Show System Usage",
                    style: TextStyle(color: blackClr, fontSize: 18),
                  ),
                  trailing: Switch(
                    activeColor: secClr,
                    value: showSystemUsageInfo,
                    onChanged: (newValue) {
                      setState(
                        () {
                          showSystemUsageInfo = newValue;
                          // Dataset["Vibration"] = newValue;
                        },
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Container(
                width: cstmWidth(context, 0.9),
                height: 60,
                decoration: cstmBoxDec(
                    whiteClr, 1, Colors.transparent, 10, 2, shadowClr),
                child: ListTile(
                  title: Text(
                    "Voice Response",
                    style: TextStyle(color: blackClr, fontSize: 18),
                  ),
                  trailing: Switch(
                    activeColor: secClr,
                    value: voiceResponse,
                    onChanged: (newValue) {
                      setState(
                        () {
                          voiceResponse = newValue;
                          // Dataset["Vibration"] = newValue;
                        },
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: cstmWidth(context, 0.9),
                height: 60,
                decoration: cstmBoxDec(
                    const Color.fromRGBO(113, 112, 112, 1),
                    1,
                    const Color.fromRGBO(113, 112, 112, 1),
                    10,
                    2,
                    shadowClr),
                child: ListTile(
                  title: Text(
                    "Character",
                    style: TextStyle(color: whiteClr, fontSize: 20),
                  ),
                  trailing: Container(
                    width: cstmWidth(context, 0.45),
                    // color: Colors.amber,
                    child: Row(
                      children: [
                        Radio(
                          value: 'male',
                          groupValue: assistandCharacter,
                          onChanged: (value) {
                            setState(() {
                              assistandCharacter = value.toString();
                            });
                          },
                        ),
                        cstmTextBox("Male", whiteClr, 16),
                        Radio(
                          value: 'female',
                          groupValue: assistandCharacter,
                          onChanged: (value) {
                            setState(() {
                              assistandCharacter = value.toString();
                            });
                          },
                        ),
                        cstmTextBox("Female", whiteClr, 16),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 7),
              Container(
                width: cstmWidth(context, 0.9),
                height: 60,
                decoration: cstmBoxDec(
                    const Color.fromRGBO(113, 112, 112, 1),
                    1,
                    const Color.fromRGBO(113, 112, 112, 1),
                    10,
                    2,
                    shadowClr),
                child: ListTile(
                  title: Text(
                    "Assistand Name",
                    style: TextStyle(color: whiteClr, fontSize: 20),
                  ),
                  trailing: Container(
                    width: 100, // Adjust the width as needed
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          assistantName = assistantController.text;
                        });
                      },
                      style: TextStyle(color: shadowClr, fontSize: 20),
                      controller: assistantController,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 7),
              Container(
                width: cstmWidth(context, 0.9),
                height: 60,
                decoration: cstmBoxDec(
                    const Color.fromRGBO(113, 112, 112, 1),
                    1,
                    const Color.fromRGBO(113, 112, 112, 1),
                    10,
                    2,
                    shadowClr),
                child: ListTile(
                  title: Text(
                    "Turn to WebSockets (Local)",
                    style: TextStyle(color: whiteClr, fontSize: 18),
                  ),
                  trailing: Switch(
                    activeColor: whiteClr,
                    value: webSocktsTransmission,
                    onChanged: (newValue) {
                      setState(
                        () {
                          webSocktsTransmission = newValue;
                          // Dataset["Vibration"] = newValue;
                        },
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 7),
              // FloatingActionButton(onPressed: (){}, child: ,)
              Container(
                margin: cstmPad(cstmHeight(context, 0.33), 0, 0, 0),
                width: cstmWidth(context, 0.5),
                height: 50,
                // decoration: cstmBoxDec(Color.fromRGBO(159, 39, 39, 0.494), 1,
                //     shadowClr, 0, 2, shadowClr),
                child: FloatingActionButton(
                  onPressed: () {
                    // Add your button click logic here
                  },
                  backgroundColor: Color.fromRGBO(241, 56, 56, 0.49),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: cstmTextBox("Reset Details", Colors.white, 18),
                ),
              )
            ],
          ),
        ),
      ),
      // floatingActionButton: Container(
      //   margin: cstmPad(0, 0, 10, 0),
      //   width: cstmWidth(context, 0.5),
      //   height: 50,
      //   child: FloatingActionButton(
      //     onPressed: () {},
      //     backgroundColor: Color.fromRGBO(241, 56, 56, 0.49),
      //     shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular(10),
      //     ),
      //     child: cstmTextBox("Reset Details", Colors.white, 18),
      //   ),
      // ),
      // floatingActionButtonLocation:
      //     FloatingActionButtonLocation.miniCenterDocked,
    );
  }
}
