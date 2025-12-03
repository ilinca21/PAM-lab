import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'recipe_ingrident.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> categories = [];
  List<dynamic> popularRecipes = [];
  List<dynamic> newRecipes = [];
  List<dynamic> ingredientsGlobal = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadAllData();
  }

  Future<void> loadAllData() async {
    try {
      final jsonStr = await rootBundle.loadString('assets/data/recipes_data.json');
      final data = json.decode(jsonStr);

      setState(() {
        categories = List<String>.from(data['categories'] ?? []);
        popularRecipes = List<dynamic>.from(data['popularRecipes'] ?? []);
        newRecipes = List<dynamic>.from(data['newRecipes'] ?? []);
        ingredientsGlobal = List<dynamic>.from(data['ingredients'] ?? []);
        isLoading = false;
      });
    } catch (e) {

      setState(() => isLoading = false);
      debugPrint('Error loading JSON: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header Section
              _buildHeader(),

              // Search Bar
              _buildSearchBar(),

              // Categories
              _buildCategories(),

              // Popular Recipes
              _buildPopularRecipes(context),

              // New Recipes
              _buildNewRecipes(context),

              // Bottom spacer
              const SizedBox(height: 90),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Hello Jega',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'What are you cooking today?',
                  style: TextStyle(
                    color: Color(0xFFA9A9A9),
                    fontSize: 11,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: const DecorationImage(
                image: AssetImage("assets/images/Avatar.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Row(
        children: [

          Expanded(
            child: Container(
              height: 40,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1.30, color: Color(0xFFD9D9D9)),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Row(
                children: const [
                  SizedBox(width: 15),
                  Icon(Icons.search, color: Color(0xFFD9D9D9), size: 18),
                  SizedBox(width: 10),
                  Text(
                    'Search recipe',
                    style: TextStyle(
                      color: Color(0xFFD9D9D9),
                      fontSize: 11,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(width: 15),

          Container(
            width: 40,
            height: 40,
            decoration: ShapeDecoration(
              color: const Color(0xFF119475),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: IconButton(
              icon: Image.asset(
                'assets/images/Filter.png',
                width: 18,
                height: 18,
              ),
              onPressed: () {
                debugPrint('Filter button pressed');
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategories() {
    return Container(
      height: 51,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 30, top: 10, bottom: 10),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
              decoration: ShapeDecoration(
                color: index == 0 ? const Color(0xFF119475) : Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                categories[index],
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: index == 0 ? Colors.white : const Color(0xFF71B1A1),
                  fontSize: 11,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPopularRecipes(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 250,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 30, right: 15),
            itemCount: popularRecipes.length,
            itemBuilder: (context, index) {
              final recipe = popularRecipes[index];
              return GestureDetector(
                onTap: () {
                  // trimitem lista de ingrediente globală la ecranul ingredient
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RecipeIngrident(ingredients: ingredientsGlobal),
                    ),
                  );
                },
                child: Container(
                  width: 160,
                  margin: const EdgeInsets.only(right: 15),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x19000000),
                        blurRadius: 20,
                        offset: Offset(0, 0),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Recipe Image
                          Container(
                            width: 160,
                            height: 130,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                              ),
                              image: DecorationImage(
                                image: AssetImage(recipe['image']),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),

                          // Recipe Info
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Recipe Name - CENTRAT
                                Text(
                                  _formatRecipeName(recipe['name'] ?? ''),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Color(0xFF484848),
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    height: 1.2,
                                  ),
                                ),

                                const SizedBox(height: 8),

                                // Time + Bookmark - ROW PENTRU ALINIERE ORIZONTALĂ
                                Container(
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Time',
                                            style: TextStyle(
                                              color: Color(0xFFA9A9A9),
                                              fontSize: 11,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            recipe['time'] ?? '',
                                            style: const TextStyle(
                                              color: Color(0xFF484848),
                                              fontSize: 11,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),

                                      // Bookmark - PARTEA DREAPTA
                                      Image.asset(
                                        'assets/images/Bookmark.png',
                                        width: 16,
                                        height: 16,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      // RATING POZIȚIONAT PE IMAGINE
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                          decoration: ShapeDecoration(
                            color: const Color(0xFFFFE1B3),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.star, size: 10, color: Colors.amber),
                              const SizedBox(width: 4),
                              Text(
                                recipe['rating']?.toString() ?? '',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 11,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  String _formatRecipeName(String name) {
    if (name == 'Classic Greek Salad') {
      return 'Classic Greek\nSalad';
    } else if (name == 'Crunchy Nut Coleslaw') {
      return 'Crunchy Nut\nColeslaw';
    } else if (name == 'Shrimp Chicken Andouille Sausage Jambalaya') {
      return 'Shrimp Chicken\nAndouille Sausage Jambalaya';
    } else if (name == 'Barbecue Chicken Jollof Rice') {
      return 'Barbecue Chicken\nJollof Rice';
    } else if (name == 'Portuguese Piri Piri Chicken') {
      return 'Portuguese Piri\nPiri Chicken';
    }

    final words = name.split(' ');
    if (words.length > 2) {
      final mid = (words.length / 2).floor();
      return '${words.sublist(0, mid).join(' ')}\n${words.sublist(mid).join(' ')}';
    }

    return name;
  }

  Widget _buildNewRecipes(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 30, top: 30, bottom: 10),
          child: Text(
            'New Recipes',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          height: 139,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 30, right: 15),
            itemCount: newRecipes.length,
            itemBuilder: (context, index) {
              final recipe = newRecipes[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RecipeIngrident(ingredients: ingredientsGlobal),
                    ),
                  );
                },
                child: Container(
                  width: 280,
                  margin: const EdgeInsets.only(right: 15),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x19000000),
                        blurRadius: 20,
                        offset: Offset(0, 0),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Stack(
                    children: [
                      // Recipe Details
                      Padding(
                        padding: const EdgeInsets.only(left: 12, top: 12, bottom: 12, right: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Recipe Name + Rating
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Recipe Name
                                Text(
                                  _formatNewRecipeName(recipe['name'] ?? ''),
                                  style: const TextStyle(
                                    color: Color(0xFF484848),
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    height: 1.2,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                // Rating Stars
                                Row(
                                  children: const [
                                    Icon(Icons.star, size: 16, color: Colors.amber),
                                    Icon(Icons.star, size: 16, color: Colors.amber),
                                    Icon(Icons.star, size: 16, color: Colors.amber),
                                    Icon(Icons.star, size: 16, color: Colors.amber),
                                    Icon(Icons.star, size: 16, color: Colors.amber),
                                  ],
                                ),
                              ],
                            ),

                            // Author and Time - SEPARAT COMPLET
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Author - STÂNGA
                                Expanded(
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 25,
                                        height: 25,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: AssetImage(recipe['authorImage']),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          'By ${recipe['author'] ?? ''}',
                                          style: const TextStyle(
                                            color: Color(0xFFA9A9A9),
                                            fontSize: 11,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // Time - DREAPTA (COMPLET SEPARAT)
                                Container(
                                  margin: const EdgeInsets.only(left: 10),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.access_time, size: 12, color: Color(0xFFA9A9A9)),
                                      const SizedBox(width: 4),
                                      Text(
                                        recipe['time'] ?? '',
                                        style: const TextStyle(
                                          color: Color(0xFFA9A9A9),
                                          fontSize: 11,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Recipe Image
                      Positioned(
                        top: -3,
                        left: 170,
                        child: Container(
                          width: 79.95,
                          height: 86,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(43),
                            image: DecorationImage(
                              image: AssetImage(recipe['image']),
                              fit: BoxFit.cover,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x19000000),
                                blurRadius: 10,
                                offset: Offset(0, 2),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  String _formatNewRecipeName(String name) {
    if (name == 'Steak with tomato sauce and bulgur rice') {
      return 'Steak with tomato...';
    } else if (name == 'Pilaf sweet with lamb-and-raisins') {
      return 'Pilaf sweet';
    }
    if (name.length > 20) {
      return name.substring(0, 20) + '...';
    }
    return name;
  }
}
