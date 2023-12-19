import 'package:cod_mag/settings.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'Settings.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void settingsPageButton(context) async {
  var result = await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => SettingsPage()),
  );
}

void sendCommandButton() {
  processingCommandMessage = "command processing";
  print("@@ Command Sended");
}

class requestPermissions {
  grantPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();
    print("@@ persom ${statuses[Permission.location]}");
  }
}

class CheckPermission {
  isStoragePermission() async {
    var isStorage = await Permission.storage.status;
    if (!isStorage.isGranted) {
      await Permission.storage.request();
      if (!isStorage.isGranted) {
        return false;
      } else {
        return true;
      }
    } else {
      return true;
    }
  }
}

class DirectoryPath {
  getPath() async {
    final Directory? tempDir = await getExternalStorageDirectory();
    final filePath = Directory("${tempDir!.path}/files");
    if (await filePath.exists()) {
      return filePath.path;
    } else {
      await filePath.create(recursive: true);
      return filePath.path;
    }
  }
}

//   void checkFileExit(filename) async {
//   DirectoryPath getPathFile = DirectoryPath();
//   var storePath = await getPathFile.getPath();
//   var filePath = '$storePath/$filename';
//   bool fileExistCheck = await File(filePath).exists();
//   setState(() {
//     fileExists = fileExistCheck;
//   });
// }

// ######################################
//          API GET Connection
// ######################################

Future<Map<String, dynamic>> fetchData() async {
  var url = Uri.parse(
      'http://192.168.172.128:8000/'); // Replace with your actual API endpoint
  final response = await http.get(url);

  if (response.statusCode == 200) {
    print(json.decode(response.body));
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load data');
  }
}

// ######################################
//           API POST Connection
// ######################################

Future<void> sendDataToApi(data) async {
  var url = Uri.parse('http://192.168.172.128:8000/send');
  var dataToSend = {'name': 'John Doe', 'age': 30};

  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(data),
  );

  if (response.statusCode == 200) {
    print('Data sent successfully');
    print(json.decode(response.body));
  } else {
    print('Failed to send data');
    print('Status code: ${response.statusCode}');
    print('Response body: ${response.body}');
  }
}

// #####################################
// Predefined Functions Commands
// #####################################
void whoAmTalkingTo() {
  print("@@ Who am i talking to");
}

void whereAmI() {
  print("@@ Where am i");
}

void takeScreenShot() {
  print("@@ Screen Shot");
}

void runningProcess() {
  print("@@ Running Pocess");
}

void getSystemInfo() {
  print("@@ System Info");
}

// ###############################################
//              Get Date and Time
// ###############################################
List<String> getCurrentDateTime() {
  DateTime now = DateTime.now();

  String formatNumber(int number) {
    // Add leading zero if the number is less than 10
    return number < 10 ? '0$number' : '$number';
  }

  String formatTime(DateTime dateTime) {
    // Format time as h:mm a
    String period = dateTime.hour < 12 ? 'AM' : 'PM';
    int hour = dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12;
    return '${formatNumber(hour)}:${formatNumber(dateTime.minute)} $period';
  }

  // Format date (year, month, date)
  String fullDate =
      "${now.year}-${formatNumber(now.month)}-${formatNumber(now.day)}";

  // Format time (h:mm a)
  String formattedTime = formatTime(now);

  return [fullDate, formattedTime];
}
