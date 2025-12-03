import '../../domain/entities/recipe.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/entities/chef.dart';
import '../../domain/entities/tab_info.dart';
import '../../domain/entities/serving.dart';
import '../../domain/repositories/recipe_repository.dart';
import '../datasources/remote_data_source.dart';
import '../models/feed_response_model.dart';
import '../models/recipe_detail_response_model.dart';

/// Implementation of RecipeRepository
/// This is part of the Data layer
class RecipeRepositoryImpl implements RecipeRepository {
  final RemoteDataSource _remoteDataSource;

  RecipeRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<Recipe>> loadRecipes() async {
    final feed = await loadFeed();
    if (feed != null) {
      return feed.recipes;
    }
    return [];
  }

  @override
  Future<FeedResponse?> loadFeed() async {
    final feedModel = await _remoteDataSource.loadFeed();
    if (feedModel == null) {
      return null;
    }

    // Map API models to Domain entities
    final user = UserProfile(
      name: feedModel.user.name,
      profileImage: feedModel.user.profileImage,
      greeting: feedModel.user.greeting,
    );

    final filters = FilterModel(
      searchPlaceholder: feedModel.filters.searchPlaceholder,
      categories: feedModel.filters.categories.map((c) => CategoryFilter(
        id: c.id,
        name: c.name,
        selected: c.selected,
      )).toList(),
    );

    // Build metadata maps
    final recipeIds = <String, int>{};
    final recipeBookmarks = <String, bool>{};
    final recipeAuthors = <String, String>{};
    final recipeAuthorImages = <String, String>{};

    final recipes = feedModel.recipes.map((r) {
      recipeIds[r.name] = r.id;
      recipeBookmarks[r.name] = r.isBookmarked;
      return Recipe(
        category: 'All',
        imagePath: r.image,
        title: r.name,
        rating: r.rating,
        time: r.time,
        serves: 1,
        reviewCount: '',
        ingredients: [],
      );
    }).toList();

    final newRecipes = feedModel.newRecipes.map((r) {
      recipeIds[r.name] = r.id;
      recipeAuthors[r.name] = r.author;
      recipeAuthorImages[r.name] = r.authorImage;
      return Recipe(
        category: 'All',
        imagePath: r.image,
        title: r.name,
        rating: r.rating,
        time: r.time,
        serves: 1,
        reviewCount: '',
        ingredients: [],
      );
    }).toList();

    return FeedResponse(
      user: user,
      filters: filters,
      recipes: recipes,
      newRecipes: newRecipes,
      recipeIds: recipeIds,
      recipeBookmarks: recipeBookmarks,
      recipeAuthors: recipeAuthors,
      recipeAuthorImages: recipeAuthorImages,
    );
  }

  @override
  Future<RecipeDetailResponse?> loadRecipeDetail(int? recipeId) async {
    final detailModel = await _remoteDataSource.loadRecipeDetail(recipeId);
    if (detailModel == null) {
      return null;
    }

    // Map API models to Domain entities
    final recipe = Recipe(
      category: 'All',
      imagePath: detailModel.recipe.image,
      title: detailModel.recipe.title,
      rating: detailModel.recipe.rating,
      time: detailModel.recipe.cookTime,
      serves: detailModel.serving.totalItems,
      reviewCount: detailModel.recipe.reviews,
      ingredients: detailModel.ingredients.map((ing) {
        int grams = 0;
        try {
          final quantityStr = ing.quantity.replaceAll('g', '').trim();
          grams = int.parse(quantityStr);
        } catch (e) {
          grams = 0;
        }
        return RecipeIngredient(
          name: ing.name,
          imagePath: ing.icon,
          grams: grams,
        );
      }).toList(),
    );

    final chef = Chef(
      name: detailModel.chef.name,
      profileImage: detailModel.chef.profileImage,
      location: detailModel.chef.location,
      isFollowing: detailModel.chef.isFollowing,
    );

    final tabs = detailModel.tabs.map((t) => TabInfo(
      name: t.name,
      active: t.active,
    )).toList();

    final serving = Serving(
      serves: detailModel.serving.serves,
      totalItems: detailModel.serving.totalItems,
    );

    return RecipeDetailResponse(
      recipe: recipe,
      chef: chef,
      tabs: tabs,
      serving: serving,
      ingredients: recipe.ingredients,
    );
  }
}

