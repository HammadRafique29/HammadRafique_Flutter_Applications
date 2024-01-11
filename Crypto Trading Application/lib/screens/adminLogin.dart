import 'package:flutter/material.dart';
import 'Signup.dart';
import 'package:trading_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: adminLoginScreen(),
    );
  }
}

class adminLoginScreen extends StatefulWidget {
  @override
  _adminLoginScreenState createState() => _adminLoginScreenState();
}

class _adminLoginScreenState extends State<adminLoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Future<void> adminLogin() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    DatabaseReference ref = FirebaseDatabase.instance.ref();

    final snapshot = await ref.child('Admins').get();
    if (snapshot.exists) {
      var data = snapshot.value as Map<dynamic, dynamic>;
      for (var entry in data.entries) {
        var key = entry.key;
        var value = entry.value;

        if (_emailController.text == value['Email'] &&
            _passwordController.text == value['Password']) {
          print("Email: ${value['Email']}");
          print("Password: ${value['Password']}");
          print("\nLogin Success");
          final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? userLogedin = prefs.getBool('loginExists');
    if (userLogedin != null) {
      await prefs.setString('loginType', 'admin');
    }
          break;
        } else {
          print("\nLogin Failed");
        }
      }
    } else {
      print('No data available.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Login'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.1),
                Container(
                  margin: const EdgeInsets.only(bottom: 20.0),
                  child: Image.asset(
                    'images/user3.png',
                    height: 180.0,
                    width: 180.0,
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 16.0),
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: "Enter your Email ...",
                      hintStyle: TextStyle(
                          color: Colors.grey[500],
                          fontWeight: FontWeight.normal),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                // Password TextField
                Container(
                  margin: const EdgeInsets.only(bottom: 20.0),
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Enter your Password ...",
                      hintStyle: TextStyle(
                          color: Colors.grey[500],
                          fontWeight: FontWeight.normal),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Forgot Password?',
                      style: TextStyle(color: Colors.black45)),
                ),
                Container(
                  width: MediaQuery.sizeOf(context).width,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.amber,
                    ),
                    onPressed: () async {
                      String email = _emailController.text;
                      String password = _passwordController.text;
                      print('Email: $email\nPassword: $password');

                      var result = await adminLogin();
                      // setState(() async {

                      // });
                    },
                    child: const Text('Login',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    // Navigator.push(
                    //   context,
                    // MaterialPageRoute(
                    //   builder: (context) =>
                    //       SignupScreen(), // Replace SecondPage with your next page widget
                    // ),
                    // );
                  },
                  child: Text(
                    'User Login',
                    style: TextStyle(color: Colors.amber.shade700),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
