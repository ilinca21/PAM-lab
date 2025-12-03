import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pam_lab2/recipecard.dart';
import '../presentation/controllers/recipe_controller.dart';

class FeaturedRecipes extends StatelessWidget {
  final RecipeController recipeController = Get.find<RecipeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (recipeController.isLoading) {
        return const Center(child: CircularProgressIndicator());
      }

      if (recipeController.errorMessage.isNotEmpty) {
        return Center(
          child: Text(
            recipeController.errorMessage,
            style: TextStyle(color: Colors.red),
          ),
        );
      }

      final recipes = recipeController.filteredRecipes;

      if (recipes.isEmpty) {
        return Center(
          child: Text(
            'No recipes found',
            style: TextStyle(color: Colors.grey[600]),
          ),
        );
      }

      return SizedBox(
        height: 250,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: recipes.length,
          separatorBuilder: (_, __) => const SizedBox(width: 16),
          itemBuilder: (context, index) {
            final recipe = recipes[index];
            final isBookmarked = recipeController.isRecipeBookmarked(recipe.title);
            return RecipeCard(
              imagePath: recipe.imagePath,
              title: recipe.title,
              rating: recipe.rating,
              time: recipe.time,
              isBookmarked: isBookmarked,
              onTap: () async {
                await recipeController.selectRecipe(recipe);
                Navigator.pushNamed(context, '/recipepage');
              },
            );
          },
        ),
      );
    });
  }
}
