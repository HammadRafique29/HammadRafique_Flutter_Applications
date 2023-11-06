import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'dart:io';

void main() {
  runApp(MaterialApp(
    home: Tasbeeh(),
    debugShowCheckedModeBanner: false,
  ));
}

Map<String, dynamic> Dataset = {};
List<dynamic> TasbihsList = [];

class Tasbeeh extends StatefulWidget {
  Tasbeeh({super.key});

  @override
  State<Tasbeeh> createState() => _TasbeehState();
}

class _TasbeehState extends State<Tasbeeh> {
  String backgroundImage = "Mosque1"; // "Mosque2";


  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    LocalDataStorage().saveDataToFile({"BackgroundImage":"Mosque3","ColorScheme":"1","Vibration":true, "Sound":true, "CountMax":33, "Theme":"white", "Vignetto": false, "Tasbih":[{"Ayate Karima":[0,35,0,0]},{"SubhanAllah":[0,35,0,0]},{"Alhamdulillah":[0,35,0,0]},{"Allahuakbar":[0,35,0,0]},{"La illaha illallah":[0,35,0,0]},{"Astaghfir-Allah":[0,35,0,0]},{"Bismillah":[0,35,0,0]},{"Ya Waliyyul Hasanaat":[0,35,0,0]},{"Laa hawla wa laa quwwata illa Billaah":[0,35,0,0]},{"la Haola Wala Quwwata illa billahil Aliyil Azeem":[0,35,0,0]},{"Allahuma Salli Ala Muhammadin Wa Aaale Muhammad":[0,35,0,0]},{"Ash-hadu an la ilaha illallah, wahdahu la sharika lahu":[0,35,0,0]},{"Subhaan Allaah wa bi hamdihi Subhaan Allaah il-'Azeem":[0,35,0,0]},{"Subhaan Allaah, wa'l-hamdu Lillah, wa laa ilaah ill-Allaah, wa Allaahu akbar":[0,35,0,0]},{"Allahumma, anta's-salam wa minkas'salam, Tabarakta-yal-dhal'Jalali wa'l-Ikram":[0,35,0,0]}]});

    final data = await LocalDataStorage().readDataFromFile();

    if (data != null) {
      Dataset = data;
      TasbihsList = data["Tasbih"];
      print('Read data: $data');
    }

    // final String data = await rootBundle.loadString("assests/data.json");
    // Map<String, dynamic> jsonData = json.decode(data);
    // TasbihsList = jsonData["Tasbih"];
    // backgroundImage = jsonData["BackgroundImage"];
    // Dataset = jsonData;
  }

  @override
  Widget build(BuildContext context) {
    print(backgroundImage);

    return Scaffold(
      // ############## App Bar ############
      appBar: AppBar(
        title: Text("Tasbeeh Application"),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              print('Cancel Pressed');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => App_Setting(),
                ),
              );
            },
          )
        ],
      ),
      body: Stack(
        children: [
          Container(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            child: Image(
              // Dynamic Background Image Data
              image: AssetImage("assests/images/${backgroundImage}.jpg"),
              fit: BoxFit.fill,
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
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 2.0,
                            ),
                          ]),
                      padding: EdgeInsets.all(10.0),
                      margin: EdgeInsets.all(14.0),
                      child: Tasbihs_List(TasbihsList, index)),
                  // ---- Dynamic on Tap Function
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Tasbih_Page(
                          set_value: TasbihsList[index][TasbihsList[index].keys.toList()[0]][1],
                          Dataset: Dataset,
                          index: index,
                        ),
                      ),
                    );
                  },
                );
              })
        ],
      ),
      // ############## Add Tasbeeb ############
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Add_Tasbeeh_Popup(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  // #########################################################
  // ################## Tasbih ListTile  #####################

  Widget Tasbihs_List(List<dynamic> TasbihsList, int index) {
    return ListTile(
      leading: Container(
        width: MediaQuery.sizeOf(context).width * 0.55,
        // ---- Dynamic Tasbih Name
        child: Text(
          TasbihsList[index].keys.toList()[0],
          style: TextStyle(
            fontSize: 15,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      trailing: Container(
        width: MediaQuery.sizeOf(context).width * 0.25,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // ---- Dynamic Tasbih Sets Count
                  Text("Count: ${TasbihsList[index][TasbihsList[index].keys.toList()[0]][0]}/${TasbihsList[index][TasbihsList[index].keys.toList()[0]][1]}"),
                  Text("(${TasbihsList[index][TasbihsList[index].keys.toList()[0]][2]})"),
                ],
              ),
            ),
            Container(
              child: Row(
                children: [
                  Text(
                    // ---- Dynamic Total Count
                    "Total Count: ${TasbihsList[index][TasbihsList[index].keys.toList()[0]][3]}",
                    style: TextStyle(
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
                    margin: EdgeInsets.only(top: 20.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            child: const Text("Cancel"),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        const SizedBox(width: 2),
                        Expanded(
                          child: ElevatedButton(
                            child: const Text("Save"),
                            onPressed: () {
                              setState(() {
                                TasbihsList.add({"${TasbeehName.text}":[0,int.parse(TasbeehSets.text),0,0]});
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
  Tasbih_Page({Key? key, required this.set_value, required this.Dataset, required this.index}) : super(key: key);

  @override
  State<Tasbih_Page> createState() => _Tasbih_PageState(set_value, Dataset, index);
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
    int Counter = TasbihList[index][TasbihList[index].keys.toList()[0]][0];

    return Scaffold(
        appBar: AppBar(
          title: Text("Tasbeeh Counter"),
          actions: [
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                setState(() {
                  int steps_value = TasbihList[index][TasbihList[index].keys.toList()[0]][1];
                  TasbihList[index][TasbihList[index].keys.toList()[0]] = [0,steps_value,0,0];
                });
                // Reset Counter Func
              },
            ),
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => App_Setting(),
                  ),
                );
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
                  image: AssetImage("assests/images/${backgroundImage}.jpg"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top:20),
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
                      child: createCircularLoadingWidget(set_value, Counter, index),
                      onTap: () {
                        setState(() {
                          if (Counter >= set_value) {
                            Counter = 1;
                            TasbihList[index][TasbihList[index].keys.toList()[0]][2] += 1;
                            TasbihList[index][TasbihList[index].keys.toList()[0]][0] = Counter;
                            TasbihList[index][TasbihList[index].keys.toList()[0]][3] = TasbihList[index][TasbihList[index].keys.toList()[0]][1] * TasbihList[index][TasbihList[index].keys.toList()[0]][2] + Counter;
                            Dataset["Tasbih"] = TasbihList;
                            LocalDataStorage().saveDataToFile(Dataset);
                            // WriteData(["Tasbih", TasbihList]);
                          } else {
                            setState(() {
                              Counter += 1;
                              TasbihList[index][TasbihList[index].keys.toList()[0]][0] = Counter;
                              TasbihList[index][TasbihList[index].keys.toList()[0]][3] = TasbihList[index][TasbihList[index].keys.toList()[0]][1] * TasbihList[index][TasbihList[index].keys.toList()[0]][2] + Counter;
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
                        "Commulative: ${TasbihList[index][TasbihList[index].keys.toList()[0]][2]*TasbihList[index][TasbihList[index].keys.toList()[0]][1] + TasbihList[index][TasbihList[index].keys.toList()[0]][0]}",
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
  if (progress == 0) {
    progress = Dataset["Tasbih"][index][Dataset["Tasbih"][index].keys.toList()[0]][0] / Dataset["Tasbih"][index][Dataset["Tasbih"][index].keys.toList()[0]][1];
  }
  return Stack(
    alignment: Alignment.center,
    children: [
      Container(
        width: 260, // Adjust the width and height as needed
        height: 260,
        child: CircularProgressIndicator(
          color: Color.fromARGB(255, 22, 254, 30),
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
            style: TextStyle(
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
  String backgroundImage = Dataset["BackgroundImage"];
  String BackgroundImageName = Dataset["BackgroundImage"];
  Color selectedColor = Colors.white;
  TextEditingController CountMx = TextEditingController();

  List<GestureDetector> ColorContainer() {
    final List<Color> colors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.yellow,
      Colors.teal,
      Colors.pink,
      Colors.brown,
      Colors.black,
    ];
    List<GestureDetector> CustomWidgets = [];
    for (var colr in colors) {
      CustomWidgets.add(
        GestureDetector(
            onTap: () {
              setState(() {
                selectedColor = colr;
              });
            },
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(left: 5.0, right: 5.0),
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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("Settings"),
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
                image: AssetImage("assests/images/${backgroundImage}.jpg"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey)),
              ),
              child: Column(
                children: [
                  ListTile(
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
                  ListTile(
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
                  ListTile(
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
                  Container(
                    margin: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Theme",
                          style: TextStyle(color: selectedColor, fontSize: 20),
                        ),
                        SizedBox(height: 5),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: ColorContainer(),
                          ),
                        )
                      ],
                    ),
                  ),
                  ListTile(
                    leading: IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        setState(() {
                          BackgroundImageName = "BackgroundImage";
                        });
                      },
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.arrow_forward),
                      onPressed: () {
                        setState(() {
                          BackgroundImageName = "ForwardImage";
                        });
                      },
                    ),
                    title: Center(
                      child: Text(
                        "$BackgroundImageName",
                        style: TextStyle(color: selectedColor, fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "Vignette",
                      style: TextStyle(color: selectedColor, fontSize: 20),
                    ),
                    trailing: Switch(
                      activeColor: selectedColor,
                      value:
                          isVignetteOn, // Replace isVibrationOn with your variable for the state of vibration
                      onChanged: (newValue) {
                        // Handle the switch state change here
                        setState(() {
                          isVignetteOn = newValue;
                          // You can add logic here to control vibration settings
                        });
                      },
                    ),
                  ),
                  Container(
                    width: MediaQuery.sizeOf(context).width * 0.5,
                    height: MediaQuery.sizeOf(context).height * 0.035,
                    color: selectedColor,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(selectedColor),
                      ),
                      child: Text("RESET ALL SETTINGS"),
                      onPressed: () {
                        setState(() {
                          isVibrationOn = false;
                          isSoundOn = false;
                          isVignetteOn = false;
                          CountMax = 33;
                          selectedColor = Colors.black;
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

// class JsonDataService {
//   final String _dataFileName = 'data.json'; // Update the filename to the local file
//   Map<String, dynamic> Dataset = {};
//
//   Future<void> copyAssetToLocalFile() async {
//     final assetPath = 'assets/data.json'; // Update the asset path
//     final documentDirectory = await getApplicationDocumentsDirectory();
//     final localFile = File('${documentDirectory.path}/data.json');
//
//     if (!localFile.existsSync()) {
//       final byteData = await rootBundle.load(assetPath);
//       final buffer = byteData.buffer.asUint8List();
//       await localFile.writeAsBytes(buffer);
//     }
//   }
//
//   Future<Map<String, dynamic>> readData() async {
//     try {
//       final File file = File(_dataFileName);
//       if (!file.existsSync()) {
//         await copyAssetToLocalFile(); // Copy the asset to a local file if it doesn't exist
//       }
//
//       final String data = await file.readAsString();
//       Map<String, dynamic> jsonData = json.decode(data);
//       return jsonData;
//     } catch (e) {
//       print('Error reading JSON data: $e');
//       return _getDefaultData();
//     }
//   }
//
//   Map<String, dynamic> _getDefaultData() {
//     return {
//       'key1': 'value1',
//       'key2': 'value2',
//     };
//   }
//
//   Future<void> ModifyData(Map<String, dynamic> newjsonData) async {
//     try {
//       final File file = File(_dataFileName);
//       if (!file.existsSync()) {
//         await copyAssetToLocalFile(); // Copy the asset to a local file if it doesn't exist
//       }
//
//       final Map<String, dynamic> jsonData = await readData();
//       jsonData.addAll(newjsonData);
//
//       final String jsonContent = json.encode(jsonData);
//       await file.writeAsString(jsonContent);
//     } catch (e) {
//       print('Error writing JSON data: $e');
//     }
//   }
//
//   Future<void> AddTasbih(Map<String, dynamic> newjsonData) async {
//     try {
//       final File file = File(_dataFileName);
//       if (!file.existsSync()) {
//         await copyAssetToLocalFile(); // Copy the asset to a local file if it doesn't exist
//       }
//
//       final Map<String, dynamic> jsonData = await readData();
//       jsonData.addAll(newjsonData);
//
//       final String jsonContent = json.encode(jsonData);
//       await file.writeAsString(jsonContent);
//     } catch (e) {
//       print('Error writing JSON data: $e');
//     }
//   }
// }

// class JsonDataService {
//   final String _dataFileName = 'assests/data.json';
//   Future<Map<String, dynamic>> readData() async {
//     try {
//       final String data = await rootBundle.loadString(_dataFileName);
//       Map<String, dynamic> jsonData = json.decode(data);
//       Dataset = jsonData;
//       return jsonData;
//     } catch (e) {
//       print('Error reading JSON data: $e');
//       return _getDefaultData();
//     }
//   }
//
//   Map<String, dynamic> _getDefaultData() {
//     return {
//       'key1': 'value1',
//       'key2': 'value2',
//     };
//   }
//
//   Future<void> ModifyData(List<dynamic> newjsonData) async {
//     final File file = File("assests/data.json");
//     try {
//       final Map<String, dynamic> jsonData = await readData();
//       jsonData[newjsonData[0]] = newjsonData[1];
//
//       final String jsonContent = json.encode(jsonData);
//       await file.writeAsString(jsonContent);
//     } catch (e) {
//       print('Error writing JSON data: $e');
//     }
//   }
//
//   Future<void> AddTasbih(Map<String, dynamic> newjsonData) async {
//     final File file = File(_dataFileName);
//     try {
//       final Map<String, dynamic> jsonData = await readData();
//       jsonData.addAll(newjsonData);
//
//       final String jsonContent = json.encode(jsonData);
//       await file.writeAsString(jsonContent);
//     } catch (e) {
//       print('Error writing JSON data: $e');
//     }
//   }
// }
