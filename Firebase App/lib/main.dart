import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'firebase_options.dart';

var ref;

void main() async {
  Firebase.initializeApp(
      // options: DefaultFirebaseOptions.currentPlatform,
      );
  // ref = FirebaseDatabase.instance.ref();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Board Messaging App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  var data;

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    ref = FirebaseDatabase.instance.ref();
  }

  Future<List<Map<String, String>>> fetchDataFromFirebase() async {
    Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    ref = FirebaseDatabase.instance.ref();
    DatabaseReference databaseReference =
        FirebaseDatabase.instance.ref().child('Board_Messages');

    try {
      DatabaseEvent dataSnapshot = await databaseReference.once();
      DataSnapshot snapshot = dataSnapshot.snapshot;

      if (snapshot.value != null) {
        Map<String, dynamic> messages =
            Map<String, dynamic>.from(snapshot.value as Map<dynamic, dynamic>);

        print("@@ Message ${messages}");

        List<Map<String, String>> parsedMessages = [];

        messages.forEach((key, value) {
          parsedMessages
              .add({"Subject": value['subject'], "Body": value['body']});
        });
        print("@@ Message Data ${parsedMessages}\n");
        return parsedMessages;
      } else {
        print('@@ No data found at the specified reference.');
        return [];
      }
    } catch (e) {
      print('@@ Error fetching data: $e');
      return [];
    }
  }

  void _submitMessage() async {
    String subject = subjectController.text;
    String body = bodyController.text;

    if (subject.isNotEmpty && body.isNotEmpty) {
      await FirebaseDatabase.instance.ref().child('Board_Messages').push().set({
        "subject": subject,
        "body": body,
      });

      fetchDataFromFirebase().then((messages) {
        setState(() {
          subjectController.clear();
          bodyController.clear();
        });
      });
    }
  }

  Future<List<Widget>> GetMessages() async {
    List<Widget> Messages = [];
    List<Map<String, String>> messages = await fetchDataFromFirebase();

    for (Map<String, String> message in messages) {
      Messages.add(ListTile(
        leading: Icon(Icons.subject),
        title: Text("Subject ${message['Subject']}"),
        subtitle: Text("Subject ${message['Body']}"),
      ));
    }
    return Messages;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Board Messaging App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: subjectController,
              decoration: InputDecoration(labelText: 'Subject'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: bodyController,
              decoration: InputDecoration(labelText: 'Body'),
            ),
            const SizedBox(height: 16),
            Container(
              width: MediaQuery.sizeOf(context).width * 0.8,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2))),
                onPressed: _submitMessage,
                child: Text('Submit'),
              ),
            ),
            const SizedBox(height: 32),
            Expanded(
              child: FutureBuilder(
                future: fetchDataFromFirebase(),
                builder: (context,
                    AsyncSnapshot<List<Map<String, String>>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    List<Widget> messages = snapshot.data!
                        .map((message) => Container(
                              width: MediaQuery.sizeOf(context).width,
                              margin: EdgeInsets.only(bottom: 10),
                              height: 80,
                              decoration: BoxDecoration(
                                  color: Colors.blueAccent,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 5, color: Colors.black38)
                                  ]),
                              child: ListTile(
                                leading:
                                    Icon(Icons.subject, color: Colors.white),
                                title: Text(
                                  "${message['Subject']!.length <= 40 ? message['Subject']!.substring(0, message['Subject']!.length) : message['Subject']!.substring(0, 40)}...",
                                  style: TextStyle(color: Colors.white),
                                ),
                                subtitle: Text(
                                    "${message['Subject']!.length <= 40 ? message['Body']!.substring(0, message['Body']!.length) : message['Body']!.substring(0, 40)}...",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ))
                        .toList();
                    return ListView(
                      children: messages,
                    );
                  } else {
                    return Container(
                      width: 50, // Set the desired fixed width
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
