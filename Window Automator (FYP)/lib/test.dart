// // import 'package:flutter/material.dart';
// // import 'package:speech_to_text/speech_to_text.dart' as stt;

// // class SpeechToTextButton extends StatefulWidget {
// //   @override
// //   _SpeechToTextButtonState createState() => _SpeechToTextButtonState();
// // }

// // class _SpeechToTextButtonState extends State<SpeechToTextButton> {
// //   late stt.SpeechToText _speech;
// //   bool _isListening = false;
// //   String _text = 'Press and hold to speak';

// //   @override
// //   void initState() {
// //     super.initState();
// //     _speech = stt.SpeechToText();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       padding: EdgeInsets.all(16.0),
// //       child: Column(
// //         mainAxisAlignment: MainAxisAlignment.center,
// //         children: [
// //           Container(
// //             width: 80.0,
// //             height: 80.0,
// //             child: FloatingActionButton(
// //               onPressed: () {
// //                 if (!_isListening) {
// //                   startListening();
// //                 } else {
// //                   stopListening();
// //                 }
// //               },
// //               backgroundColor: _isListening ? Colors.red : Colors.blue,
// //               child: Icon(
// //                 _isListening ? Icons.mic : Icons.mic_none,
// //                 size: 36.0,
// //               ),
// //             ),
// //           ),
// //           SizedBox(height: 16.0),
// //           Text(_text),
// //         ],
// //       ),
// //     );
// //   }

// //   void startListening() {
// //     _speech.listen(
// //       onResult: (result) {
// //         setState(() {
// //           _text = result.recognizedWords;
// //         });
// //       },
// //       listenFor: Duration(seconds: 10),
// //     );

// //     setState(() {
// //       _isListening = true;
// //       _text = 'Listening...';
// //     });
// //   }

// //   void stopListening() {
// //     _speech.stop();

// //     setState(() {
// //       _isListening = false;
// //       _text = 'Press and hold to speak';
// //     });
// //   }
// // }

// // import 'dart:io';
// // import 'package:flutter/material.dart';
// // import 'package:path_provider/path_provider.dart';
// // import 'package:speech_to_text/speech_to_text.dart' as stt;

// // class SpeechToTextButton extends StatefulWidget {
// //   @override
// //   _SpeechToTextButtonState createState() => _SpeechToTextButtonState();
// // }

// // class _SpeechToTextButtonState extends State<SpeechToTextButton> {
// //   late stt.SpeechToText _speech;
// //   bool _isListening = false;
// //   String _text = 'Press and hold to speak';
// //   List<String> _recognizedWords = [];

// //   @override
// //   void initState() {
// //     super.initState();
// //     _speech = stt.SpeechToText();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       padding: EdgeInsets.all(16.0),
// //       child: Column(
// //         mainAxisAlignment: MainAxisAlignment.center,
// //         children: [
// //           Container(
// //             width: 80.0,
// //             height: 80.0,
// //             child: FloatingActionButton(
// //               onPressed: () {
// //                 if (!_isListening) {
// //                   startListening();
// //                 } else {
// //                   stopListening();
// //                 }
// //               },
// //               backgroundColor: _isListening ? Colors.red : Colors.blue,
// //               child: Icon(
// //                 _isListening ? Icons.mic : Icons.mic_none,
// //                 size: 36.0,
// //               ),
// //             ),
// //           ),
// //           SizedBox(height: 16.0),
// //           Text(_text),
// //           SizedBox(height: 16.0),
// //           Text(_recognizedWords.join(' ')),
// //         ],
// //       ),
// //     );
// //   }

// //   void startListening() {

// //     _speech.listen(
// //       onResult: (result) {
// //         setState(() {
// //           _text = result.recognizedWords;
// //           _recognizedWords.add(result.recognizedWords);
// //           print("@@ Result ${result.recognizedWords}");
// //         });
// //       },
// //       listenFor: Duration(seconds: 10),
// //     );
// //     print("@@ Result outside");

// //     setState(() {
// //       _isListening = true;
// //       _text = 'Listening...';
// //     });
// //   }

// //   void stopListening() async {
// //     _speech.stop();

// //     setState(() {
// //       _isListening = false;
// //       _text = 'Press and hold to speak';
// //     });

// //     // Save the audio to a file

// //     print("@@ ${_recognizedWords}");
// //     // String fileName =
// //     //     "testingFYP.txt"; // Change the file extension to txt or another suitable format
// //     // String filePath = await _getFilePath(fileName);

// //     // // Do something with the recognized words (e.g., save them to a file)
// //     // File file = File(filePath);
// //     // await file.writeAsString(_recognizedWords.join(' '));

// //     // print("Recognized words saved to: $filePath");
// //   }

// //   Future<String> _getFilePath(String fileName) async {
// //     Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
// //     String appDocumentsPath = appDocumentsDirectory.path;
// //     return '$appDocumentsPath/$fileName';
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:speech_to_text/speech_recognition_result.dart';
// import 'package:speech_to_text/speech_to_text.dart';


// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key? key}) : super(key: key);

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   SpeechToText _speechToText = SpeechToText();
//   bool _speechEnabled = false;
//   String _lastWords = '';

//   @override
//   void initState() {
//     super.initState();
//     _initSpeech();
//   }

//   /// This has to happen only once per app
//   void _initSpeech() async {
//     _speechEnabled = await _speechToText.initialize();
//     setState(() {});
//   }

//   /// Each time to start a speech recognition session
//   void _startListening() async {
//     await _speechToText.listen(onResult: _onSpeechResult);
//     setState(() {});
//   }

//   /// Manually stop the active speech recognition session
//   /// Note that there are also timeouts that each platform enforces
//   /// and the SpeechToText plugin supports setting timeouts on the
//   /// listen method.
//   void _stopListening() async {
//     await _speechToText.stop();
//     setState(() {});
//   }

//   /// This is the callback that the SpeechToText plugin calls when
//   /// the platform returns recognized words.
//   void _onSpeechResult(SpeechRecognitionResult result) {
//     setState(() {
//       _lastWords = result.recognizedWords;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Speech Demo'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Container(
//               padding: EdgeInsets.all(16),
//               child: Text(
//                 'Recognized words:',
//                 style: TextStyle(fontSize: 20.0),
//               ),
//             ),
//             Expanded(
//               child: Container(
//                 padding: EdgeInsets.all(16),
//                 child: Text(
//                   // If listening is active show the recognized words
//                   _speechToText.isListening
//                       ? '$_lastWords'
//                       // If listening isn't active but could be tell the user
//                       // how to start it, otherwise indicate that speech
//                       // recognition is not yet ready or not supported on
//                       // the target device
//                       : _speechEnabled
//                           ? 'Tap the microphone to start listening...'
//                           : 'Speech not available',
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed:
//             // If not yet listening for speech start, otherwise stop
//             _speechToText.isNotListening ? _startListening : _stopListening,
//         tooltip: 'Listen',
//         child: Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic),
//       ),
//     );
//   }
// }


// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, depend_on_referenced_packages

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:whisper_flutter/whisper_flutter.dart';
import "package:cool_alert/cool_alert.dart";

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Whisper Speech to Text'),
    ),
  );
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({
    super.key,
    required this.title,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String model = "";
  String audio = "";
  String result = "";
  bool is_procces = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
            minWidth: MediaQuery.of(context).size.width,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(
                visible: !is_procces,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: ElevatedButton(
                        onPressed: () async {
                          FilePickerResult? resul =
                              await FilePicker.platform.pickFiles();
                          if (resul != null) {
                            File file = File(resul.files.single.path!);
                            if (file.existsSync()) {
                              setState(() {
                                model = file.path;
                              });
                            }
                          }
                        },
                        child: const Text("set model"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: ElevatedButton(
                        onPressed: () async {
                          FilePickerResult? resul =
                              await FilePicker.platform.pickFiles();

                          if (resul != null) {
                            File file = File(resul.files.single.path!);
                            if (file.existsSync()) {
                              setState(() {
                                audio = file.path;
                              });
                            }
                          }
                        },
                        child: const Text("set audio"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (is_procces) {
                            return await CoolAlert.show(
                              context: context,
                              type: CoolAlertType.info,
                              text:
                                  "Tolong tunggu procces tadi sampai selesai ya",
                            );
                          }
                          if (audio.isEmpty) {
                            await CoolAlert.show(
                              context: context,
                              type: CoolAlertType.info,
                              text:
                                  "Maaf audio kosong tolong setting dahulu ya",
                            );
                            if (kDebugMode) {
                              print("audio is empty");
                            }
                            return;
                          }
                          if (model.isEmpty) {
                            await CoolAlert.show(
                                context: context,
                                type: CoolAlertType.info,
                                text:
                                    "Maaf model kosong tolong setting dahulu ya");
                            if (kDebugMode) {
                              print("model is empty");
                            }
                            return;
                          }

                          Future(() async {
                            print("Started transcribe");

                            Whisper whisper = Whisper(
                              whisperLib: "libwhisper.so",
                            );
                            var res = await whisper.request(
                              whisperRequest: WhisperRequest.fromWavFile(
                                audio: File(audio),
                                model: File(model),
                              ),
                            );
                            setState(() {
                              result = res.toString();
                              is_procces = false;
                            });
                          });
                          setState(() {
                            is_procces = true;
                          });
                        },
                        child: const Text("Start"),
                      ),
                    ),
                  ],
                ),
                replacement: const CircularProgressIndicator(),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text("model: ${model}"),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text("audio: ${audio}"),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text("Result: ${result}"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
