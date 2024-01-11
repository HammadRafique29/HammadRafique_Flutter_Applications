import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'Login.dart';
import 'dart:convert';
import 'dart:io';

class CoinScreen extends StatefulWidget {
  final Map<dynamic, dynamic> coinName;

  const CoinScreen({Key? key, required this.coinName}) : super(key: key);

  @override
  State<CoinScreen> createState() => _CoinScreenState();
}

class _CoinScreenState extends State<CoinScreen> {
  bool favouriteCoin = false;

  void getCoinData() async {
    var data = await LocalDataStorage().readDataFromFile();
    print(data);
    if (!data.isEmpty) {
      if (data["Coins"] == null) {
        LocalDataStorage().saveDataToFile({"Coins": []});
      } else if (data["Coins"].contains(widget.coinName["id"])) {
        setState(() {
          favouriteCoin = true;
        });
      }
    } else {
      LocalDataStorage().saveDataToFile({"Coins": []});
    }
  }

  Future<void> requestWritePermission() async {
    PermissionStatus status = await Permission.storage.status;
    if (!status.isGranted) {
      status = await Permission.storage.request();
    }
    if (status.isGranted) {
      // Write your code here to access the external storage
      final file = File('/storage/emulated/0/favorite_Coins.json');
      if (!file.existsSync()) {
        file.createSync();
      }
      final jsonString = file.readAsStringSync();
      final data = jsonDecode(jsonString);
      print(data);

      data['coins'].add(widget.coinName["id"]);

      final newJsonString = jsonEncode(data);
      file.writeAsStringSync(newJsonString);
    }
    // If the permission is permanently denied, open the app settings
    if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCoinData();
  }

  @override
  Widget build(BuildContext context) {
    var coinData = widget.coinName;
    var coinTrendColor =
        widget.coinName["price_change_percentage_24h_in_currency"] > 0
            ? Colors.green
            : Colors.red;
    var textColor = Colors.amber;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Row(
          children: [
            Image.network(
              widget.coinName["image"],
              width: 30,
              height: 30,
            ),
            const SizedBox(width: 10),
            Text(widget.coinName["id"])
          ],
        ),
        actions: [
          GestureDetector(
            onTap: () async {
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();
              final bool? userLogedin = prefs.getBool('loginExists');
              if (userLogedin != null && userLogedin) {
                // final bool? userLoggedType = prefs.getBool('loginType');
                // requestWritePermission();

                if (favouriteCoin) {
                  favouriteCoin = false;
                  var data = await LocalDataStorage().readDataFromFile();
                  data["Coins"]
                      .removeWhere((word) => word == widget.coinName["id"]);
                  LocalDataStorage().saveDataToFile({"Coins": data["Coins"]});
                } else {
                  favouriteCoin = true;
                  var data = await LocalDataStorage().readDataFromFile();
                  if (data.isEmpty) {
                    LocalDataStorage().saveDataToFile({
                      "Coins": [widget.coinName["id"]]
                    });
                  } else {
                    print("## Not Empty ${data}");
                    data["Coins"].add(widget.coinName["id"]);
                    LocalDataStorage().saveDataToFile(data);
                    data = await LocalDataStorage().readDataFromFile();
                    print("## Got Filled ${data}");
                  }
                }

                setState(() {});
              } else {
                print("## Setting Data");
                await prefs.setBool('loginExists', false);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: favouriteCoin
                  ? const Icon(
                      Icons.favorite,
                      color: Colors.white,
                    )
                  : const Icon(Icons.favorite_border),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: MediaQuery.sizeOf(context).width * 0.9,
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.only(top: 20),
            // height: MediaQuery.sizeOf(context).height * 0.8,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [BoxShadow(color: Colors.grey)],
              color: Colors.white,
            ),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  height: 150,
                  // color: Colors.grey,
                  child: Column(
                    children: [
                      Image.network(widget.coinName["image"],
                          width: 100, height: 100),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Current Price:",
                              style: TextStyle(fontSize: 22)),
                          const SizedBox(width: 10),
                          Container(
                            child: Row(
                              children: [
                                widget.coinName[
                                            "price_change_percentage_24h_in_currency"] >
                                        0
                                    ? Icon(Icons.trending_up_rounded,
                                        color: coinTrendColor)
                                    : Icon(Icons.trending_down_rounded,
                                        color: coinTrendColor),
                                const SizedBox(width: 10),
                                Text(
                                  "${widget.coinName["current_price"]} ",
                                  style: TextStyle(
                                      fontSize: 22, color: coinTrendColor),
                                ),
                                const Text(
                                  "USD",
                                  style: TextStyle(fontSize: 22),
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                      left: MediaQuery.sizeOf(context).width * 0.1,
                      right: MediaQuery.sizeOf(context).width * 0.1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("High 24h: ${widget.coinName["high_24h"]}"),
                      Text("Low 24h: ${widget.coinName["low_24h"]}"),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: MediaQuery.sizeOf(context).width * 0.75,
                  height: 130,
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 10, left: 10, right: 10),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(child: Text("Price Details")),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Text("24h Price Change : ",
                              style: TextStyle(color: Colors.grey[500])),
                          Text("${widget.coinName["price_change_24h"]}",
                              style: TextStyle(
                                  color: widget.coinName["price_change_24h"] > 0
                                      ? Colors.green
                                      : Colors.red.shade400))
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Text("24h Price Change % : ",
                              style: TextStyle(color: Colors.grey[500])),
                          Text(
                              "${widget.coinName["price_change_percentage_24h"]}",
                              style: TextStyle(
                                  color: widget.coinName[
                                              "price_change_percentage_24h"] >
                                          0
                                      ? Colors.green
                                      : Colors.red.shade400))
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Text("1h Price Change % : ",
                              style: TextStyle(color: Colors.grey[500])),
                          Text(
                              "${widget.coinName["price_change_percentage_1h_in_currency"]}",
                              style: TextStyle(color: Colors.green[300]))
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: MediaQuery.sizeOf(context).width * 0.75,
                  height: 150,
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 10, left: 10, right: 10),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(child: Text("Market Details")),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Text("Market Rank: ",
                              style: TextStyle(color: Colors.grey[500])),
                          Text("${widget.coinName["market_cap_rank"]}",
                              style: TextStyle(color: Colors.green[300]))
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Text("Market Cap: ",
                              style: TextStyle(color: Colors.grey[500])),
                          Text("${widget.coinName["market_cap"]}",
                              style: TextStyle(color: Colors.green[300]))
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Text("Market Cap Change 24h: ",
                              style: TextStyle(color: Colors.grey[500])),
                          Text("${widget.coinName["market_cap_change_24h"]}",
                              style: TextStyle(
                                  color:
                                      widget.coinName["market_cap_change_24h"] >
                                              0
                                          ? Colors.green
                                          : Colors.red.shade400))
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Text("Market Cap Change % : ",
                              style: TextStyle(color: Colors.grey[500])),
                          Text(
                              "${widget.coinName["market_cap_change_percentage_24h"]}",
                              style: TextStyle(
                                  color: widget.coinName[
                                              "market_cap_change_percentage_24h"] >
                                          0
                                      ? Colors.green
                                      : Colors.red.shade400))
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: MediaQuery.sizeOf(context).width * 0.75,
                  height: 150,
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 10, left: 10, right: 10),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(child: Text("Suply Details")),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Text("Total Volume : ",
                              style: TextStyle(color: Colors.grey[500])),
                          Text("${widget.coinName["total_volume"]}",
                              style: TextStyle(color: Colors.green[300]))
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Text("Total Supply: ",
                              style: TextStyle(color: Colors.grey[500])),
                          Text("${widget.coinName["total_supply"]}",
                              style: TextStyle(color: Colors.green[300]))
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Text("Max Supply: ",
                              style: TextStyle(color: Colors.grey[500])),
                          Text("${widget.coinName["max_supply"]}",
                              style: TextStyle(color: Colors.green[300]))
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Text("Circulatory Supply: ",
                              style: TextStyle(color: Colors.grey[500])),
                          Text("${widget.coinName["circulating_supply"]}",
                              style: TextStyle(color: Colors.green[300]))
                        ],
                      ),
                      const SizedBox(height: 5),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                    child: Text(
                        "Last Updated: ${widget.coinName["last_updated"]}"))
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 20,
        color: Colors.amber,
      ),
    );
  }
}

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
