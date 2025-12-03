import 'package:get/get.dart';
import '../models/category.dart';
import '../repositories/data_repository.dart';

class CategoryController extends GetxController {
  final DataRepository _repository = DataRepository();
  
  // Observable variables
  final RxList<Category> _categories = <Category>[].obs;
  final RxString _selectedCategory = 'All'.obs;
  final RxBool _isLoading = false.obs;
  final RxString _errorMessage = ''.obs;

  // Getters
  List<Category> get categories => _categories;
  String get selectedCategory => _selectedCategory.value;
  bool get isLoading => _isLoading.value;
  String get errorMessage => _errorMessage.value;

  @override
  void onInit() {
    super.onInit();
    loadCategories();
  }

  /// Loads categories asynchronously from JSON file
  Future<void> loadCategories() async {
    try {
      _isLoading.value = true;
      _errorMessage.value = '';
      
      final categories = await _repository.loadCategories();
      _categories.value = categories;
    } catch (e) {
      _errorMessage.value = 'Failed to load categories: $e';
      print('Error loading categories: $e');
    } finally {
      _isLoading.value = false;
    }
  }

  /// Sets the selected category
  void selectCategory(String category) {
    _selectedCategory.value = category;
  }

  /// Refreshes data
  Future<void> refresh() async {
    await loadCategories();
  }
}
