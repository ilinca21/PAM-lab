import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'presentation/controllers/recipe_controller.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final RecipeController controller = Get.find<RecipeController>();

    return Row(
      children: [
        Expanded(
          child: Obx(() => TextField(
            decoration: InputDecoration(
              hintText: controller.searchPlaceholder,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              contentPadding: EdgeInsets.symmetric(
                  horizontal: 20, vertical: 0),
            ),
            onChanged: (value) {
              controller.searchRecipes(value);
            },
          )),
        ),
        SizedBox(width: 10),
        Container(
          decoration: BoxDecoration(
            color: Color(0xFF169C89),
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            icon: Icon(Icons.filter_alt, color: Colors.white),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}