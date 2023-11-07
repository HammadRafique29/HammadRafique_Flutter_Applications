import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vibration/vibration.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:convert';
import 'dart:io';

void main() {
  runApp(MaterialApp(
    home: DataLoadingScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

Map<String, dynamic> Dataset = {};
List<dynamic> TasbihsList = [];
String BackgroundImage = "Mosque1";

List<String> BackgroundImages = [
  "Mosque1",
  "Mosque2",
  "Mosque3",
  "Person Praying1",
  "Person Praying2",
  "Praying Place"
];

final Map<String, Color> ThemeColors = {
  "White": Colors.white,
  "Red": Colors.red,
  "Blue": Colors.blue,
  "Green": Colors.green,
  "Orange": Colors.orange,
  "Purple": Colors.purple,
  "Yellow": Colors.yellow.shade800,
  "Teal": Colors.teal,
  "Pink": Colors.pink,
  "Brown": Colors.brown
};

// #########################################################
//// ################ Data Loading Screen  #################

class DataLoadingScreen extends StatefulWidget {
  @override
  _DataLoadingScreenState createState() => _DataLoadingScreenState();
}

class _DataLoadingScreenState extends State<DataLoadingScreen> {
  Future<Map<String, dynamic>> loadData() async {
    // Simulate data loading from the "data.json" file
    await Future.delayed(Duration(seconds: 2)); //
    LocalDataStorage().saveDataToFile({
      "BackgroundImage": "Mosque3",
      "ColorScheme": "1",
      "Vibration": true,
      "Sound": true,
      "CountMax": 33,
      "Theme": "Red",
      "Vignetto": false,
      "Tasbih": [
        {
          "Ayate Karima": [0, 35, 0, 0]
        },
        {
          "SubhanAllah": [0, 35, 0, 0]
        },
        {
          "Alhamdulillah": [0, 35, 0, 0]
        },
        {
          "Allahuakbar": [0, 35, 0, 0]
        },
        {
          "La illaha illallah": [0, 35, 0, 0]
        },
        {
          "Astaghfir-Allah": [0, 35, 0, 0]
        },
        {
          "Bismillah": [0, 35, 0, 0]
        },
        {
          "Ya Waliyyul Hasanaat": [0, 35, 0, 0]
        },
        {
          "Laa hawla wa laa quwwata illa Billaah": [0, 35, 0, 0]
        },
        {
          "la Haola Wala Quwwata illa billahil Aliyil Azeem": [0, 35, 0, 0]
        },
        {
          "Allahuma Salli Ala Muhammadin Wa Aaale Muhammad": [0, 35, 0, 0]
        },
        {
          "Ash-hadu an la ilaha illallah, wahdahu la sharika lahu": [
            0,
            35,
            0,
            0
          ]
        },
        {
          "Subhaan Allaah wa bi hamdihi Subhaan Allaah il-'Azeem": [0, 35, 0, 0]
        },
        {
          "Subhaan Allaah, wa'l-hamdu Lillah, wa laa ilaah ill-Allaah, wa Allaahu akbar":
              [0, 35, 0, 0]
        },
        {
          "Allahumma, anta's-salam wa minkas'salam, Tabarakta-yal-dhal'Jalali wa'l-Ikram":
              [0, 35, 0, 0]
        }
      ]
    }); // Replace with your data loading logic
    final data = await LocalDataStorage().readDataFromFile();
    Dataset = data;
    TasbihsList = data["Tasbih"];
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // Data has been loaded, switch to the main content
          return Tasbeeh();
        } else {
          // Data is still loading, display the loading screen
          return Scaffold(
            body: Stack(
              children: [
                Container(
                  width: MediaQuery.sizeOf(context).width,
                  height: MediaQuery.sizeOf(context).height,
                  child: Image(
                    image: AssetImage("assets/images/Background.jpg"),
                    fit: BoxFit.fill,
                  ),
                ),
                Center(
                  child: Container(
                    width: MediaQuery.sizeOf(context).width * 0.5,
                    height: MediaQuery.sizeOf(context).height * 0.3,
                    child: Image(
                      image:
                          AssetImage("assets/images/Tasbih_Counter_Logo.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Positioned(
                  left: MediaQuery.sizeOf(context).width * 0.45,
                  top: MediaQuery.sizeOf(context).height * 0.7,
                  child: CircularProgressIndicator(),
                ),
              ],
            ),
            // body: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}

// #########################################################
//// ################ Tasbih DashBoard  ####################

class Tasbeeh extends StatefulWidget {
  Tasbeeh({super.key});
  @override
  State<Tasbeeh> createState() => _TasbeehState();
}

class _TasbeehState extends State<Tasbeeh> {
  // "Mosque2";
  Color? selectedColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    selectedColor = ThemeColors[Dataset["Theme"]];

    return Scaffold(
      // ############## App Bar ############
      appBar: AppBar(
        backgroundColor: selectedColor,
        title: Text(
          "Tasbeeh Counter",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => App_Setting(),
                ),
              );
              setState(() {
                BackgroundImage = Dataset["BackgroundImage"];
                selectedColor = ThemeColors[Dataset["Theme"]];
              });
            },
          )
        ],
      ),
      body: Stack(
        children: [
          Container(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.transparent
                    .withOpacity(0.5), // Adjust the opacity as needed
                BlendMode
                    .srcOver, // Blend mode to control how the color is applied
              ),
              child: Image(
                image: AssetImage("assets/images/${BackgroundImage}.jpg"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          // Creating Rows of Tasbihs (ListView.builder)
          ListView.builder(
              // ---- Dynamic Item Count
              itemCount: TasbihsList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 2.0,
                            ),
                          ]),
                      padding: const EdgeInsets.all(10.0),
                      margin: const EdgeInsets.all(14.0),
                      child: Tasbihs_List(TasbihsList, index)),
                  // ---- Dynamic on Tap Function
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Tasbih_Page(
                          set_value: TasbihsList[index]
                              [TasbihsList[index].keys.toList()[0]][1],
                          Dataset: Dataset,
                          index: index,
                        ),
                      ),
                    );
                    setState(() {
                      BackgroundImage = Dataset["BackgroundImage"];
                      selectedColor = ThemeColors[Dataset["Theme"]];
                    });
                  },
                );
              })
        ],
      ),
      // ############## Add Tasbeeb ############
      floatingActionButton: FloatingActionButton(
        backgroundColor: selectedColor,
        onPressed: () {
          Add_Tasbeeh_Popup(context);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget Tasbihs_List(List<dynamic> TasbihsList, int index) {
    return ListTile(
      leading: Container(
        width: MediaQuery.sizeOf(context).width * 0.55,
        child: Text(
          TasbihsList[index].keys.toList()[0],
          style: const TextStyle(fontSize: 18),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      trailing: Container(
        width: 100.0, //MediaQuery.sizeOf(context).width * 0.25,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // ---- Dynamic Tasbih Sets Count
                  Text(
                      "Count: ${TasbihsList[index][TasbihsList[index].keys.toList()[0]][0]}/${TasbihsList[index][TasbihsList[index].keys.toList()[0]][1]}"),
                  Text(
                      "(${TasbihsList[index][TasbihsList[index].keys.toList()[0]][2]})"),
                ],
              ),
            ),
            Container(
              child: Row(
                children: [
                  Text(
                    // ---- Dynamic Total Count
                    "Total Count: ${TasbihsList[index][TasbihsList[index].keys.toList()[0]][3]}",
                    style: const TextStyle(
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // #########################################################
  // ################## Add Tasbih Popup #####################

  void Add_Tasbeeh_Popup(BuildContext context) {
    TextEditingController TasbeehName = TextEditingController();
    TextEditingController TasbeehSets = TextEditingController();

    showDialog(
        context: context,
        builder: (BuildContext context) {
          Color? IconColor;
          if (selectedColor == Colors.white) {
            IconColor = Colors.blue;
          } else {
            IconColor = selectedColor;
          }

          // ######### Popup Dialog Box ###########
          return Dialog(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // ######### Popup Title ###########
                  const Padding(
                    padding: EdgeInsets.only(top: 5.0, bottom: 10.0),
                    child: Text(
                      "Enter Tasbih Name",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),

                  // ######### Input Fields 1 ###########
                  Container(
                    width: MediaQuery.sizeOf(context).width * 0.54,
                    height: MediaQuery.sizeOf(context).height * 0.05,
                    child: TextField(
                        controller: TasbeehName,
                        decoration: const InputDecoration(
                          hintText: 'Enter Tasbih Name',
                        )),
                  ),

                  // ######### Input Fields 2 ###########
                  Container(
                    width: MediaQuery.sizeOf(context).width * 0.54,
                    height: MediaQuery.sizeOf(context).height * 0.05,
                    child: TextField(
                        controller: TasbeehSets,
                        decoration: const InputDecoration(
                          hintText: 'Enter sets',
                        )),
                  ),

                  // ######### Save & Cancel ###########
                  Container(
                    width: MediaQuery.sizeOf(context).width * 0.54,
                    margin: const EdgeInsets.only(top: 20.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color?>(IconColor),
                            ),
                            child: const Text("Cancel"),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        const SizedBox(width: 2),
                        Expanded(
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color?>(IconColor),
                            ),
                            child: const Text("Save"),
                            onPressed: () {
                              setState(() {
                                TasbihsList.add({
                                  "${TasbeehName.text}": [
                                    0,
                                    int.parse(TasbeehSets.text),
                                    0,
                                    0
                                  ]
                                });
                                print(TasbihsList);
                                Dataset["Tasbih"] = TasbihsList;
                                LocalDataStorage().saveDataToFile(Dataset);
                              });
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

// #########################################################
//// ################ Tasbih Counter Page ##################

class Tasbih_Page extends StatefulWidget {
  final int set_value; // Argument to pass
  final Map<String, dynamic> Dataset;
  final int index;
  Tasbih_Page(
      {Key? key,
      required this.set_value,
      required this.Dataset,
      required this.index})
      : super(key: key);

  @override
  State<Tasbih_Page> createState() =>
      _Tasbih_PageState(set_value, Dataset, index);
}

class _Tasbih_PageState extends State<Tasbih_Page> {
  _Tasbih_PageState(this.set_value, this.Dataset, this.index);
  final int set_value;
  final Map<String, dynamic> Dataset;
  final int index;

  @override
  Widget build(BuildContext context) {
    String backgroundImage = Dataset?["BackgroundImage"];
    final List<dynamic> TasbihList = Dataset?["Tasbih"];
    Color? selectedColor = ThemeColors[Dataset["Theme"]];
    int Counter = TasbihList[index][TasbihList[index].keys.toList()[0]][0];

    return Scaffold(
        appBar: AppBar(
          backgroundColor: selectedColor,
          title: const Text("Tasbeeh Counter"),
          actions: [
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                setState(() {
                  int steps_value =
                      TasbihList[index][TasbihList[index].keys.toList()[0]][1];
                  TasbihList[index][TasbihList[index].keys.toList()[0]] = [
                    0,
                    steps_value,
                    0,
                    0
                  ];
                });
                // Reset Counter Func
              },
            ),
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => App_Setting(),
                  ),
                );
                setState(() {
                  BackgroundImage = Dataset["BackgroundImage"];
                  selectedColor = ThemeColors[Dataset["Theme"]];
                });
              },
            )
          ],
        ),
        body: Stack(
          children: [
            Container(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height,
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Colors.transparent
                      .withOpacity(0.5), // Adjust the opacity as needed
                  BlendMode
                      .srcOver, // Blend mode to control how the color is applied
                ),
                child: Image(
                  image: AssetImage("assets/images/${backgroundImage}.jpg"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20),
                  width: MediaQuery.sizeOf(context).width * 0.9,
                  height: MediaQuery.sizeOf(context).height * 0.25,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Center(
                      child: Text(
                        "${Dataset?["Tasbih"][index].keys.toList()[0]}",
                        style: TextStyle(
                          fontSize: 35,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: GestureDetector(
                      child: createCircularLoadingWidget(
                          set_value, Counter, index),
                      onTap: () {
                        setState(() {
                          if (Counter >= set_value) {
                            Counter = 1;
                            if (Dataset["Sound"] == true) {
                              AudioPlayer().play(AssetSource('tap.wav'));
                            }
                            if (Dataset["Vibration"] == true) {
                              Vibration.vibrate(duration: 110);
                            }

                            TasbihList[index]
                                [TasbihList[index].keys.toList()[0]][2] += 1;
                            TasbihList[index]
                                    [TasbihList[index].keys.toList()[0]][0] =
                                Counter;
                            TasbihList[index]
                                    [TasbihList[index].keys.toList()[0]]
                                [3] = TasbihList[index]
                                            [TasbihList[index].keys.toList()[0]]
                                        [1] *
                                    TasbihList[index]
                                            [TasbihList[index].keys.toList()[0]]
                                        [2] +
                                Counter;
                            Dataset["Tasbih"] = TasbihList;
                            LocalDataStorage().saveDataToFile(Dataset);
                          } else {
                            setState(() {
                              Counter += 1;
                              if (Dataset["Sound"] == true) {
                                AudioPlayer().play(AssetSource('tap.wav'));
                              }
                              if (Dataset["Vibration"] == true) {
                                Vibration.vibrate(duration: 110);
                              }
                              TasbihList[index]
                                      [TasbihList[index].keys.toList()[0]][0] =
                                  Counter;
                              TasbihList[index]
                                      [TasbihList[index].keys.toList()[0]][3] =
                                  TasbihList[index][TasbihList[index]
                                              .keys
                                              .toList()[0]][1] *
                                          TasbihList[index][TasbihList[index]
                                              .keys
                                              .toList()[0]][2] +
                                      Counter;
                              Dataset["Tasbih"] = TasbihList;
                              LocalDataStorage().saveDataToFile(Dataset);
                              // WriteData(["Tasbih", TasbihList]);
                            });
                          }
                        });
                      },
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      Text(
                        "Set Completed: ${TasbihList[index][TasbihList[index].keys.toList()[0]][2]}",
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                      Text(
                        "Commulative: ${TasbihList[index][TasbihList[index].keys.toList()[0]][2] * TasbihList[index][TasbihList[index].keys.toList()[0]][1] + TasbihList[index][TasbihList[index].keys.toList()[0]][0]}",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.25,
                )
              ],
            ),
          ],
        ));
  }
}

Widget createCircularLoadingWidget(int totalCounter, int currentCount, index) {
  double progress = currentCount / totalCounter;
  Color? selectedColor = ThemeColors[Dataset["Theme"]];

  if (progress == 0) {
    progress = Dataset["Tasbih"][index]
            [Dataset["Tasbih"][index].keys.toList()[0]][0] /
        Dataset["Tasbih"][index][Dataset["Tasbih"][index].keys.toList()[0]][1];
  }
  return Stack(
    alignment: Alignment.center,
    children: [
      Container(
        width: 260, // Adjust the width and height as needed
        height: 260,
        child: CircularProgressIndicator(
          color: ThemeColors[
              Dataset["Theme"]], //const Color.fromARGB(255, 22, 254, 30),
          backgroundColor: Colors.grey,
          value: progress,
          strokeWidth: 5, // Adjust the thickness of the progress bar
        ),
      ),
      Container(
        width: 250, // Adjust the width and height as needed
        height: 250,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color:
              Colors.white.withOpacity(0.2), // Background color of the circle
        ),
        child: Center(
          child: Text(
            '${Dataset["Tasbih"][index][Dataset["Tasbih"][index].keys.toList()[0]][0]}',
            style: const TextStyle(
              fontSize: 55,
              color: Colors.white,
            ),
          ),
        ),
      ),
    ],
  );
}

// #####################################################
// ################## Setting Page #####################
// #####################################################

class App_Setting extends StatefulWidget {
  App_Setting({super.key});
  @override
  State<App_Setting> createState() => _App_SettingState();
}

class _App_SettingState extends State<App_Setting> {
  bool isVibrationOn = Dataset["Vibration"];
  bool isSoundOn = Dataset["Sound"];
  bool isVignetteOn = Dataset["Vignetto"];
  int CountMax = Dataset["CountMax"];
  String BackgroundImageName = Dataset["BackgroundImage"];
  Color? selectedColor = Colors.white;
  int selectedImage = 0;
  TextEditingController CountMx = TextEditingController();

  List<GestureDetector> ColorContainer() {
    final Map<Color, String> colors = {
      Colors.white: "White",
      Colors.red: "Red",
      Colors.blue: "Blue",
      Colors.green: "Green",
      Colors.orange: "Orange",
      Colors.purple: "Purple",
      Colors.yellow.shade800: "Yellow",
      Colors.teal: "Teal",
      Colors.pink: "Pink",
      Colors.brown: "Brown",
    };

    List<GestureDetector> CustomWidgets = [];
    for (var colr in colors.keys.toList()) {
      CustomWidgets.add(
        GestureDetector(
            onTap: () {
              setState(() {
                selectedColor = colr;
                Dataset["Theme"] = colors[colr];
                LocalDataStorage().saveDataToFile(Dataset);
              });
            },
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(left: 5.0, right: 5.0),
                width: 40,
                height: 50,
                color: colr,
              ),
            )),
      );
    }
    return CustomWidgets;
  }

  @override
  Widget build(BuildContext context) {
    selectedColor = ThemeColors[Dataset["Theme"]];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors[Dataset["Theme"]],
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context, "True");
            setState(() {
              BackgroundImageName = Dataset["BackgroundImage"];
            });
          },
        ),
        title: Text(
          "Settings",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          Container(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.transparent
                    .withOpacity(0.5), // Adjust the opacity as needed
                BlendMode
                    .srcOver, // Blend mode to control how the color is applied
              ),
              child: Image(
                image: AssetImage("assets/images/${BackgroundImageName}.jpg"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey)),
              ),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.sizeOf(context).width * 0.9,
                    margin: EdgeInsets.only(top: 10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: ListTile(
                      title: Text(
                        "Vibration",
                        style: TextStyle(color: selectedColor, fontSize: 20),
                      ),
                      trailing: Switch(
                        activeColor: selectedColor,
                        value:
                            isVibrationOn, // Replace isVibrationOn with your variable for the state of vibration
                        onChanged: (newValue) {
                          // Handle the switch state change here
                          setState(() {
                            isVibrationOn = newValue;
                            Dataset["Vibration"] = newValue;
                            // You can add logic here to control vibration settings
                          });
                        },
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.sizeOf(context).width * 0.9,
                    margin: EdgeInsets.only(top: 10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: ListTile(
                      title: Text(
                        "Sound",
                        style: TextStyle(color: selectedColor, fontSize: 20),
                      ),
                      trailing: Switch(
                        activeColor: selectedColor,
                        value:
                            isSoundOn, // Replace isVibrationOn with your variable for the state of vibration
                        onChanged: (newValue) {
                          // Handle the switch state change here
                          setState(() {
                            isSoundOn = newValue;
                            Dataset["Sound"] = newValue;
                            // You can add logic here to control vibration settings
                          });
                        },
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.sizeOf(context).width * 0.9,
                    margin: EdgeInsets.only(top: 10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: ListTile(
                      title: Text(
                        "Count Max",
                        style: TextStyle(color: selectedColor, fontSize: 20),
                      ),
                      trailing: Container(
                        width: 100, // Adjust the width as needed
                        child: TextField(
                          style: TextStyle(color: selectedColor, fontSize: 20),
                          controller: TextEditingController(text: '$CountMax'),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(15),
                    width: MediaQuery.sizeOf(context).width * 0.9,
                    padding: EdgeInsets.all(10),
                    height: MediaQuery.sizeOf(context).height * 0.12,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white.withOpacity(0.5),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Theme",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        const SizedBox(height: 5),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: ColorContainer(),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.sizeOf(context).width * 0.9,
                    padding: EdgeInsets.all(10),
                    // height: MediaQuery.sizeOf(context).height*0.12,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white.withOpacity(0.2),
                    ),
                    child: ListTile(
                      leading: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            if (selectedImage > 0) {
                              selectedImage -= 1;
                              BackgroundImageName = Dataset["BackgroundImage"] =
                                  BackgroundImages[selectedImage];
                              LocalDataStorage().saveDataToFile(Dataset);
                            } else if (selectedImage == 0) {
                              selectedImage = BackgroundImages.length - 1;
                              BackgroundImageName = Dataset["BackgroundImage"] =
                                  BackgroundImages[selectedImage];
                              LocalDataStorage().saveDataToFile(Dataset);
                            } else {}
                          });
                        },
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            if (selectedImage <
                                BackgroundImages.length - 1.toInt()) {
                              selectedImage += 1;
                              BackgroundImageName = Dataset["BackgroundImage"] =
                                  BackgroundImages[selectedImage];
                              LocalDataStorage().saveDataToFile(Dataset);
                            } else if (selectedImage ==
                                BackgroundImages.length - 1) {
                              selectedImage = 0;
                              BackgroundImageName = Dataset["BackgroundImage"] =
                                  BackgroundImages[selectedImage];
                              LocalDataStorage().saveDataToFile(Dataset);
                            } else {}
                          });
                        },
                      ),
                      title: Center(
                        child: Text(
                          "$BackgroundImageName",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontStyle: FontStyle.italic),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(15),
                    width: MediaQuery.sizeOf(context).width * 0.9,
                    padding: EdgeInsets.all(10),
                    // height: MediaQuery.sizeOf(context).height*0.12,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white.withOpacity(0.3),
                    ),
                    child: ListTile(
                      title: Text(
                        "Vignette",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      trailing: Switch(
                        activeColor: selectedColor,
                        value:
                            isVignetteOn, // Replace isVibrationOn with your variable for the state of vibration
                        onChanged: (newValue) {
                          // Handle the switch state change here
                          setState(() {
                            isVignetteOn = newValue;
                            Dataset["Vignetto"] = newValue;
                            LocalDataStorage().saveDataToFile(Dataset);
                            // You can add logic here to control vibration settings
                          });
                        },
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.sizeOf(context).width * 0.6,
                    height: MediaQuery.sizeOf(context).height * 0.055,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: selectedColor,
                    ),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color?>(selectedColor),
                      ),
                      child: const Text(
                        "RESET ALL SETTINGS",
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () {
                        setState(() {
                          isVibrationOn = Dataset["Vibration"] = true;
                          isSoundOn = Dataset["SOund"] = true;
                          CountMax = Dataset["CountMax"] = 33;
                          Dataset["Theme"] = "Yellow";
                          isVignetteOn = Dataset["Vignetto"] = false;
                          LocalDataStorage().saveDataToFile(Dataset);
                          selectedColor = Colors.white;
                        });
                      },
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }
}

// #####################################################
// ################## Data Read Write ##################
// #####################################################

class LocalDataStorage {
  Future<Directory> getLocalDirectory() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory;
  }

  Future<void> saveDataToFile(Map<String, dynamic> data) async {
    final directory = await getLocalDirectory();
    final file = File('${directory.path}/data.json');

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
    final file = File('${directory.path}/data.json');

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
