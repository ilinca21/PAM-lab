/// API Response models for recipe details (Data layer - DTOs)
class RecipeDetailResponseModel {
  final RecipeDetailModel recipe;
  final ChefModel chef;
  final List<TabInfoModel> tabs;
  final ServingModel serving;
  final List<IngredientDetailModel> ingredients;

  RecipeDetailResponseModel({
    required this.recipe,
    required this.chef,
    required this.tabs,
    required this.serving,
    required this.ingredients,
  });

  factory RecipeDetailResponseModel.fromJson(Map<String, dynamic> json) => RecipeDetailResponseModel(
    recipe: RecipeDetailModel.fromJson(json['recipe']),
    chef: ChefModel.fromJson(json['chef']),
    tabs: (json['tabs'] as List).map((t) => TabInfoModel.fromJson(t)).toList(),
    serving: ServingModel.fromJson(json['serving']),
    ingredients: (json['ingredients'] as List).map((i) => IngredientDetailModel.fromJson(i)).toList(),
  );
}

class RecipeDetailModel {
  final int id;
  final String title;
  final String image;
  final double rating;
  final String reviews;
  final String cookTime;
  final bool isBookmarked;

  RecipeDetailModel({
    required this.id,
    required this.title,
    required this.image,
    required this.rating,
    required this.reviews,
    required this.cookTime,
    required this.isBookmarked,
  });

  factory RecipeDetailModel.fromJson(Map<String, dynamic> json) => RecipeDetailModel(
    id: json['id'],
    title: json['title'],
    image: json['image'],
    rating: (json['rating'] as num).toDouble(),
    reviews: json['reviews'],
    cookTime: json['cook_time'],
    isBookmarked: json['is_bookmarked'],
  );
}

class ChefModel {
  final String name;
  final String profileImage;
  final String location;
  final bool isFollowing;

  ChefModel({
    required this.name,
    required this.profileImage,
    required this.location,
    required this.isFollowing,
  });

  factory ChefModel.fromJson(Map<String, dynamic> json) => ChefModel(
    name: json['name'],
    profileImage: json['profile_image'],
    location: json['location'],
    isFollowing: json['is_following'],
  );
}

class TabInfoModel {
  final String name;
  final bool active;

  TabInfoModel({
    required this.name,
    required this.active,
  });

  factory TabInfoModel.fromJson(Map<String, dynamic> json) => TabInfoModel(
    name: json['name'],
    active: json['active'],
  );
}

class ServingModel {
  final String serves;
  final int totalItems;

  ServingModel({
    required this.serves,
    required this.totalItems,
  });

  factory ServingModel.fromJson(Map<String, dynamic> json) => ServingModel(
    serves: json['serves'],
    totalItems: (json['total_items'] is int) ? json['total_items'] : int.parse(json['total_items'].toString()),
  );
}

class IngredientDetailModel {
  final int id;
  final String name;
  final String quantity;
  final String icon;

  IngredientDetailModel({
    required this.id,
    required this.name,
    required this.quantity,
    required this.icon,
  });

  factory IngredientDetailModel.fromJson(Map<String, dynamic> json) => IngredientDetailModel(
    id: json['id'],
    name: json['name'],
    quantity: json['quantity'],
    icon: json['icon'],
  );
}

