import '../../domain/entities/category.dart';
import '../../domain/repositories/category_repository.dart';
import '../../domain/repositories/recipe_repository.dart';
import 'recipe_repository_impl.dart';

/// Implementation of CategoryRepository
/// This is part of the Data layer
class CategoryRepositoryImpl implements CategoryRepository {
  final RecipeRepository _recipeRepository;

  CategoryRepositoryImpl(this._recipeRepository);

  @override
  Future<List<Category>> loadCategories() async {
    try {
      final feed = await _recipeRepository.loadFeed();
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
}

