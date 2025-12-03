import 'package:flutter/material.dart';
import 'utils/image_helper.dart';

class RecipeCard extends StatelessWidget {
  final String title;
  final double rating;
  final String time;
  final String imagePath;
  final VoidCallback? onTap;
  final bool isBookmarked;

  const RecipeCard({
    super.key,
    required this.title,
    required this.rating,
    required this.time,
    required this.imagePath,
    this.onTap,
    this.isBookmarked = false,
  });

  @override
  Widget build(BuildContext context) {
    const cardWidth = 150.0;
    const imageSize = 110.0;

    return SizedBox(
      width: cardWidth,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 55,
            left: 0,
            right: 0,
            child: InkWell(
              onTap: onTap ?? () => Navigator.pushNamed(context, '/recipepage'),
              child: Container(
                height: 176,
                decoration: BoxDecoration(
                  color: const Color(0xFFD9D9D9),
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.only(
                  top: 71,
                  left: 10,
                  right: 10,
                  bottom: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF484848),
                      ),
                    ),
                    const Spacer(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // time column (anchored bottom-left)
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Time',
                              style: TextStyle(
                                fontSize: 11,
                                color: Color(0xFFA9A9A9),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              time,
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),

                        const Spacer(),
                        SizedBox(
                          height: 24,
                          width: 24,
                          child: Container(
                            decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                            child: Center(
                              child: GestureDetector(
                                onTap: () {},
                                child: Icon(
                                  isBookmarked ? Icons.bookmark : Icons.bookmark_add,
                                  size: 16,
                                  color: isBookmarked ? Colors.orange : Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          Positioned(
            top: 0,
            left: (cardWidth - imageSize) / 2,
            child: SizedBox(
              width: imageSize,
              height: imageSize,
              child: ClipOval(
                child: ImageHelper.loadImage(
                  imagePath,
                  width: imageSize,
                  height: imageSize,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          Positioned(top: 30, right: 0,
              child:
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 6,
              vertical: 2,
            ), // spacing inside
            decoration: BoxDecoration(
              color: Color(0xFFFFE1B3), // background
              borderRadius: BorderRadius.circular(12), // rounded corners
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min, // shrink to fit contents
              children: [
                const Icon(Icons.star, size: 14, color: Color(0xFFFFC107)),
                const SizedBox(width: 4),
                Text(
                  rating.toStringAsFixed(1),
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          ),
        ],
      ),
    );
  }
}
