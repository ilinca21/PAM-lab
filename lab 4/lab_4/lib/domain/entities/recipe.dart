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

  @override
  String toString() {
    return 'RecipeIngredient{name: $name, imagePath: $imagePath, grams: $grams}';
  }
}

