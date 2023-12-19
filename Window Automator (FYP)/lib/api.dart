import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// void main() => runApp(WhispherAPI());

class WhispherAPI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: apiPage(),
    );
  }
}

class apiPage extends StatefulWidget {
  @override
  _apiPageState createState() => _apiPageState();
}

class _apiPageState extends State<apiPage> {
  Future<Map<String, dynamic>> fetchData() async {
    var url = Uri.parse(
        'http://192.168.172.128:8000/'); // Replace with your actual API endpoint
    final response = await http.get(url);

    if (response.statusCode == 200) {
      print(json.decode(response.body));
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> sendDataToApi() async {
    var url = Uri.parse('http://192.168.172.128:8000/send');
    var dataToSend = {'name': 'John Doe', 'age': 30};

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(dataToSend),
    );

    if (response.statusCode == 200) {
      print('Data sent successfully');
      print(json.decode(response.body));
    } else {
      print('Failed to send data');
      print('Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter + Django API'),
      ),
      body: Center(
        child: FutureBuilder<Map<String, dynamic>>(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              // Display the data received from the API
              return Text('${snapshot}');
            }
          },
        ),
      ),
    );
  }
}
