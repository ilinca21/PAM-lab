import 'package:get/get.dart';
import '../models/recipe.dart';
import '../repositories/data_repository.dart';

class RecipeController extends GetxController {
  final DataRepository _repository = DataRepository();
  
  // Observable variables
  final RxList<Recipe> _allRecipes = <Recipe>[].obs;
  final RxList<Recipe> _filteredRecipes = <Recipe>[].obs;
  final RxList<Recipe> _newRecipes = <Recipe>[].obs;
  final RxString _selectedCategory = 'All'.obs;
  final RxString _searchQuery = ''.obs;
  final RxBool _isLoading = false.obs;
  final RxString _errorMessage = ''.obs;
  final Rxn<Recipe> _selectedRecipe = Rxn<Recipe>();
  final RxBool _isLoadingDetails = false.obs;
  
  // Feed data from API
  final Rxn<UserProfile> _user = Rxn<UserProfile>();
  final Rxn<FilterModel> _filters = Rxn<FilterModel>();
  final Map<String, bool> _recipeBookmarks = <String, bool>{}.obs;
  final Map<String, String> _recipeAuthors = <String, String>{}.obs;
  final Map<String, String> _recipeAuthorImages = <String, String>{}.obs;
  final Map<String, int> _recipeIds = <String, int>{}.obs;
  
  // Recipe details data
  final Rxn<Chef> _chef = Rxn<Chef>();
  final RxList<TabInfo> _tabs = <TabInfo>[].obs;
  final Rxn<Serving> _serving = Rxn<Serving>();
  final RxBool _isBookmarked = false.obs;

  // Getters
  List<Recipe> get allRecipes => _allRecipes;
  List<Recipe> get filteredRecipes => _filteredRecipes;
  List<Recipe> get newRecipes => _newRecipes;
  String get selectedCategory => _selectedCategory.value;
  String get searchQuery => _searchQuery.value;
  bool get isLoading => _isLoading.value;
  String get errorMessage => _errorMessage.value;
  Recipe? get selectedRecipe => _selectedRecipe.value;
  bool get isLoadingDetails => _isLoadingDetails.value;
  
  // Feed data getters
  UserProfile? get user => _user.value;
  FilterModel? get filters => _filters.value;
  String get searchPlaceholder => _filters.value?.searchPlaceholder ?? 'Search recipe';
  bool isRecipeBookmarked(String recipeTitle) => _recipeBookmarks[recipeTitle] ?? false;
  String? getRecipeAuthor(String recipeTitle) => _recipeAuthors[recipeTitle];
  String? getRecipeAuthorImage(String recipeTitle) => _recipeAuthorImages[recipeTitle];
  
  // Recipe details getters
  Chef? get chef => _chef.value;
  List<TabInfo> get tabs => _tabs;
  Serving? get serving => _serving.value;
  String get servesText => _serving.value?.serves ?? '1 serve';
  bool get isBookmarked => _isBookmarked.value;

  @override
  void onInit() {
    super.onInit();
    loadRecipes();
  }

  /// Loads recipes from API endpoint (not from local JSON)
  Future<void> loadRecipes() async {
    try {
      _isLoading.value = true;
      _errorMessage.value = '';
      
      // Fetch data from API endpoint
      final feed = await _repository.loadFeedV2();
      
      if (feed != null) {
        // Store feed data
        _user.value = feed.user;
        _filters.value = feed.filters;
        
        // Map FeedRecipeItem from API to Recipe model for UI compatibility
        final recipes = feed.recipes.map((feedRecipe) {
          // Store bookmark status and ID by title
          _recipeBookmarks[feedRecipe.name] = feedRecipe.isBookmarked;
          _recipeIds[feedRecipe.name] = feedRecipe.id;
          
          // Find category - API doesn't provide category per recipe in feed,
          // so we'll use "All" as default or extract from filters if needed
          String category = 'All';
          
          return Recipe(
            category: category,
            imagePath: feedRecipe.image,
            title: feedRecipe.name,
            rating: feedRecipe.rating,
            time: feedRecipe.time,
            serves: 1, // Default value, not provided in feed API
            reviewCount: '', // Not provided in feed API
            ingredients: [], // Ingredients are only in details endpoint
          );
        }).toList();
        
        // Map NewRecipeItem from API to Recipe model
        final newRecipes = feed.newRecipes.map((newRecipe) {
          // Store author info and ID by title
          _recipeAuthors[newRecipe.name] = newRecipe.author;
          _recipeAuthorImages[newRecipe.name] = newRecipe.authorImage;
          _recipeIds[newRecipe.name] = newRecipe.id;
          print('Saved author for ${newRecipe.name}: ${newRecipe.author}');
          
          return Recipe(
            category: 'All',
            imagePath: newRecipe.image,
            title: newRecipe.name,
            rating: newRecipe.rating,
            time: newRecipe.time,
            serves: 1,
            reviewCount: '',
            ingredients: [],
          );
        }).toList();
        
        _allRecipes.value = recipes;
        _filteredRecipes.value = recipes;
        _newRecipes.value = newRecipes;
      } else {
        _errorMessage.value = 'Failed to load recipes from API';
        _allRecipes.value = [];
        _filteredRecipes.value = [];
      }
    } catch (e) {
      _errorMessage.value = 'Error loading recipes: $e';
      print('Error loading recipes: $e');
      _allRecipes.value = [];
      _filteredRecipes.value = [];
    } finally {
      _isLoading.value = false;
    }
  }


  /// Filters recipes by category
  void filterByCategory(String category) {
    _selectedCategory.value = category;
    _applyFilters();
  }

  /// Searches recipes by query
  void searchRecipes(String query) {
    _searchQuery.value = query;
    _applyFilters();
  }

  /// Applies both category and search filters
  void _applyFilters() {
    List<Recipe> filtered = _allRecipes;
    
    // Apply category filter
    if (_selectedCategory.value != 'All') {
      filtered = _repository.filterRecipesByCategory(filtered, _selectedCategory.value);
    }
    
    // Apply search filter
    if (_searchQuery.value.isNotEmpty) {
      filtered = _repository.searchRecipes(filtered, _searchQuery.value);
    }
    
    _filteredRecipes.value = filtered;
  }

  /// Clears all filters
  void clearFilters() {
    _selectedCategory.value = 'All';
    _searchQuery.value = '';
    _filteredRecipes.value = _allRecipes;
  }

  /// Refreshes data
  Future<void> refresh() async {
    await loadRecipes();
  }

  /// Selects a recipe for detail view and loads full details including ingredients
  Future<void> selectRecipe(Recipe recipe) async {
    _selectedRecipe.value = recipe;
    
    // Try to get author from new_recipes if available (for new recipes)
    final authorFromFeed = _recipeAuthors[recipe.title];
    if (authorFromFeed != null) {
      // Create a temporary chef from author info for new recipes
      _chef.value = Chef(
        name: authorFromFeed,
        profileImage: _recipeAuthorImages[recipe.title] ?? '',
        location: 'Unknown',
        isFollowing: false,
      );
    }
    
    // Load full recipe details from API to get ingredients
    try {
      _isLoadingDetails.value = true;
      // Use the actual recipe ID from feed, or try without ID if not found
      final recipeId = _recipeIds[recipe.title];
      final detailResponse = recipeId != null
          ? await _repository.loadRecipeDetailV2(recipeId)
          : await _repository.loadRecipeDetailV2(null);
      
      if (detailResponse != null) {
        // Store recipe details data (this will override the temporary chef if details are loaded)
        _chef.value = detailResponse.chef;
        _tabs.value = detailResponse.tabs;
        _serving.value = detailResponse.serving;
        _isBookmarked.value = detailResponse.recipe.isBookmarked;
        
        // Map RecipeDetailResponse to Recipe with ingredients
        final ingredients = detailResponse.ingredients.map((ing) {
          // Extract grams from quantity string (e.g., "500g" -> 500)
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
        }).toList();
        
        // Update selected recipe with full details
        final updatedRecipe = Recipe(
          category: recipe.category,
          imagePath: detailResponse.recipe.image,
          title: detailResponse.recipe.title,
          rating: detailResponse.recipe.rating,
          time: detailResponse.recipe.cookTime,
          serves: detailResponse.serving.totalItems,
          reviewCount: detailResponse.recipe.reviews,
          ingredients: ingredients,
        );
        
        _selectedRecipe.value = updatedRecipe;
      }
    } catch (e) {
      print('Error loading recipe details: $e');
      // Keep the original recipe if details fail to load
    } finally {
      _isLoadingDetails.value = false;
    }
  }
}