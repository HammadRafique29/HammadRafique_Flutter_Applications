import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'Models/libs.dart';
import 'Models/settings.dart';

class Mice extends StatefulWidget {
  const Mice({super.key});
  @override
  State<Mice> createState() => _MiceState();
}

class _MiceState extends State<Mice> {
  SpeechToText speechToText = SpeechToText();
  bool is_listening = false;
  // var Message = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              print("@@ Text Clicked");
            },
            child: AnimatedContainer(
              // color: Colors.amber,
              duration: Duration(milliseconds: 500),
              width: cstmWidth(context, 0.8),
              height: userCommand.length > 0 ? cstmHeight(context, 0.1) : 0,
              child: Center(
                child: SingleChildScrollView(
                  child: cstmCenteredTextBox(userCommand, whiteClr, 18),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTapDown: (details) async {
              if (!is_listening) {
                var avaiable = await speechToText.initialize();
                if (avaiable) {
                  setState(() {
                    is_listening = true;
                    speechToText.listen(onResult: (results) {
                      setState(() {
                        userCommand = results.recognizedWords;
                      });
                    });
                  });
                }
              }
            },
            onTapUp: (details) {
              setState(() {
                is_listening = false;
              });
              speechToText.stop();
            },
            child: Column(
              children: [
                const SizedBox(height: 20),
                Container(
                  width: cstmWidth(context, 0.55),
                  height: cstmWidth(context, 0.55),
                  decoration: cstmBoxDec(whiteClr, 1, whiteClr, 500, 5,
                      Color.fromRGBO(255, 218, 218, 0.5)),
                  child: AvatarGlow(
                    glowColor: secClr,
                    glowCount: 3,
                    glowRadiusFactor: 0.1,
                    duration: const Duration(milliseconds: 1500),
                    repeat: true,
                    animate: is_listening,
                    child: CircleAvatar(
                      backgroundColor: secClr,
                      // radius: MediaQuery.sizeOf(context).width * 0.3,
                      child: cstmTextBox("Tap", whiteClr, 30),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: cstmWidth(context, 1),
                  child: Center(
                    child: cstmTextBox(speckSetting, secClr, 20),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
    // return GestureDetector(
    //   onTapDown: (details) async {
    //     if (!is_listening) {
    //       var avaiable = await speechToText.initialize();
    //       if (avaiable) {
    //         setState(() {
    //           is_listening = true;
    //           speechToText.listen(onResult: (results) {
    //             setState(() {
    //               userCommand = results.recognizedWords;
    //             });
    //           });
    //         });
    //       }
    //     }
    //   },
    //   onTapUp: (details) {
    //     setState(() {
    //       is_listening = false;
    //     });
    //     speechToText.stop();
    //   },
    //   child: Column(
    //     children: [

    //       const SizedBox(height: 20),
    //       Container(
    //         width: cstmWidth(context, 0.55),
    //         height: cstmWidth(context, 0.55),
    //         decoration: cstmBoxDec(whiteClr, 1, whiteClr, 500, 5,
    //             Color.fromRGBO(255, 218, 218, 0.5)),
    //         child: AvatarGlow(
    //           glowColor: secClr,
    //           glowCount: 3,
    //           glowRadiusFactor: 0.1,
    //           duration: const Duration(milliseconds: 1500),
    //           repeat: true,
    //           animate: is_listening,
    //           child: CircleAvatar(
    //             backgroundColor: secClr,
    //             // radius: MediaQuery.sizeOf(context).width * 0.3,
    //             child: cstmTextBox("Tap", whiteClr, 30),
    //           ),
    //         ),
    //       ),
    //       SizedBox(height: 20),
    //       Container(
    //         width: cstmWidth(context, 1),
    //         child: Center(
    //           child: cstmTextBox(speckSetting, secClr, 20),
    //         ),
    //       )
    //     ],
    //   ),
    // );
  }
}

// SpeechToText speechToText = SpeechToText();
// var is_lestening = false;

// if (!is_listening) {
//               var avaiable = await speechToText.initialize();
//               if (avaiable) {
//                 setState(() {
//                   is_listening = true;
//                   speechToText.listen(onResult: (results) {
//                     setState(() {
//                       text = results.recognizedWords;
//                     });
//                   });
//                   print("@@ Pressed Mic");
//                 });
//               }
//             }