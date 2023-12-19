import 'package:flutter/material.dart';
import 'functions.dart';

Color priClr = const Color.fromRGBO(60, 56, 56, 1);
Color secClr = const Color.fromRGBO(90, 85, 85, 1);
Color whiteClr = Colors.white;
Color blackClr = Colors.black;
Color shadowClr = const Color.fromARGB(255, 195, 191, 195);
Color textClr1 = Color.fromRGBO(204, 202, 202, 1);
Color taskBarClr = Color.fromRGBO(213, 213, 213, 1);

// ###############################################################
//           Sending, Receiving Transmission Datasets
// ###############################################################
bool taoToSpeak = true;
bool showSystemUsageInfo = true;
bool voiceResponse = true;
bool webSocktsTransmission = false;
String assistandCharacter = 'male';
String assistantName = "Mag";
String speckSetting = taoToSpeak ? "Tap to Speak" : "Listening";
String userCommand = ""; // user Textual/voice cmd controller
String processingCommandMessage = ""; // user command processing response

// ###############################################################
//                    Dumpy Testing Datasets
// ###############################################################
Map<String, int> systemUsage = {"CPU": 45, "RAM": 35, "Storage": 50};
String userTextCommand =
    "In your code, you have several nested SingleChildScrollView widgets";

// ###############################################################
//           Dashboard Shortcut Commands Functions
// ###############################################################
Map<String, Function()> predefinedCommandsDataset = {
  "Who am i talking to": whoAmTalkingTo,
  "Where am i": whereAmI,
  "Get System info ...": getSystemInfo,
  "Take a Screen Shot ...": takeScreenShot,
  "Current Running Process ...": runningProcess,
  "Who am i talking to..": whoAmTalkingTo,
  "Where am i..": whereAmI,
  "Get System info ..": getSystemInfo,
  "Take a Screen Shot ..": takeScreenShot,
  "Current Running Process ..": runningProcess
};

// ################################################################
//                Main Application Settings
// ################################################################
bool showSystemInfoSetting = true;

List<Map<String, dynamic>> chatHistory = [
  {
    "2023-10-16": [
      {
        "image": "testingimagesdsdsds.png",
        "sender": "bot",
        "filePath":
            "/Internal storage/Android/media/com.whatsapp/WhatsApp/Media/Whatsapp Images/IMG-20231215-WA0010.jpg",
        "dateTime": "08:45 AM"
      },
      {
        "text": "I want you to create",
        "sender": "user",
        "dateTime": "08:45 AM"
      },
      {
        "image": "testingimage.png",
        "sender": "user",
        "filePath":
            "/Internal storage/Android/media/com.whatsapp/WhatsApp/Media/Whatsapp Images/IMG-20231215-WA0010.jpg",
        "dateTime": "08:45 AM"
      },
      {
        "text": "I want you to create",
        "sender": "user",
        "dateTime": "08:45 AM"
      },
      {
        "text":
            "I want you to create python file test.py inside flutter folder in c drive. Agin testing Python file test.py inside flutter project",
        "sender": "bot",
        "dateTime": "08:45 AM"
      }
    ],
    "2023-11-16": [
      {
        "video": "testing.mp4",
        "sender": "bot",
        "filePath":
            "/Internal storage/Android/media/com.whatsapp/WhatsApp/Media/Whatsapp Images/IMG-20231215-WA0010.jpg",
        "dateTime": "08:45 AM"
      },
      {
        "text": "I want you to create",
        "sender": "user",
        "dateTime": "08:45 AM"
      },
      {
        "image": "testingimage.png",
        "sender": "user",
        "filePath":
            "/Internal storage/Android/media/com.whatsapp/WhatsApp/Media/Whatsapp Images/IMG-20231215-WA0010.jpg",
        "dateTime": "08:45 AM"
      },
      {
        "text": "I want you to create",
        "sender": "user",
        "dateTime": "08:45 AM"
      },
      {
        "text":
            "I want you to create python file test.py inside flutter folder in c drive. Agin testing Python file test.py inside flutter project",
        "sender": "bot",
        "dateTime": "08:45 AM"
      }
    ],
    "2023-12-16": [
      {
        "image": "testingimagesdsdsds.png",
        "sender": "bot",
        "filePath":
            "/Internal storage/Android/media/com.whatsapp/WhatsApp/Media/Whatsapp Images/IMG-20231215-WA0010.jpg",
        "dateTime": "08:45 AM"
      },
      {
        "text": "I want you to create",
        "sender": "user",
        "dateTime": "08:45 AM"
      },
      {"image": "testingimage.png", "sender": "user", "dateTime": "08:45 AM"},
      {
        "text": "I want you to create",
        "sender": "user",
        "filePath":
            "/Internal storage/Android/media/com.whatsapp/WhatsApp/Media/Whatsapp Images/IMG-20231215-WA0010.jpg",
        "dateTime": "08:45 AM"
      },
      {
        "text":
            "I want you to create python file test.py inside flutter folder in c drive. Agin testing Python file test.py inside flutter project",
        "sender": "bot",
        "dateTime": "08:45 AM"
      }
    ]
  }
];
