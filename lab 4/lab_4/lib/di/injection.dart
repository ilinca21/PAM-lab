import 'package:get/get.dart';
import '../data/datasources/remote_data_source.dart';
import '../data/repositories/recipe_repository_impl.dart';
import '../data/repositories/category_repository_impl.dart';
import '../domain/repositories/recipe_repository.dart';
import '../domain/repositories/category_repository.dart';
import '../presentation/controllers/recipe_controller.dart';
import '../presentation/controllers/category_controller.dart';

/// Dependency Injection setup
/// This file initializes all dependencies following Clean Architecture
class Injection {
  static void init() {
    // Data sources
    final remoteDataSource = RemoteDataSource();
    
    // Repositories (Data layer)
    final recipeRepository = RecipeRepositoryImpl(remoteDataSource);
    final categoryRepository = CategoryRepositoryImpl(recipeRepository);
    
    // Controllers (Presentation layer)
    Get.put<RecipeRepository>(recipeRepository);
    Get.put<CategoryRepository>(categoryRepository);
    Get.put(RecipeController(recipeRepository));
    Get.put(CategoryController(categoryRepository));
  }
}

