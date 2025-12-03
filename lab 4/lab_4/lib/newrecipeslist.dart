import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'newrecipecard.dart';
import 'presentation/controllers/recipe_controller.dart';

class NewRecipesList extends StatelessWidget {
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

      final recipes = recipeController.newRecipes;

      if (recipes.isEmpty) {
        return Center(
          child: Text(
            'No recipes found',
            style: TextStyle(color: Colors.grey[600]),
          ),
        );
      }

      return SizedBox(
        height: 150,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: recipes.length,
          itemBuilder: (context, index) {
            final recipe = recipes[index];
            final author = recipeController.getRecipeAuthor(recipe.title) ?? 'Chef';
            final authorImage = recipeController.getRecipeAuthorImage(recipe.title) ?? 'assets/images/jamesMilner.png';
            
            return NewRecipeCard(
              title: recipe.title,
              author: author,
              rating: recipe.rating,
              time: recipe.time,
              imagePath: recipe.imagePath,
              authorImagePath: authorImage,
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