import 'package:flutter/material.dart';
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

class PageThree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Page Three Content'),
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
  YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: "dQw4w9WgXcQ",
    flags: YoutubePlayerFlags(
      autoPlay: true,
      mute: false,
    ),
  );

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

        // print("### ${dataPostItems}");

        for (int i = 0; i < dataPostItems["images"].length; i++) {
          print(dataPostItems["images"][i]);
          Images.add(Center(
              child: Image.network(
            dataPostItems["images"][i],
            width: MediaQuery.sizeOf(context).width * 0.7,
            height: 150,
          )));
          Images.add(SizedBox(height: 5));
        }

        String? videoId =
            YoutubePlayer.convertUrlToId('${dataPostItems["video"][0]}');

        if (videoId != null) {
          _controller = YoutubePlayerController(
            initialVideoId: videoId,
            flags: YoutubePlayerFlags(
              autoPlay: true,
              mute: false,
            ),
          );
        }

        print("## ${dataPostItems}");
        setState(
          () {
            Posts.add(
              Container(
                margin: EdgeInsets.only(top: 10),
                width: MediaQuery.sizeOf(context).width * 0.8,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 2, color: Colors.amber),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Center(
                      child: Text("${dataPostItems["title"]}"),
                    ),
                    SizedBox(height: 5),
                    Padding(
                      padding: EdgeInsets.only(left: 40, right: 40),
                      child: Text("${dataPostItems["para"]}"),
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
            );
          },
        );
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPosts();
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
      floatingActionButton: Align(
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
      ),
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

// // Define a custom dialog class that extends StatelessWidget
// class PostDialoga extends StatelessWidget {
//   // Declare the text editing controllers for the title and the paragraph
//   final TextEditingController titleController = TextEditingController();
//   final TextEditingController paragraphController = TextEditingController();
//   List<dynamic> files = [];

// // Define a function to pick an image from the gallery and return it as a File
//   Future<File?> _pickImage() async {
//     // Use the image_picker package to get the image
//     final pickedFile =
//         await ImagePicker().pickImage(source: ImageSource.gallery);

//     // Return the image as a File if it is not null, otherwise return null
//     return pickedFile != null ? File(pickedFile.path) : null;
//   }

//   Future<File?> _pickVideo() async {
//     // Use the image_picker package to get the video
//     final pickedFile =
//         await ImagePicker().pickVideo(source: ImageSource.gallery);

//     // Return the video as a File if it is not null, otherwise return null
//     return pickedFile != null ? File(pickedFile.path) : null;
//   }

//   Future<void> _uploadVideo(File? video, String name) async {
//     // Check if the video is not null
//     if (video != null) {
//       // Create a reference to the firebase storage
//       FirebaseStorage storage = FirebaseStorage.instance;

//       // Create a reference to the specific location with the given name
//       Reference ref = storage.ref().child(name);

//       // Upload the file to firebase storage
//       UploadTask task = ref.putFile(video);

//       // Wait for the task to complete and get the download url
//       String url = await (await task).ref.getDownloadURL();

//       // Print the url for debugging
//       print(url);
//     }
//   }

//   // Override the build method to return a Dialog widget
//   @override
//   Widget build(BuildContext context) {
//     List<Widget> attachments = [];

//     for (int i = 0; i < files.length; i++) {
//       attachments.add(Icon(
//         Icons.file_present,
//         size: 40,
//       ));
//     }

//     // Return a Dialog widget with a custom shape and content
//     return Dialog(
//       // backgroundColor: Colors.transparent,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12.0),
//       ),
//       child: Container(
//           height: MediaQuery.sizeOf(context).height * 0.6,
//           width: MediaQuery.sizeOf(context).width,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10),
//             color: Colors.white,
//           ),
//           padding: EdgeInsets.only(top: 5.0, left: 10, right: 10, bottom: 5.0),
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: <Widget>[
//                 SizedBox(height: 10),
//                 Container(
//                   color: Colors.white,
//                   height: MediaQuery.sizeOf(context).height * 0.05,
//                   child: TextField(
//                     controller: titleController,
//                     decoration: InputDecoration(
//                       labelText: 'Title',
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 // A TextField widget for the paragraph input
//                 SingleChildScrollView(
//                   child: Container(
//                     color: Colors.white,
//                     height: MediaQuery.sizeOf(context).height > 800
//                         ? MediaQuery.sizeOf(context).height * 0.45
//                         : MediaQuery.sizeOf(context).height * 0.35,
//                     child: TextField(
//                       controller: paragraphController,
//                       maxLines: 100,
//                       decoration: InputDecoration(
//                         labelText: 'Paragraph',
//                         border: OutlineInputBorder(),
//                       ),
//                     ),
//                   ),
//                 ),
//                 files.length > 0
//                     ? SingleChildScrollView(
//                         scrollDirection: Axis.horizontal,
//                         child: Row(
//                           children: attachments,
//                         ),
//                       )
//                     : SizedBox(),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: <Widget>[
//                     IconButton(
//                       icon: Icon(Icons.camera_alt, color: Colors.amber),
//                       onPressed: () {
//                         var image = _pickImage();
//                       },
//                     ),
//                     IconButton(
//                       icon: Icon(Icons.video_collection_rounded,
//                           color: Colors.amber),
//                       onPressed: () {},
//                     ),
//                     IconButton(
//                       icon: Icon(Icons.link, color: Colors.amber),
//                       onPressed: () {},
//                     ),
//                     IconButton(
//                       icon: Icon(Icons.send, color: Colors.amber),
//                       onPressed: () {},
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           )),
//     );
//   }
// }
