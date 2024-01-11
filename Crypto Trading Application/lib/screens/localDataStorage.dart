import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'dart:io';

class LocalDataStorage {
  Future<Directory> getLocalDirectory() async {
    final directory = await getApplicationDocumentsDirectory();
    print(directory);
    return directory;
  }

  Future<void> saveDataToFile(Map<String, dynamic> data) async {
    final directory = await getLocalDirectory();
    final file = File('${directory.path}/favoriteCoins.json');

    try {
      if (!directory.existsSync()) {
        directory.createSync(recursive: true);
      }

      final jsonData = json.encode(data);

      await file.writeAsString(jsonData);

      print('Data saved to ${file.path}');
    } catch (e) {
      print('Error saving data: $e');
    }
  }

  Future<Map<String, dynamic>> readDataFromFile() async {
    final directory = await getLocalDirectory();
    final file = File('${directory.path}/favoriteCoins.json');

    try {
      if (!file.existsSync()) {
        return {};
      }

      final jsonData = await file.readAsString();
      final data = json.decode(jsonData);
      return data;
    } catch (e) {
      print('Error reading data: $e');
      return {};
    }
  }
}