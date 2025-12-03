import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/feed_response_model.dart';
import '../models/recipe_detail_response_model.dart';

/// Remote data source for API calls
/// This is part of the Data layer
class RemoteDataSource {
  static const String _baseUrl = 'https://test-api-jlbn.onrender.com/v2';
  static const String _feedEndpoint = '$_baseUrl/feed';
  static const String _feedDetailsEndpoint = '$_baseUrl/feed/details';

  /// Loads feed data from API
  Future<FeedResponseModel?> loadFeed() async {
    try {
      final response = await http.get(Uri.parse(_feedEndpoint));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return FeedResponseModel.fromJson(jsonData);
      } else {
        print('Error loading feed: HTTP ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error loadFeed: $e');
      return null;
    }
  }

  /// Loads recipe details from API
  Future<RecipeDetailResponseModel?> loadRecipeDetail(int? recipeId) async {
    try {
      final url = recipeId != null
          ? '$_feedDetailsEndpoint?id=$recipeId'
          : _feedDetailsEndpoint;
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return RecipeDetailResponseModel.fromJson(jsonData);
      } else {
        print('Error loading recipe detail: HTTP ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error loadRecipeDetail: $e');
      return null;
    }
  }
}

