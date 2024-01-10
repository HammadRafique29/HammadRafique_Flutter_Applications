import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Login.dart';

class CoinScreen extends StatefulWidget {
  final Map<dynamic, dynamic> coinName;

  const CoinScreen({Key? key, required this.coinName}) : super(key: key);

  @override
  State<CoinScreen> createState() => _CoinScreenState();
}

class _CoinScreenState extends State<CoinScreen> {
  bool favouriteCoin = false;

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
              if (userLogedin != null) {
                // final bool? userLoggedType = prefs.getBool('loginType');
              } else {
                print("## Setting Data");
                await prefs.setBool('loginExists', false);
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
              }
              
              setState(() {
                if (favouriteCoin) {
                  favouriteCoin = false;
                } else {
                  favouriteCoin = true;
                }
              });
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
