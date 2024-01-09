import 'package:flutter/material.dart';
import 'package:trading_app/screens/dashboard.dart';
import 'screens/Login.dart';
import 'screens/dashboard.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: DashBoardScreen(),
    theme: ThemeData(
      primarySwatch: Colors.blue, // Set the primary color for the app
    ), //  LoginScreen(),
  ));
}
