class Recipe {
  final String category;
  final String imagePath;
  final String title;
  final double rating;
  final String time;
  final int serves;
  final String reviewCount;
  final List<RecipeIngredient> ingredients;

  Recipe({
    required this.category,
    required this.imagePath,
    required this.title,
    required this.rating,
    required this.time,
    required this.serves,
    required this.reviewCount,
    required this.ingredients,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    final List<dynamic> ingredientsJson = json['ingredients'] ?? [];
    return Recipe(
      category: json['category'] ?? '',
      imagePath: json['imagePath'] ?? '',
      title: json['title'] ?? '',
      rating: (json['rating'] ?? 0.0).toDouble(),
      time: json['time'] ?? '',
      serves: (json['serves'] ?? 1) as int,
      reviewCount: json['reviewCount']?.toString() ?? '0',
      ingredients: ingredientsJson
          .map((e) => RecipeIngredient.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'imagePath': imagePath,
      'title': title,
      'rating': rating,
      'time': time,
      'serves': serves,
      'reviewCount': reviewCount,
      'ingredients': ingredients.map((e) => e.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'Recipe{category: $category, imagePath: $imagePath, title: $title, rating: $rating, time: $time, serves: $serves, reviewCount: $reviewCount, ingredients: $ingredients}';
  }
}

class RecipeIngredient {
  final String name;
  final String imagePath;
  final int grams;

  RecipeIngredient({
    required this.name,
    required this.imagePath,
    required this.grams,
  });

  factory RecipeIngredient.fromJson(Map<String, dynamic> json) {
    return RecipeIngredient(
      name: json['name'] ?? '',
      imagePath: json['imagePath'] ?? '',
      grams: (json['grams'] ?? 0) as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'imagePath': imagePath,
      'grams': grams,
    };
  }

  @override
  String toString() {
    return 'RecipeIngredient{name: $name, imagePath: $imagePath, grams: $grams}';
  }
}
