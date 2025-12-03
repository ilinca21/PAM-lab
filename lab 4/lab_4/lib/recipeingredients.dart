import 'package:flutter/material.dart';
import 'utils/image_helper.dart';

class RecipeIngredients extends StatelessWidget {
  const RecipeIngredients({super.key, required this.serves, required this.ingredients, this.servesText});

  final int serves;
  final String? servesText;
  final List<IngredientCard> ingredients;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Summary(ingredientCount: ingredients.length, serves: serves, servesText: servesText),
        const SizedBox(height: 20),
        Ingredients(
          ingredients: ingredients,
        ),
      ],
    );
  }
}

class Summary extends StatelessWidget {
  const Summary({
    super.key,
    required this.serves,
    required this.ingredientCount,
    this.servesText,
  });
  final int serves;
  final int ingredientCount;
  final String? servesText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            Icon(Icons.restaurant, color: Color(0xFFA9A9A9)),
            const SizedBox(width: 5),
            Text(
              servesText ?? '$serves serve',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w400,
                color: Color(0xFFA9A9A9),
              ),
            ),
          ],
        ),
        const Spacer(),
        Text(
          '$ingredientCount items',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w400,
            color: Color(0xFFA9A9A9),
          ),
        ),
      ],
    );
  }
}

class Ingredients extends StatelessWidget {
  const Ingredients({super.key, required this.ingredients});
  final List<IngredientCard> ingredients;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: ingredients
          .map(
            (card) => Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: card,
        ),
      )
          .toList(),
    );
  }
}

class IngredientCard extends StatelessWidget {
  const IngredientCard({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.grams,
  });
  final String name;
  final String imageUrl;
  final int grams;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 315,
      height: 76,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          color: Color(0xFFD9D9D9),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          child: Row(
            children: [
              IngredientImageBox(imageUrl: imageUrl),
              const SizedBox(width: 16),
              Text(
                name,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              Text(
                '${grams}g',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFFA9A9A9),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class IngredientImageBox extends StatelessWidget {
  const IngredientImageBox({super.key, required this.imageUrl});
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 52,
      height: 52,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white,
        ),
        child: Center(
          child: SizedBox(width: 40, height: 40, child: ImageHelper.loadImage(imageUrl, width: 40, height: 40)),
        ),
      ),
    );
  }
}
