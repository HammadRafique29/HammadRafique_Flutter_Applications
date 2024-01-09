import 'package:flutter/material.dart';
import 'package:trading_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  bool _acceptTerms = false;

  Future<void> signUpUser() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // FirebaseDatabase database = FirebaseDatabase.instance;
    DatabaseReference ref = FirebaseDatabase.instance.ref("Users");
    DatabaseReference adminUsers = ref.push();

    await adminUsers.set({
      "FirstName": _firstNameController.text,
      "LastName": _lastNameController.text,
      "Email": _emailController.text,
      "Password": _passwordController.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signup Screen'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // User Logo
                Container(
                  margin: const EdgeInsets.only(bottom: 20.0),
                  child: Image.asset(
                    'images/user3.png', // Replace with your image asset
                    height: 180.0,
                    width: 180.0,
                    fit: BoxFit.fill,
                  ),
                ),
                // First Name TextField
                Container(
                  margin: const EdgeInsets.only(bottom: 16.0),
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: _firstNameController,
                    decoration: InputDecoration(
                      hintText: "Enter your First Name ...",
                      hintStyle: TextStyle(
                        color: Colors.grey[500],
                        fontWeight: FontWeight.normal,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                // Last Name TextField
                Container(
                  margin: const EdgeInsets.only(bottom: 16.0),
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: _lastNameController,
                    decoration: InputDecoration(
                      hintText: "Enter your Last Name ...",
                      hintStyle: TextStyle(
                        color: Colors.grey[500],
                        fontWeight: FontWeight.normal,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                // Email TextField
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
                        fontWeight: FontWeight.normal,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                // Password TextField
                Container(
                  margin: const EdgeInsets.only(bottom: 16.0),
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
                        fontWeight: FontWeight.normal,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                // Accept Terms Checkbox
                Row(
                  children: [
                    Checkbox(
                      value: _acceptTerms,
                      onChanged: (bool? value) {
                        if (value != null) {
                          setState(() {
                            _acceptTerms = value;
                          });
                        }
                      },
                    ),
                    const Text('I accept the Terms and Conditions'),
                  ],
                ),
                // Signup Button
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.amber,
                    ),
                    onPressed: () {
                      String firstName = _firstNameController.text;
                      String lastName = _lastNameController.text;
                      String email = _emailController.text;
                      String password = _passwordController.text;

                      // Perform signup logic here

                      print('First Name: $firstName');
                      print('Last Name: $lastName');
                      print('Email: $email');
                      print('Password: $password');
                      print('Accept Terms: $_acceptTerms');

                      setState(() async {
                        await signUpUser();
                      });
                    },
                    child: const Text('Signup',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
                // Login Button
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Go back to the previous screen
                  },
                  child: Text(
                    'Already Registered? Login',
                    style: TextStyle(color: Colors.amber.shade700),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
