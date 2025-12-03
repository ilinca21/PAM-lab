import '../entities/recipe.dart';
import '../entities/user_profile.dart';
import '../entities/chef.dart';
import '../entities/tab_info.dart';
import '../entities/serving.dart';

/// Repository interface for recipe operations
/// This is part of the Domain layer and defines the contract
abstract class RecipeRepository {
  /// Loads all recipes from the data source
  Future<List<Recipe>> loadRecipes();

  /// Loads feed data with user, filters, recipes, and new recipes
  Future<FeedResponse?> loadFeed();

  /// Loads detailed recipe information
  Future<RecipeDetailResponse?> loadRecipeDetail(int? recipeId);
}

/// Response model for feed data (Domain layer)
class FeedResponse {
  final UserProfile user;
  final FilterModel filters;
  final List<Recipe> recipes;
  final List<Recipe> newRecipes;
  final Map<String, int> recipeIds; // title -> id
  final Map<String, bool> recipeBookmarks; // title -> isBookmarked
  final Map<String, String> recipeAuthors; // title -> author
  final Map<String, String> recipeAuthorImages; // title -> authorImage

  FeedResponse({
    required this.user,
    required this.filters,
    required this.recipes,
    required this.newRecipes,
    required this.recipeIds,
    required this.recipeBookmarks,
    required this.recipeAuthors,
    required this.recipeAuthorImages,
  });
}

/// Filter model for categories and search (Domain layer)
class FilterModel {
  final String searchPlaceholder;
  final List<CategoryFilter> categories;

  FilterModel({
    required this.searchPlaceholder,
    required this.categories,
  });
}

/// Category filter item (Domain layer)
class CategoryFilter {
  final int id;
  final String name;
  final bool selected;

  CategoryFilter({
    required this.id,
    required this.name,
    required this.selected,
  });
}

/// Response model for recipe details (Domain layer)
class RecipeDetailResponse {
  final Recipe recipe;
  final Chef chef;
  final List<TabInfo> tabs;
  final Serving serving;
  final List<RecipeIngredient> ingredients;

  RecipeDetailResponse({
    required this.recipe,
    required this.chef,
    required this.tabs,
    required this.serving,
    required this.ingredients,
  });
}

