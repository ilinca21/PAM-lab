import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/recipe_controller.dart';
import 'home_screen.dart';

void main() {
  Get.put(RecipeController()); // Initializează controllerul
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recipe App',
      home: HomeScreen(),
    );
  }
}
