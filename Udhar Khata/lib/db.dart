import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  static Database? _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDb();
    return _db!;
  }

  DatabaseHelper.internal();

  Future<Database> initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'your_database.db');

    // Delete the database if it exists to start fresh
    await deleteDatabase(path);

    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE Users (
        ID INTEGER PRIMARY KEY AUTOINCREMENT,
        UserCode TEXT,
        Name TEXT,
        PhoneCode TEXT,
        PhoneNumber TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE History (
        UID INTEGER,
        Description TEXT,
        Action INTEGER,
        Balance INTEGER,
        FOREIGN KEY (UID) REFERENCES Users (ID)
      )
    ''');

    await db.execute('''
      CREATE TABLE Balance (
        ID INTEGER PRIMARY KEY AUTOINCREMENT,
        Give INTEGER,
        Take INTEGER
      )
    ''');
  }

  Future<void> insertUser(Map<String, dynamic> user) async {
    Database dbClient = await db;
    await dbClient.insert('Users', user);
  }

  Future<List<Map<String, dynamic>>> getAllUsers() async {
    Database dbClient = await db;
    return await dbClient.query('Users');
  }

  Future<void> insertHistory(
      int userId, String description, int action, int balance) async {
    Database dbClient = await db;
    await dbClient.insert('History', {
      'UID': userId,
      'Description': description,
      'Action': action,
      'Balance': balance,
    });
  }

  Future<void> deleteHistoryByUserId(int userId,
      {String? action, String? description}) async {
    Database dbClient = await db;

    // Build the where clause based on the provided conditions
    String whereClause = 'UID = ?';
    List<dynamic> whereArgs = [userId];

    if (action != null) {
      whereClause += ' AND Action = ?';
      whereArgs.add(action);
    }

    if (description != null) {
      whereClause += ' AND Description = ?';
      whereArgs.add(description);
    }

    await dbClient.delete('History', where: whereClause, whereArgs: whereArgs);
  }

  Future<List<Map<String, dynamic>>> getUserByName(String name) async {
    Database dbClient = await db;
    return await dbClient.query('Users', where: 'Name = ?', whereArgs: [name]);
  }

  Future<List<Map<String, dynamic>>> getUserByID(int id) async {
    Database dbClient = await db;
    return await dbClient.query('Users', where: 'ID = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> getHistoryByUserId(int userId) async {
    Database dbClient = await db;
    return await dbClient
        .query('History', where: 'UID = ?', whereArgs: [userId]);
  }

  Future<void> insertCustomerHistory(List data) async {
    Database dbClient = await db;
    await dbClient.insert('History', {
      'UID': data[0],
      'Description': data[1],
      'Action': data[2],
      'Balance': data[3]
    });
  }

  Future<void> updateCustomerHistory(List data, int? userID) async {
    Database dbClient = await db;
    await dbClient.update(
        'History',
        {
          'UID': data[0],
          'Description': data[1],
          'Action': data[2],
          'Balance': data[3]
        },
        where: 'UID = ?',
        whereArgs: [userID]);
  }

  Future<List<Map<String, dynamic>>> getAllUserHistory() async {
    Database dbClient = await db;
    return await dbClient.query('History');
  }

  Future<List<int>> getPositiveNegativeSum() async {
    Database dbClient = await db;
    List<Map<String, dynamic>> historyList = await dbClient.query('History');

    Map<int, Map<String, dynamic>> lastRecords = {};

    for (Map<String, dynamic> history in historyList) {
      int uid = history['UID'];
      lastRecords[uid] = history;
    }

    int positiveSum = 0;
    int negativeSum = 0;

    lastRecords.forEach((uid, history) {
      int balance = history['Balance'] ?? 0;

      if (balance > 0) {
        positiveSum += balance;
      } else if (balance < 0) {
        negativeSum += balance;
      }
    });

    return [positiveSum, negativeSum];
  }

  Future<void> insertBalance(int give, int take) async {
    Database dbClient = await db;
    await dbClient.insert('Balance', {'Give': give, 'Take': take});
  }

  Future<void> updateBalance(int id, int give, int take) async {
    Database dbClient = await db;
    await dbClient.update('Balance', {'Give': give, 'Take': take},
        where: 'ID = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> getAllBalances() async {
    Database dbClient = await db;
    return await dbClient.query('Balance');
  }
}

// Future<void> DataBase_Model() async {
//   DatabaseHelper dbHelper = DatabaseHelper();

//   // Insert user
//   await dbHelper.insertUser({
//     'UserCode': 'HR',
//     'Name': 'Hammad Rafique',
//     'PhoneCode': '+1',
//     'PhoneNumber': '1234567890',
//   });

//   // Display all users
//   List<Map<String, dynamic>> allUsers = await dbHelper.getAllUsers();
//   print('All Users: $allUsers');

//   // Insert history
//   await dbHelper.insertHistory(1, 'Description 1', 1, 100);

//   // Delete history by user ID
//   await dbHelper.deleteHistoryByUserId(1);

//   // Get history by user ID
//   List<Map<String, dynamic>> userHistory = await dbHelper.getHistoryByUserId(1);
//   print('User History: $userHistory');

//   // Insert balance
//   await dbHelper.insertBalance(50, 0);

//   // Update balance
//   await dbHelper.updateBalance(1, 100, 20);

//   // Get all balances
//   List<Map<String, dynamic>> allBalances = await dbHelper.getAllBalances();
//   print('All Balances: $allBalances');
// }
