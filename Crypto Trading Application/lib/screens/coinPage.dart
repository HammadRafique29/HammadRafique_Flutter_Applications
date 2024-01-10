import 'package:flutter/material.dart';

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
            onTap: () {
              setState(() {
                if (favouriteCoin) {
                  favouriteCoin = false;
                } else {
                  favouriteCoin = true;
                }
              });
            },
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: favouriteCoin
                  ? Icon(
                      Icons.favorite,
                      color: Colors.white,
                    )
                  : Icon(Icons.favorite_border),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        
      ),
    );
  }
}
