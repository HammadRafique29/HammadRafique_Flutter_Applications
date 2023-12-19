import 'dart:io';
import 'package:csv/csv.dart';
import 'package:share/share.dart';
import 'db.dart';

class ExcelGenerator {
  static Future<void> generateExcel() async {
    DatabaseHelper dbHelper = DatabaseHelper();
    final List<Map<String, dynamic>> users = await dbHelper.getAllUsers();
    final List<Map<String, dynamic>> history =
        await dbHelper.getAllUserHistory();

    final List<List<dynamic>> data = [];

    for (final user in users) {
      final int userId = user['ID'];
      final List<Map<String, dynamic>> userHistory =
          await dbHelper.getHistoryByUserId(userId);

      if (userHistory.isNotEmpty) {
        final Map<String, dynamic> lastEntry = userHistory.last;

        data.add([
          user['UserCode'],
          user['Name'],
          lastEntry['Balance'],
        ]);
      }
    }

    await _generateExcel(data);
  }

  static Future<void> _generateExcel(List<List<dynamic>> data) async {
    final String fileName = 'your_file_name.csv';

    // Get the Downloads directory
    final String dir =
        '/storage/emulated/0/Download'; // Android Downloads directory
    final String path = '$dir/$fileName';
    final File file = File(path);

    // Create CSV content
    String csvContent = const ListToCsvConverter().convert(data);

    // Write CSV content to file
    await file.writeAsString(csvContent);

    // Share the Excel file using the share package
    Share.shareFiles([path], text: 'Share Excel');
  }
}
