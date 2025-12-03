import 'package:get/get.dart';
import '../../domain/entities/recipe.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/entities/chef.dart';
import '../../domain/entities/tab_info.dart';
import '../../domain/entities/serving.dart';
import '../../domain/repositories/recipe_repository.dart';

/// Presentation layer controller for recipes
/// Uses GetX for state management
class RecipeController extends GetxController {
  final RecipeRepository _repository;
  
  RecipeController(this._repository);
  
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

  /// Loads recipes from repository
  Future<void> loadRecipes() async {
    try {
      _isLoading.value = true;
      _errorMessage.value = '';
      
      final feed = await _repository.loadFeed();
      
      if (feed != null) {
        _user.value = feed.user;
        _filters.value = feed.filters;
        
        // Store metadata from feed
        _recipeIds.addAll(feed.recipeIds);
        _recipeBookmarks.addAll(feed.recipeBookmarks);
        _recipeAuthors.addAll(feed.recipeAuthors);
        _recipeAuthorImages.addAll(feed.recipeAuthorImages);
        
        _allRecipes.value = feed.recipes;
        _filteredRecipes.value = feed.recipes;
        _newRecipes.value = feed.newRecipes;
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
    
    if (_selectedCategory.value != 'All') {
      filtered = filtered.where((r) => r.category == _selectedCategory.value).toList();
    }
    
    if (_searchQuery.value.isNotEmpty) {
      filtered = filtered.where((r) => 
        r.title.toLowerCase().contains(_searchQuery.value.toLowerCase())
      ).toList();
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

  /// Selects a recipe for detail view and loads full details
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
      final recipeId = _recipeIds[recipe.title];
      final detailResponse = await _repository.loadRecipeDetail(recipeId);
      
      if (detailResponse != null) {
        // Store recipe details data (this will override the temporary chef if details are loaded)
        _chef.value = detailResponse.chef;
        _tabs.value = detailResponse.tabs;
        _serving.value = detailResponse.serving;
        _isBookmarked.value = _recipeBookmarks[recipe.title] ?? false;
        
        _selectedRecipe.value = detailResponse.recipe;
      }
    } catch (e) {
      print('Error loading recipe details: $e');
      // Keep the original recipe if details fail to load
    } finally {
      _isLoadingDetails.value = false;
    }
  }
}

