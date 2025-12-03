import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pam_lab2/recipehomepage.dart';
import 'package:pam_lab2/recipepage.dart';
import 'di/injection.dart';

void main() {
  // Initialize dependencies
  Injection.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: RecipeHomePage(),
      theme: ThemeData(
        fontFamily: 'Poppins',
      ),
      routes: {
        '/recipepage': (context) => RecipePage(),
      },
    );
  }
}