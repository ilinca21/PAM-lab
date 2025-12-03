import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class RecipeController extends GetxController {
  var popularRecipes = [].obs;
  var newRecipes = [].obs;
  var ingredients = [].obs;

  @override
  void onInit() {
    super.onInit();
    loadRecipesData();
  }

  Future<void> loadRecipesData() async {
    final String jsonString = await rootBundle.loadString('assets/data/recipes_data.json');
    final data = json.decode(jsonString);

    popularRecipes.value = data['popularRecipes'];
    newRecipes.value = data['newRecipes'];
    ingredients.value = data['ingredients'];
  }
}