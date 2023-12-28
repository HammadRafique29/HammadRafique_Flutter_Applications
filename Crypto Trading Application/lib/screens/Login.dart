import 'package:flutter/material.dart';
import 'Signup.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Screen'),
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
                    'images/user1.png',
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
                    onPressed: () {
                      String email = _emailController.text;
                      String password = _passwordController.text;
                      print('Email: $email\nPassword: $password');
                    },
                    child: const Text('Login',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            SignupScreen(), // Replace SecondPage with your next page widget
                      ),
                    );
                  },
                  child: Text(
                    'Not Register?  Signup',
                    style: TextStyle(color: Colors.amber.shade700),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
