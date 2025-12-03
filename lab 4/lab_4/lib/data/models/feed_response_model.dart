import 'dart:convert';

/// API Response models (Data layer - DTOs)
class FeedResponseModel {
  final UserProfileModel user;
  final FilterModelModel filters;
  final List<FeedRecipeItemModel> recipes;
  final List<NewRecipeItemModel> newRecipes;

  FeedResponseModel({
    required this.user,
    required this.filters,
    required this.recipes,
    required this.newRecipes,
  });

  factory FeedResponseModel.fromJson(Map<String, dynamic> json) => FeedResponseModel(
    user: UserProfileModel.fromJson(json['user']),
    filters: FilterModelModel.fromJson(json['filters']),
    recipes: (json['recipes'] as List).map((r) => FeedRecipeItemModel.fromJson(r)).toList(),
    newRecipes: (json['new_recipes'] as List).map((n) => NewRecipeItemModel.fromJson(n)).toList(),
  );
}

class UserProfileModel {
  final String name;
  final String profileImage;
  final String greeting;

  UserProfileModel({
    required this.name,
    required this.profileImage,
    required this.greeting,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) => UserProfileModel(
    name: json['name'],
    profileImage: json['profile_image'],
    greeting: json['greeting'],
  );
}

class FilterModelModel {
  final String searchPlaceholder;
  final List<CategoryFilterModel> categories;

  FilterModelModel({
    required this.searchPlaceholder,
    required this.categories,
  });

  factory FilterModelModel.fromJson(Map<String, dynamic> json) => FilterModelModel(
    searchPlaceholder: json['search_placeholder'],
    categories: (json['categories'] as List).map((c) => CategoryFilterModel.fromJson(c)).toList(),
  );
}

class CategoryFilterModel {
  final int id;
  final String name;
  final bool selected;

  CategoryFilterModel({
    required this.id,
    required this.name,
    required this.selected,
  });

  factory CategoryFilterModel.fromJson(Map<String, dynamic> json) => CategoryFilterModel(
    id: json['id'],
    name: json['name'],
    selected: json['selected'],
  );
}

class FeedRecipeItemModel {
  final int id;
  final String name;
  final double rating;
  final String time;
  final bool isBookmarked;
  final String image;

  FeedRecipeItemModel({
    required this.id,
    required this.name,
    required this.rating,
    required this.time,
    required this.isBookmarked,
    required this.image,
  });

  factory FeedRecipeItemModel.fromJson(Map<String, dynamic> json) => FeedRecipeItemModel(
    id: json['id'],
    name: json['name'],
    rating: (json['rating'] as num).toDouble(),
    time: json['time'],
    isBookmarked: json['is_bookmarked'],
    image: json['image'],
  );
}

class NewRecipeItemModel {
  final int id;
  final String name;
  final double rating;
  final String author;
  final String time;
  final String image;
  final String authorImage;

  NewRecipeItemModel({
    required this.id,
    required this.name,
    required this.rating,
    required this.author,
    required this.time,
    required this.image,
    required this.authorImage,
  });

  factory NewRecipeItemModel.fromJson(Map<String, dynamic> json) => NewRecipeItemModel(
    id: json['id'],
    name: json['name'],
    rating: (json['rating'] as num).toDouble(),
    author: json['author'],
    time: json['time'],
    image: json['image'],
    authorImage: json['author_image'],
  );
}

