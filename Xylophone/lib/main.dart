import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

void main() {
  runApp(MaterialApp(home: XyloPhone()));
}

class XyloPhone extends StatefulWidget {
  XyloPhone({Key? key}) : super(key: key);

  @override
  _XyloPhoneState createState() => _XyloPhoneState();
}

AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();

Future<void> playMusic(String filename) async {
  assetsAudioPlayer.open(
    Audio('assests/$filename'),
  );
}

List<String> TotalImages = [
  'images/Black1_Stick.png',
  'images/Blue1_Stick.png',
  'images/Blue2_Stick.png',
  'images/Brown1_Stick.png',
  'images/Green1_Stick.png',
  'images/Orange1_Stick.png',
  'images/Orange2_Stick.png',
  'images/Orange3_Stick.png',
  'images/Pink1_Stick.png',
  'images/Purple1_Stick.png',
  'images/Purple2_Stick.png',
  'images/Red1_Stick.png',
  'images/Yellow1_Stick.png',
  'images/Yellow2_Stick.png',
  'images/Yellow3_Stick.png',
];

List<String> DefaultColors = [
  'Black1',
  'Blue',
  'Red1',
  'Brown1',
  'Orange1',
  'Orange2',
  'Orange3',
  'Yellow1',
  'Yellow2',
  'Yellow3',
  'Pink1',
  'Purple1',
  'Purple2',
  'Green1',
  'Yellow',
];

Widget XyloBar(BuildContext context, String image, double height, double width,
    String filename) {
  return Container(
    width: width,
    height: height,
    child: GestureDetector(
      onTap: () {
        playMusic(filename);
      },
      child: Image.asset('$image',
          fit: BoxFit.fill), // Image.asset('images/$image', fit: BoxFit.fill),
    ),
  );
}

class _XyloPhoneState extends State<XyloPhone> {
  String selectedColor = 'Blue';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20.0, bottom: 120.0),
            width: MediaQuery.of(context).size.width * 0.6,
            height: MediaQuery.of(context).size.height * 0.12,
            decoration: BoxDecoration(
              color: Color.fromRGBO(64, 175, 255, 1),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Xylophone",
                  style: TextStyle(fontSize: 40.0, color: Colors.white),
                )
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                XyloBar(context, TotalImages[0], 280.0, 70.0, 'note1.wav'),
                SizedBox(
                  width: 5.0,
                ),
                XyloBar(context, TotalImages[1], 300.0, 70.0, 'note2.wav'),
                SizedBox(
                  width: 5.0,
                ),
                XyloBar(context, TotalImages[2], 320.0, 70.0, 'note3.wav'),
                SizedBox(
                  width: 5.0,
                ),
                XyloBar(context, TotalImages[3], 340.0, 70.0, 'note4.wav'),
                SizedBox(
                  width: 5.0,
                ),
                XyloBar(context, TotalImages[4], 360.0, 70.0, 'note5.wav'),
                SizedBox(
                  width: 5.0,
                ),
                XyloBar(context, TotalImages[5], 380.0, 70.0, 'note6.wav'),
                SizedBox(
                  width: 5.0,
                ),
                XyloBar(context, TotalImages[6], 400.0, 70.0, 'note7.wav'),
                SizedBox(
                  width: 5.0,
                ),
                XyloBar(context, TotalImages[7], 420.0, 70.0, 'note8.wav'),
                SizedBox(
                  width: 5.0,
                ),
                XyloBar(context, TotalImages[8], 400.0, 70.0, 'note9.wav'),
                SizedBox(
                  width: 5.0,
                ),
                XyloBar(context, TotalImages[9], 380.0, 70.0, 'note10.wav'),
                SizedBox(
                  width: 5.0,
                ),
                XyloBar(context, TotalImages[10], 360.0, 70.0, 'note11.wav'),
                SizedBox(
                  width: 5.0,
                ),
                XyloBar(context, TotalImages[11], 340.0, 70.0, 'note12.wav'),
                SizedBox(
                  width: 5.0,
                ),
                XyloBar(context, TotalImages[12], 320.0, 70.0, 'note13.wav'),
                SizedBox(
                  width: 5.0,
                ),
                XyloBar(context, TotalImages[13], 300.0, 70.0, 'note14.wav'),
                SizedBox(
                  width: 5.0,
                ),
                XyloBar(context, TotalImages[14], 280.0, 70.0, 'note15.wav'),
                // Add more XyloBar widgets for other notes
              ],
            ),
          ),
          //   Row(
          //     children: [
          //       DropdownButton<String>(
          //         focusColor: Colors.white,
          //         borderRadius: BorderRadius.circular(0.0),
          //         style: TextStyle(
          //           fontSize: 15,
          //         ),
          //         value: selectedColor,
          //         items: DefaultColors.map((String value) {
          //           return DropdownMenuItem<String>(
          //             value: value,
          //             child: Text(value),
          //           );
          //         }).toList(),
          //         onChanged: (String? newValue) {
          //           setState(() {
          //             selectedColor = newValue!;
          //             print(newValue);
          //             setState(() {
          //               TotalImages[0] = "images/${newValue}_stick.png";
          //             });
          //           });
          //         },
          //       ),
          //       DropdownButton<String>(
          //         style: TextStyle(
          //           fontSize: 15,
          //         ),
          //         value: selectedColor,
          //         items: DefaultColors.map((String value) {
          //           return DropdownMenuItem<String>(
          //             value: value,
          //             child: Text(value),
          //           );
          //         }).toList(),
          //         onChanged: (String? newValue) {
          //           setState(() {
          //             selectedColor = newValue!;
          //             print(newValue);
          //             setState(() {
          //               TotalImages[1] = "images/${newValue}_stick.png";
          //             });
          //           });
          //         },
          //       ),
          //       DropdownButton<String>(
          //         focusColor: Colors.white,
          //         borderRadius: BorderRadius.circular(0.0),
          //         style: TextStyle(
          //           fontSize: 15,
          //         ),
          //         value: selectedColor,
          //         items: DefaultColors.map((String value) {
          //           return DropdownMenuItem<String>(
          //             value: value,
          //             child: Text(value),
          //           );
          //         }).toList(),
          //         onChanged: (String? newValue) {
          //           setState(() {
          //             selectedColor = newValue!;
          //             print(newValue);
          //             setState(() {
          //               TotalImages[2] = "images/${newValue}_stick.png";
          //             });
          //           });
          //         },
          //       ),
          //       DropdownButton<String>(
          //         style: TextStyle(
          //           fontSize: 15,
          //         ),
          //         value: selectedColor,
          //         items: DefaultColors.map((String value) {
          //           return DropdownMenuItem<String>(
          //             value: value,
          //             child: Text(value),
          //           );
          //         }).toList(),
          //         onChanged: (String? newValue) {
          //           setState(() {
          //             selectedColor = newValue!;
          //             print(newValue);
          //             setState(() {
          //               TotalImages[3] = "images/${newValue}_stick.png";
          //             });
          //           });
          //         },
          //       ),
          //       DropdownButton<String>(
          //         focusColor: Colors.white,
          //         borderRadius: BorderRadius.circular(0.0),
          //         style: TextStyle(
          //           fontSize: 15,
          //         ),
          //         value: selectedColor,
          //         items: DefaultColors.map((String value) {
          //           return DropdownMenuItem<String>(
          //             value: value,
          //             child: Text(value),
          //           );
          //         }).toList(),
          //         onChanged: (String? newValue) {
          //           setState(() {
          //             selectedColor = newValue!;
          //             print(newValue);
          //             setState(() {
          //               TotalImages[4] = "images/${newValue}_stick.png";
          //             });
          //           });
          //         },
          //       ),
          //       DropdownButton<String>(
          //         style: TextStyle(
          //           fontSize: 15,
          //         ),
          //         value: selectedColor,
          //         items: DefaultColors.map((String value) {
          //           return DropdownMenuItem<String>(
          //             value: value,
          //             child: Text(value),
          //           );
          //         }).toList(),
          //         onChanged: (String? newValue) {
          //           setState(() {
          //             selectedColor = newValue!;
          //             print(newValue);
          //             setState(() {
          //               TotalImages[5] = "images/${newValue}_stick.png";
          //             });
          //           });
          //         },
          //       ),
          //       DropdownButton<String>(
          //         focusColor: Colors.white,
          //         borderRadius: BorderRadius.circular(0.0),
          //         style: TextStyle(
          //           fontSize: 15,
          //         ),
          //         value: selectedColor,
          //         items: DefaultColors.map((String value) {
          //           return DropdownMenuItem<String>(
          //             value: value,
          //             child: Text(value),
          //           );
          //         }).toList(),
          //         onChanged: (String? newValue) {
          //           setState(() {
          //             selectedColor = newValue!;
          //             print(newValue);
          //             setState(() {
          //               TotalImages[6] = "images/${newValue}_stick.png";
          //             });
          //           });
          //         },
          //       ),
          //       DropdownButton<String>(
          //         style: TextStyle(
          //           fontSize: 15,
          //         ),
          //         value: selectedColor,
          //         items: DefaultColors.map((String value) {
          //           return DropdownMenuItem<String>(
          //             value: value,
          //             child: Text(value),
          //           );
          //         }).toList(),
          //         onChanged: (String? newValue) {
          //           setState(() {
          //             selectedColor = newValue!;
          //             print(newValue);
          //             setState(() {
          //               TotalImages[7] = "images/${newValue}_stick.png";
          //             });
          //           });
          //         },
          //       ),
          //     ],
          //   )
        ],
      ),
    );
  }
}
