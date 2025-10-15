import 'package:flutter/material.dart';
import 'recipe_ingrident.dart'; 

class HomeScreen extends StatelessWidget {
  // Lista de categorii
  final List<String> categories = [
    'All', 'Indian', 'Italian', 'Asian', 'Chinese',
    'Fruit', 'Vegetables', 'Protein', 'Cereal', 'Local Dishes'
  ];

  // Lista de rețete populare
  final List<Map<String, dynamic>> popularRecipes = [
    {
      'name': 'Classic Greek Salad',
      'time': '15 Mins',
      'rating': '4.5',
      'image': 'assets/images/Image.png',
    },
    {
      'name': 'Crunchy Nut Coleslaw',
      'time': '10 Mins',
      'rating': '3.5',
      'image': 'assets/images/coleslaw.png',
    },
    {
      'name': 'Shrimp Chicken Andouille Sausage Jambalaya',
      'time': '10 Mins',
      'rating': '3.0',
      'image': 'assets/images/jambalaya1.png',
    },
    {
      'name': 'Barbecue Chicken Jollof Rice',
      'time': '10 Mins',
      'rating': '4.5',
      'image': 'assets/images/rice1.png',
    },
    {
      'name': 'Portuguese Piri Piri Chicken',
      'time': '10 Mins',
      'rating': '4.5',
      'image': 'assets/images/chicken.png',
    },
  ];

  // Lista de rețete noi
  final List<Map<String, dynamic>> newRecipes = [
    {
      'name': 'Steak with tomato sauce and bulgur rice',
      'time': '20 mins',
      'author': 'James Milner',
      'authorImage': 'assets/images/james.jpg',
      'image': 'assets/images/steak.png',
    },
    {
      'name': 'Pilaf sweet with lamb-and-raisins',
      'time': '20 mins',
      'author': 'Laura Wilson',
      'authorImage': 'assets/images/laura_wilson.png',
      'image': 'assets/images/pilaf.png',
    },
    {
      'name': 'Rice Pilaf, Broccoli and Chicken',
      'time': '20 mins',
      'author': 'Lucas Moura',
      'authorImage': 'assets/images/3.png',
      'image': 'assets/images/broccoli.png',
    },
    {
      'name': 'Chicken meal with sauce',
      'time': '20 mins',
      'author': 'Issabella Ethan',
      'authorImage': 'assets/images/4.png',
      'image': 'assets/images/sauce.png',
    },
    {
      'name': 'Stir-fry chicken with broccoli in sweet and sour sauce and rice',
      'time': '20 mins',
      'author': 'Miquel Ferran',
      'authorImage': 'assets/images/5.png',
      'image': 'assets/images/fry.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
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

             
              SizedBox(height: 90),
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
              children: [
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
                    color: const Color(0xFFA9A9A9),
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
              image: DecorationImage(
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
                  side: BorderSide(
                    width: 1.30,
                    color: const Color(0xFFD9D9D9),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Row(
                children: [
                  SizedBox(width: 15),
                  Icon(Icons.search, color: Color(0xFFD9D9D9), size: 18),
                  SizedBox(width: 10),
                  Text(
                    'Search recipe',
                    style: TextStyle(
                      color: const Color(0xFFD9D9D9),
                      fontSize: 11,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),

        
          SizedBox(width: 15),

         
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
                print('Filter button pressed');
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
        padding: EdgeInsets.only(left: 30, top: 10, bottom: 10),
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
            padding: EdgeInsets.only(left: 30, right: 15),
            itemCount: popularRecipes.length,
            itemBuilder: (context, index) {
              final recipe = popularRecipes[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RecipeIngrident(),
                    ),
                  );
                },
                child: Container(
                  width: 160,
                  margin: EdgeInsets.only(right: 15),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    shadows: [
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
                         
                          Container(
                            width: 160,
                            height: 130,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                              ),
                              image: DecorationImage(
                                image: AssetImage(recipe['image']),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),

                         
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                               
                                Text(
                                  _formatRecipeName(recipe['name']),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: const Color(0xFF484848),
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    height: 1.2,
                                  ),
                                ),

                                SizedBox(height: 8),

                             
                                Container(
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                  
                                    children: [
                                     
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Text(
                                            'Time',
                                            style: TextStyle(
                                              color: const Color(0xFFA9A9A9),
                                              fontSize: 11,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            recipe['time'],
                                            style: TextStyle(
                                              color: const Color(0xFF484848),
                                              fontSize: 11,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),

                                    
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

                    
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 7, vertical: 3),
                          decoration: ShapeDecoration(
                            color: const Color(0xFFFFE1B3),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.star, size: 10, color: Colors.amber),
                              SizedBox(width: 4),
                              Text(
                                recipe['rating'],
                                style: TextStyle(
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

    // Pentru alte rețete, încercăm să găsim un spațiu la mijloc
    final words = name.split(' ');
    if (words.length > 2) {
      final mid = (words.length / 2).floor();
      return '${words.sublist(0, mid).join(' ')}\n${words.sublist(mid).join(
          ' ')}';
    }

    return name;
  }

  Widget _buildNewRecipes(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30, top: 30, bottom: 10),
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
            padding: EdgeInsets.only(left: 30, right: 15),
            itemCount: newRecipes.length,
            itemBuilder: (context, index) {
              final recipe = newRecipes[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RecipeIngrident(),
                    ),
                  );
                },
                child: Container(
                  width: 280,
                  margin: EdgeInsets.only(right: 15),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    shadows: [
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
                    
                      Padding(
                        padding: const EdgeInsets.only(left: 12, top: 12, bottom: 12, right: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                               
                                Text(
                                  _formatNewRecipeName(recipe['name']),
                                  style: TextStyle(
                                    color: const Color(0xFF484848),
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    height: 1.2,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 4),
                               
                                Row(
                                  children: [
                                    Icon(Icons.star, size: 16, color: Colors.amber),
                                    Icon(Icons.star, size: 16, color: Colors.amber),
                                    Icon(Icons.star, size: 16, color: Colors.amber),
                                    Icon(Icons.star, size: 16, color: Colors.amber),
                                    Icon(Icons.star, size: 16, color: Colors.amber),
                                  ],
                                ),
                              ],
                            ),

                          
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                              
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
                                      SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          'By ${recipe['author']}',
                                          style: TextStyle(
                                            color: const Color(0xFFA9A9A9),
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

                             
                                Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: Row(
                                    children: [
                                      Icon(Icons.access_time, size: 12, color: Color(0xFFA9A9A9)),
                                      SizedBox(width: 4),
                                      Text(
                                        recipe['time'],
                                        style: TextStyle(
                                          color: const Color(0xFFA9A9A9),
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
                            boxShadow: [
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
