import 'package:flutter/material.dart';
import 'package:trading_app/screens/coinPage.dart';
import 'sampleData.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

int _currentIndex = 0;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DashBoardScreen(),
    );
  }
}

class DashBoardScreen extends StatefulWidget {
  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  final List<Widget> _pages = [
    PageOne(),
    PageTwo(),
    PageThree(),
    PageFour(),
    PageFive(),
    coinPage()
  ];

  Future<void> SetData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? userLogedin = prefs.getBool('loginExists');
    if (userLogedin != null) {
      // final bool? userLoggedType = prefs.getBool('loginType');
    } else {
      await prefs.setBool('loginExists', false);
    }
  }

  @override
  Widget build(BuildContext context) {
    SetData();
    return Scaffold(
      appBar: buildMyAppBar(context),
      body: Container(
        child: _pages[_currentIndex],
        color: Colors.white,
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.grey,
        ),
        child: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          backgroundColor: Colors.white,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.amber,
                size: 25,
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
                color: Colors.amber,
                size: 25,
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.currency_exchange,
                color: Colors.amber,
                size: 40,
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.newspaper,
                color: Colors.amber,
                size: 25,
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: Colors.amber,
                size: 25,
              ),
              label: "",
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildMyAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.amber,
      title: Text('Trading App'),
      actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            showSearch(
              context: context,
              delegate: MySearchDelegate(),
            );
          },
        ),
      ],
    );
  }
}

class MySearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, "");
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Implement your search results here
    return Center(
      child: Text('Search results for: $query'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Widget> CryptoContainer = [];

    for (int i = 0; i < crypto.length; i++) {
      if (crypto[i]["id"].contains(query)) {
        CryptoContainer.add(GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CoinScreen(
                  coinName: crypto[i],
                ),
              ),
            );
          },
          child: Container(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height * 0.07,
            color: Colors.white,
            child: ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  child: Image.network(crypto[i]["image"]),
                ),
                title: Text(
                  "${crypto[i]["id"][0].toUpperCase()}${crypto[i]["id"].substring(1).toLowerCase()}",
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                trailing: Text(
                  "${crypto[i]["current_price"]} USD",
                  style: TextStyle(
                    color:
                        crypto[i]["price_change_percentage_24h_in_currency"] > 0
                            ? Colors.green
                            : Colors.red[300],
                    fontSize: 15.0,
                  ),
                )),
          ),
        ));
        CryptoContainer.add(SizedBox(height: 5));
      }
    }

    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(top: 20.0),
        child: Column(
          children: CryptoContainer,
        ),
      ),
    );
  }
}

class PageOne extends StatefulWidget {
  const PageOne({super.key});

  @override
  State<PageOne> createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  List<Widget> CryptoContainer = [];
  // List<dynamic> crypto = [];

  Future<String> fetchData() async {
    final response = await http.get(
      Uri.parse(
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false&price_change_percentage=1h%2C24h&locale=en&precision=2',
      ),
      headers: {
        'accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      crypto = data;
      return data.toString();
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    CryptoContainer = [];

    FutureBuilder(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Center(
            child: Text('API Response: ${snapshot.data}'),
          );
        }
      },
    );

    for (int i = 0; i < crypto.length; i++) {
      CryptoContainer.add(GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CoinScreen(
                  coinName: crypto[i],
                ),
              ),
            );
          },
          child: Container(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height * 0.07,
            color: Colors.white,
            child: ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  child: Image.network(crypto[i]["image"]),
                ),
                title: Text(
                  "${crypto[i]["id"][0].toUpperCase()}${crypto[i]["id"].substring(1).toLowerCase()}",
                  style: const TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                trailing: Text(
                  "${crypto[i]["current_price"]} USD",
                  style: TextStyle(
                    color:
                        crypto[i]["price_change_percentage_24h_in_currency"] > 0
                            ? Colors.green
                            : Colors.red[300],
                    fontSize: 15.0,
                  ),
                )),
          )));
      CryptoContainer.add(
        SizedBox(height: 5),
      );
    }

    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(top: 20.0),
        child: Column(
          children: CryptoContainer,
        ),
      ),
    );
  }
}

// class PageTwo extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text('Page One Content'),
//     );
//   }
// }

class PageTwo extends StatefulWidget {
  const PageTwo({super.key});

  @override
  State<PageTwo> createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {
  List<dynamic> favoritecoins = [];

  void getJsonData() async {
    var data = await LocalDataStorage().readDataFromFile();
    print("# ${data}");
    if (!data.isEmpty) {
      if (data["Coins"] != null) {
        setState(() {
          favoritecoins = data["Coins"];
        });
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getJsonData();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> CryptoContainer = [];

    for (int i = 0; i < crypto.length; i++) {
      print("### ${favoritecoins}");
      if (favoritecoins.contains(crypto[i]["id"])) {
        CryptoContainer.add(GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CoinScreen(
                    coinName: crypto[i],
                  ),
                ),
              );
            },
            child: Container(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height * 0.07,
              color: Colors.white,
              child: ListTile(
                  leading: Container(
                    width: 40,
                    height: 40,
                    child: Image.network(crypto[i]["image"]),
                  ),
                  title: Text(
                    "${crypto[i]["id"][0].toUpperCase()}${crypto[i]["id"].substring(1).toLowerCase()}",
                    style: const TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                  trailing: Text(
                    "${crypto[i]["current_price"]} USD",
                    style: TextStyle(
                      color: crypto[i]
                                  ["price_change_percentage_24h_in_currency"] >
                              0
                          ? Colors.green
                          : Colors.red[300],
                      fontSize: 15.0,
                    ),
                  )),
            )));
        CryptoContainer.add(
          SizedBox(height: 5),
        );
      }
    }

    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(top: 20.0),
        child: Column(
          children: CryptoContainer,
        ),
      ),
    );
  }
}

class PageThree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Page Three Content'),
    );
  }
}

class PageFour extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Page Four Content'),
    );
  }
}

class PageFive extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          final bool? userLogedin = prefs.getBool('loginExists');
          if (userLogedin != null) {
            print("### ${userLogedin}");
            await prefs.setBool('loginExists', false);
          } else {}
        },
        child: const Text("Logout"),
      ),
    );
  }
}

class coinPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Coin Page Content'),
    );
  }
}
