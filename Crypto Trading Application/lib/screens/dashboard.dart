import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'Signup.dart';
import 'package:trading_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'adminLogin.dart';
import 'sampleData.dart';

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
  int _currentIndex = 0;

  final List<Widget> _pages = [
    PageOne(),
    PageTwo(),
    PageThree(),
    PageFour(),
    PageFive(),
  ];
  @override
  Widget build(BuildContext context) {
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
    // Implement suggestions based on the query here
    return Center(
      child: Text('Search suggestions for: $query'),
    );
  }
}

class PageOne extends StatelessWidget {
  List<Widget> CryptoContainer = [];

  @override
  Widget build(BuildContext context) {
    CryptoContainer = [];
    for (int i = 0; i < crypto.length; i++) {
      CryptoContainer.add(Container(
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
                color: crypto[i]["price_change_percentage_1h_in_currency"] > 0
                    ? Colors.green
                    : Colors.red[300],
                fontSize: 15.0,
              ),
            )),
      ));
      CryptoContainer.add(SizedBox(height: 5));
    }

    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(top: 20.0),
        child: Column(
          children: CryptoContainer,
        ),
      ),
    );
    // return Center(
    //   child: Text('Page One Content'),
    // );
  }
}

class PageTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Page One Content'),
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
      child: Text('Page Five Content'),
    );
  }
}
