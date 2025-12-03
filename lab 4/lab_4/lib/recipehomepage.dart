import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pam_lab2/sectiontitle.dart';
import 'package:pam_lab2/topbar.dart';

import 'categoryfilterchips.dart';
import 'presentation/controllers/category_controller.dart';
import 'presentation/controllers/recipe_controller.dart';
import 'featuredrecipes.dart';
import 'newrecipeslist.dart';

class RecipeHomePage extends StatelessWidget {
  final CategoryController categoryController = Get.find<CategoryController>();
  final RecipeController recipeController = Get.find<RecipeController>();



  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopBar(),
              SizedBox(height: 24),
              // Search Bar
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: Colors.grey[300]!, width: 1),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 0,
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: TextField(
                        onChanged: (value) {
                          recipeController.searchRecipes(value);
                        },
                        decoration: InputDecoration(
                          hintText: 'Search recipe',
                          hintStyle: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey[400],
                            size: 22,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color(0xFF2E7D7B),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.tune,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Obx(() {
                if (categoryController.isLoading) {
                  return Center(child: CircularProgressIndicator());
                }

                return CategoryFilterChips(
                  categories: categoryController.categories.map((cat) => cat.name).toList(),
                  selectedCategory: categoryController.selectedCategory,
                  onCategorySelected: (category) {
                    categoryController.selectCategory(category);
                    recipeController.filterByCategory(category);
                  },
                );
              }),

              SizedBox(height: 24),
              FeaturedRecipes(),
              SizedBox(height: 2),
              SectionTitle('New Recipes'),
              NewRecipesList(),
              SizedBox(height: 1),
            ],
          ),
        ),
      ),
    );
  }
}