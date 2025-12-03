import '../entities/category.dart';

/// Repository interface for category operations
/// This is part of the Domain layer and defines the contract
abstract class CategoryRepository {
  /// Loads all categories from the data source
  Future<List<Category>> loadCategories();
}

