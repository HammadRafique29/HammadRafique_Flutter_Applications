import 'package:flutter/material.dart';
import 'package:trading_app/screens/Login.dart';
import 'package:trading_app/screens/coinPage.dart';
import 'sampleData.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'localDataStorage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:io';
import 'package:trading_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart' as p;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:url_launcher/url_launcher.dart';

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
            onTap: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CoinScreen(
                    coinName: crypto[i],
                  ),
                ),
              );
              getJsonData();
              setState(() {});
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
    //

    return CryptoContainer.length > 0
        ? SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(top: 20.0),
              child: Column(
                children: CryptoContainer,
              ),
            ),
          )
        : Center(child: Text("Please Add Coins To Favorite First"));
  }
}

class PageThree extends StatefulWidget {
  const PageThree({super.key});

  @override
  State<PageThree> createState() => _PageThreeState();
}

class _PageThreeState extends State<PageThree> {
  TextEditingController _controller = TextEditingController();
  String? _selectedValue;
  String _message = '';
  List<String> values = [];
  Map<dynamic, dynamic> coinsIcons = {};
  var SelectedCoin = null;

  void getCoingsValues() {
    for (int i = 0; i < crypto.length; i++) {
      values.add(crypto[i]["id"]);
    }
    print(values);
  }

  void getCoingsIcons() {
    for (int i = 0; i < crypto.length; i++) {
      coinsIcons.addAll({
        crypto[i]["id"]: [crypto[i]["image"], crypto[i]["current_price"]]
      });
    }
    print(coinsIcons);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCoingsValues();
    getCoingsIcons();
  }

  // Override the build method to return the widget tree
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.sizeOf(context).width * 0.8,
        height: MediaQuery.sizeOf(context).height * 0.4,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1, color: Colors.grey),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            DropdownButton<String>(
              value: _selectedValue, // The current selected value
              items: values // The list of values from the widget class
                  .map((value) => DropdownMenuItem<String>(
                        value: value, // The value of the item
                        child: Row(
                          children: [
                            Image.network(coinsIcons[value][0],
                                width: 20, height: 20),
                            SizedBox(width: 10),
                            Text(value)
                          ],
                        ), // The text to display
                      ))
                  .toList(), // Convert the map to a list
              hint: const Text(
                  'Select a value'), // The hint to show when no value is selected
              onChanged: (value) {
                // The callback to handle the value change
                setState(() {
                  // Update the selected value
                  _selectedValue = value;
                  SelectedCoin = _selectedValue;
                });
              },
            ),
            SelectedCoin != null
                ? Container(
                    margin: EdgeInsets.all(10),
                    child: Image.network(
                      coinsIcons[_selectedValue][0],
                    ),
                    width: 100,
                    height: 100)
                : SizedBox(),
            Container(
              width: MediaQuery.sizeOf(context).width * 0.6,
              height: 50,
              child: TextField(
                controller: _controller, // The controller for the text field
                keyboardType:
                    TextInputType.number, // The keyboard type for numbers
                decoration: const InputDecoration(
                  labelText: 'Number of Coins', // The label for the text field
                  border: OutlineInputBorder(), // The border for the text field
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 30,
              width: MediaQuery.sizeOf(context).width * 0.6,
              child: Expanded(
                  child: ElevatedButton(
                child: Text('Calculate'), // The text to display on the button
                onPressed: () {
                  setState(() {
                    _message =
                        'Total USD: ${int.parse(_controller.text) * coinsIcons[_selectedValue][1]}';
                  });
                },
              )),
            ),
            SizedBox(height: 15),
            Text(
              _message,
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}

class PageFour extends StatefulWidget {
  const PageFour({super.key});

  @override
  State<PageFour> createState() => _PageFourState();
}

class _PageFourState extends State<PageFour> {
  List<Widget> Posts = [];
  List<Widget> Images = [];
  List<Widget> Videos = [];
  double postSize = 150;
  bool adminLogin = false;

  YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: "dQw4w9WgXcQ",
    flags: YoutubePlayerFlags(
      autoPlay: true,
      mute: false,
    ),
  );

  Future<void> launchURL(String url) async {
    // Check if the URL can be launched
    if (await canLaunch(url)) {
      // Launch the URL in the default browser
      await launch(
        url,
        forceSafariVC: false, // For iOS
        forceWebView: false, // For Android
      );
    } else {
      // Throw an error if the URL is invalid or cannot be launched
      throw 'Could not launch $url';
    }
  }

  void getPosts() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    DatabaseReference ref = FirebaseDatabase.instance.ref();

    final snapshot = await ref.child('Posts').get();
    if (snapshot.exists) {
      var data = snapshot.value as Map<dynamic, dynamic>;
      for (var dataPost in data.entries) {
        var dataPostItems = dataPost.value[0];

        for (int i = 0; i < dataPostItems["images"].length; i++) {
          print(dataPostItems["images"][i]);
          Images.add(Center(
              child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.network(
              dataPostItems["images"][i],
              width: MediaQuery.sizeOf(context).width * 0.7,
              height: 150,
            ),
          )));
          Images.add(SizedBox(height: 5));
        }

        String? videoId =
            YoutubePlayer.convertUrlToId('${dataPostItems["video"][0]}');

        if (videoId != null) {
          _controller = YoutubePlayerController(
            initialVideoId: videoId,
            flags: YoutubePlayerFlags(
              autoPlay: false,
              mute: false,
            ),
          );
        }

        print("## ${dataPostItems}");
        //
        setState(
          () {
            Posts.add(
              GestureDetector(
                onTap: () {
                  launchURL('https://www.google.com');
                },
                child: Container(
                  margin: EdgeInsets.only(
                      top: 10, left: MediaQuery.sizeOf(context).width * 0.08),
                  width: MediaQuery.sizeOf(context).width * 0.8,
                  // height: postSize < 150 ? 230 : postSize + 70.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 2, color: Colors.amber),
                  ),
                  child: Column(
                    children: [
                      Container(
                        // height: postSize!,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10),
                              Center(
                                child: Text(
                                  "${dataPostItems["title"]}",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.amber),
                                ),
                              ),
                              SizedBox(height: 5),
                              Padding(
                                padding: EdgeInsets.only(left: 30, right: 30),
                                child: Text("${dataPostItems["para"]}",
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.normal,
                                    )),
                              ),
                              SizedBox(height: 5),
                              Column(
                                children: Images,
                              ),
                              SizedBox(height: 10),
                              Center(
                                child: Container(
                                  width: MediaQuery.sizeOf(context).width * 0.7,
                                  child: YoutubePlayer(
                                    controller: _controller,
                                    showVideoProgressIndicator: true,
                                    progressIndicatorColor: Colors.blueAccent,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }
    }
  }

  void getLoginType() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? userLogedin = prefs.getBool('loginExists');
    if (userLogedin != null && userLogedin) {
      final String? userLogedin = prefs.getString('loginType');
      if (userLogedin == "admin") {
        setState(() {
          adminLogin = true;
        });
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPosts();
    getLoginType();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: Posts,
        ),
      ),
      floatingActionButton: adminLogin
          ? Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.only(right: 16.0, bottom: 16.0),
                child: FloatingActionButton(
                  backgroundColor: Colors.amber[400]!.withOpacity(0.8),
                  onPressed: () {
                    // Add your onPressed logic here
                    showDialog(
                      context: context,
                      builder: (context) => PostDialog(),
                    );
                  },
                  child: Icon(Icons.add, color: Colors.white),
                ),
              ),
            )
          : Container(),
    );
  }
}

class PageFive extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              final result = await Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
            child: const Text("Logout"),
          ),
          ElevatedButton(
            onPressed: () async {
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();
              final bool? userLogedin = prefs.getBool('loginExists');
              if (userLogedin != null) {
                print("### ${userLogedin}");
                await prefs.setBool('loginExists', false);
              } else {}
            },
            child: const Text("Logout"),
          )
        ],
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

class PostDialog extends StatefulWidget {
  const PostDialog({super.key});

  @override
  State<PostDialog> createState() => _PostDialogState();
}

class _PostDialogState extends State<PostDialog> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController paragraphController = TextEditingController();
  List<dynamic> files = [];

  Future<File?> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    return pickedFile != null ? File(pickedFile.path) : null;
  }

  Future<File?> _pickVideo() async {
    final pickedFile =
        await ImagePicker().pickVideo(source: ImageSource.gallery);
    return pickedFile != null ? File(pickedFile.path) : null;
  }

  // Future<void> uploadFile(File file) async {
  //   await Firebase.initializeApp(
  //     options: DefaultFirebaseOptions.currentPlatform,
  //   );
  //   firebase_storage.FirebaseStorage storage =
  //       firebase_storage.FirebaseStorage.instance;
  //   FirebaseFirestore firestore = FirebaseFirestore.instance;
  //   firebase_storage.Reference ref =
  //       storage.ref().child("post_images/"); //p.basename(file.path));

  //   // Upload the file to firebase
  //   firebase_storage.UploadTask task = ref.putFile(file);

  //   // Wait for the task to complete and get the download url
  //   String url = await (await task).ref.getDownloadURL();

  //   // Print the url for debugging
  //   print("@@ ${url}");
  // }

  @override
  Widget build(BuildContext context) {
    List<Widget> attachments = [];

    for (int i = 0; i < files.length; i++) {
      attachments.add(Icon(
        Icons.file_present,
        size: 20,
      ));
    }

    // Return a Dialog widget with a custom shape and content
    return Dialog(
      // backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
          height: MediaQuery.sizeOf(context).height * 0.6,
          width: MediaQuery.sizeOf(context).width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          padding: EdgeInsets.only(top: 5.0, left: 10, right: 10, bottom: 5.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 10),
                Container(
                  color: Colors.white,
                  height: MediaQuery.sizeOf(context).height * 0.05,
                  child: TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                SingleChildScrollView(
                  child: Container(
                    color: Colors.white,
                    height: MediaQuery.sizeOf(context).height > 800
                        ? MediaQuery.sizeOf(context).height * 0.45
                        : MediaQuery.sizeOf(context).height * 0.35,
                    child: TextField(
                      controller: paragraphController,
                      maxLines: 100,
                      decoration: InputDecoration(
                        labelText: 'Paragraph',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                files.length > 0
                    ? SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: attachments,
                        ),
                      )
                    : SizedBox(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.camera_alt, color: Colors.amber),
                      onPressed: () async {
                        var image = await _pickImage();
                        setState(() {
                          files.add(image);
                        });
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.video_collection_rounded,
                          color: Colors.amber),
                      onPressed: () async {
                        File? video = await _pickVideo();

                        if (video != null) {
                          // Upload the video to firebase
                          // await uploadFile(video);
                          setState(() {
                            files.add(video);
                          });
                        }
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.link, color: Colors.amber),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.send, color: Colors.amber),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
