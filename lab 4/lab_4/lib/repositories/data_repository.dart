import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/recipe.dart';
import '../models/category.dart';

// ------------------------
// MODELE FEED ȘI DETALIU REȚETĂ
// ------------------------

class FeedResponse {
  final UserProfile user;
  final FilterModel filters;
  final List<FeedRecipeItem> recipes;
  final List<NewRecipeItem> newRecipes;
  FeedResponse({required this.user, required this.filters, required this.recipes, required this.newRecipes});
  factory FeedResponse.fromJson(Map<String, dynamic> json) => FeedResponse(
    user: UserProfile.fromJson(json['user']),
    filters: FilterModel.fromJson(json['filters']),
    recipes: (json['recipes'] as List).map((r) => FeedRecipeItem.fromJson(r)).toList(),
    newRecipes: (json['new_recipes'] as List).map((n) => NewRecipeItem.fromJson(n)).toList(),
  );
}
class UserProfile {
  final String name;
  final String profileImage;
  final String greeting;
  UserProfile({required this.name, required this.profileImage, required this.greeting});
  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
    name: json['name'],
    profileImage: json['profile_image'],
    greeting: json['greeting'],
  );
}
class FilterModel {
  final String searchPlaceholder;
  final List<CategoryFilter> categories;
  FilterModel({required this.searchPlaceholder, required this.categories});
  factory FilterModel.fromJson(Map<String, dynamic> json) => FilterModel(
    searchPlaceholder: json['search_placeholder'],
    categories: (json['categories'] as List).map((c) => CategoryFilter.fromJson(c)).toList(),
  );
}
class CategoryFilter {
  final int id;
  final String name;
  final bool selected;
  CategoryFilter({required this.id, required this.name, required this.selected});
  factory CategoryFilter.fromJson(Map<String, dynamic> json) => CategoryFilter(
    id: json['id'],
    name: json['name'],
    selected: json['selected'],
  );
}
class FeedRecipeItem {
  final int id;
  final String name;
  final double rating;
  final String time;
  final bool isBookmarked;
  final String image;
  FeedRecipeItem({required this.id, required this.name, required this.rating, required this.time, required this.isBookmarked, required this.image});
  factory FeedRecipeItem.fromJson(Map<String, dynamic> json) => FeedRecipeItem(
    id: json['id'],
    name: json['name'],
    rating: (json['rating'] as num).toDouble(),
    time: json['time'],
    isBookmarked: json['is_bookmarked'],
    image: json['image'],
  );
}
class NewRecipeItem {
  final int id;
  final String name;
  final double rating;
  final String author;
  final String time;
  final String image;
  final String authorImage;
  NewRecipeItem({required this.id, required this.name, required this.rating, required this.author, required this.time, required this.image, required this.authorImage});
  factory NewRecipeItem.fromJson(Map<String, dynamic> json) => NewRecipeItem(
    id: json['id'],
    name: json['name'],
    rating: (json['rating'] as num).toDouble(),
    author: json['author'],
    time: json['time'],
    image: json['image'],
    authorImage: json['author_image']
  );
}

// --- DETALIU REȚETĂ ---
class RecipeDetailResponse {
  final RecipeDetail recipe;
  final Chef chef;
  final List<TabInfo> tabs;
  final Serving serving;
  final List<IngredientDetail> ingredients;
  RecipeDetailResponse({required this.recipe, required this.chef, required this.tabs, required this.serving, required this.ingredients});
  factory RecipeDetailResponse.fromJson(Map<String, dynamic> json) => RecipeDetailResponse(
    recipe: RecipeDetail.fromJson(json['recipe']),
    chef: Chef.fromJson(json['chef']),
    tabs: (json['tabs'] as List).map((t) => TabInfo.fromJson(t)).toList(),
    serving: Serving.fromJson(json['serving']),
    ingredients: (json['ingredients'] as List).map((i) => IngredientDetail.fromJson(i)).toList(),
  );
}
class RecipeDetail {
  final int id;
  final String title;
  final String image;
  final double rating;
  final String reviews;
  final String cookTime;
  final bool isBookmarked;
  RecipeDetail({required this.id, required this.title, required this.image, required this.rating, required this.reviews, required this.cookTime, required this.isBookmarked});
  factory RecipeDetail.fromJson(Map<String, dynamic> json) => RecipeDetail(
    id: json['id'],
    title: json['title'],
    image: json['image'],
    rating: (json['rating'] as num).toDouble(),
    reviews: json['reviews'],
    cookTime: json['cook_time'],
    isBookmarked: json['is_bookmarked'],
  );
}
class Chef {
  final String name;
  final String profileImage;
  final String location;
  final bool isFollowing;
  Chef({required this.name, required this.profileImage, required this.location, required this.isFollowing});
  factory Chef.fromJson(Map<String, dynamic> json) => Chef(
    name: json['name'],
    profileImage: json['profile_image'],
    location: json['location'],
    isFollowing: json['is_following'],
  );
}
class TabInfo {
  final String name;
  final bool active;
  TabInfo({required this.name, required this.active});
  factory TabInfo.fromJson(Map<String, dynamic> json) => TabInfo(
    name: json['name'],
    active: json['active'],
  );
}
class Serving {
  final String serves;
  final int totalItems;
  Serving({required this.serves, required this.totalItems});
  factory Serving.fromJson(Map<String, dynamic> json) => Serving(
    serves: json['serves'],
    totalItems: (json['total_items'] is int) ? json['total_items'] : int.parse(json['total_items'].toString()),
  );
}
class IngredientDetail {
  final int id;
  final String name;
  final String quantity;
  final String icon;
  IngredientDetail({required this.id, required this.name, required this.quantity, required this.icon});
  factory IngredientDetail.fromJson(Map<String, dynamic> json) => IngredientDetail(
    id: json['id'],
    name: json['name'],
    quantity: json['quantity'],
    icon: json['icon'],
  );
}

class DataRepository {
  static const String _baseUrl = 'https://test-api-jlbn.onrender.com/v2';
  static const String _feedEndpoint = '$_baseUrl/feed';
  static const String _feedDetailsEndpoint = '$_baseUrl/feed/details';

  /// Loads recipes from web service asynchronously
  Future<List<Recipe>> loadRecipes() async {
    try {
      final response = await http.get(Uri.parse(_feedEndpoint));
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        final List<dynamic> recipesJson = jsonData['recipes'] ?? [];
        
        return recipesJson
            .map((json) => Recipe.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        print('Error loading recipes: HTTP ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error loading recipes: $e');
      return [];
    }
  }

  /// Loads recipe details from web service asynchronously
  Future<Recipe?> loadRecipeDetails(String? recipeId) async {
    try {
      final Uri uri = recipeId != null 
          ? Uri.parse('$_feedDetailsEndpoint?id=$recipeId')
          : Uri.parse(_feedDetailsEndpoint);
      
      final response = await http.get(uri);
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        return Recipe.fromJson(jsonData);
      } else {
        print('Error loading recipe details: HTTP ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error loading recipe details: $e');
      return null;
    }
  }

  /// Loads categories from web service asynchronously
  /// Extracts categories from API feed filters
  Future<List<Category>> loadCategories() async {
    try {
      final feed = await loadFeedV2();
      if (feed != null) {
        // Extract categories from API feed filters
        return feed.filters.categories
            .map((categoryFilter) => Category(name: categoryFilter.name))
            .toList();
      } else {
        return [Category(name: 'All')];
      }
    } catch (e) {
      print('Error loading categories: $e');
      return [Category(name: 'All')];
    }
  }

  /// Filters recipes by category
  List<Recipe> filterRecipesByCategory(List<Recipe> recipes, String category) {
    if (category == 'All') {
      return recipes;
    }
    return recipes.where((recipe) => recipe.category == category).toList();
  }

  /// Searches recipes by title
  List<Recipe> searchRecipes(List<Recipe> recipes, String query) {
    if (query.isEmpty) {
      return recipes;
    }
    return recipes
        .where((recipe) => 
            recipe.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  /// Încarcă feed-ul complet cu toate structurile moderne
  Future<FeedResponse?> loadFeedV2() async {
    try {
      final response = await http.get(Uri.parse(_feedEndpoint));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return FeedResponse.fromJson(jsonData);
      } else {
        print('Error loading feed v2: HTTP ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error loadFeedV2: $e');
      return null;
    }
  }

  /// Încarcă detaliile rețetei cu noua structură completă
  Future<RecipeDetailResponse?> loadRecipeDetailV2(int? recipeId) async {
    try {
      final url = recipeId != null 
          ? '$_feedDetailsEndpoint?id=$recipeId'
          : _feedDetailsEndpoint;
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return RecipeDetailResponse.fromJson(jsonData);
      } else {
        print('Error loading recipe detail v2: HTTP ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error loadRecipeDetailV2: $e');
      return null;
    }
  }
}
