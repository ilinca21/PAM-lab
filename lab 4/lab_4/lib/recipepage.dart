import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pam_lab2/pageoptions.dart';
import 'package:pam_lab2/recipeinfotoggle.dart';
import 'package:pam_lab2/recipeingredients.dart';
import 'package:pam_lab2/recipeoverview.dart';
import 'package:pam_lab2/userinformation.dart';
import 'presentation/controllers/recipe_controller.dart';
import 'domain/entities/recipe.dart';

class RecipePage extends StatelessWidget {
  const RecipePage({super.key});
  RecipeController get recipeController => Get.find<RecipeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Obx(() {
            // Access ALL observable values directly in one Obx
            final recipe = recipeController.selectedRecipe;
            final filteredRecipes = recipeController.filteredRecipes;
            final isBookmarked = recipeController.isBookmarked;
            final chef = recipeController.chef;
            final tabs = recipeController.tabs;
            final serving = recipeController.serving;
            final servesText = recipeController.servesText;
            
            // Get recipe to display
            Recipe? displayRecipe = recipe;
            if (displayRecipe == null && filteredRecipes.isNotEmpty) {
              displayRecipe = filteredRecipes.first;
            }
            
            if (displayRecipe == null) {
              return const Center(child: Text('No recipe selected'));
            }
            
            // Extract recipe properties to local variables
            final imageUrl = displayRecipe.imagePath;
            final preptime = displayRecipe.time;
            final score = displayRecipe.rating;
            final recipeName = displayRecipe.title;
            final reviewCount = displayRecipe.reviewCount;
            final recipeServes = displayRecipe.serves;
            final recipeIngredients = displayRecipe.ingredients
              .map((i) => IngredientCard(
                    name: i.name,
                    imageUrl: i.imagePath,
                    grams: i.grams,
                  ))
              .toList();
            
            // Build all widgets directly - single Obx, no nested widgets
            return ListView(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: const PageOptions(),
                ),
                const SizedBox(height: 10),
                RecipeOverview(
                  imageUrl: imageUrl,
                  preptime: preptime,
                  score: score,
                  name: recipeName,
                  reviewCount: reviewCount,
                  isBookmarked: isBookmarked,
                ),
                const SizedBox(height: 10),
                UserInformation(
                  name: chef?.name ?? 'Chef',
                  address: chef?.location ?? 'Unknown',
                  profileImage: chef?.profileImage,
                ),
                const SizedBox(height: 20),
                RecipeInfoToggle(tabs: tabs),
                const SizedBox(height: 35),
                RecipeIngredients(
                  serves: serving?.totalItems ?? recipeServes,
                  servesText: servesText,
                  ingredients: recipeIngredients,
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
