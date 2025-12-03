import 'package:flutter/material.dart';
import 'utils/image_helper.dart';

class NewRecipeCard extends StatelessWidget {
  const NewRecipeCard({
    super.key,
    required this.title,
    required this.author,
    required this.imagePath,
    required this.rating,
    required this.time,
    required this.authorImagePath,
    this.onTap,
  });

  final String title;
  final String author;
  final String imagePath;
  final double rating;
  final String time;
  final String authorImagePath;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      height: 250,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 35,
            left: 0,
            right: 0,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 3,
                    blurRadius: 20,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: onTap ?? () => Navigator.pushNamed(context, '/recipepage'),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    RatingRow(rating: rating),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 12,
                          backgroundImage: ImageHelper.getImageProvider(authorImagePath),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            author,
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFFA9A9A9),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(Icons.av_timer_outlined, size: 14, color: Color(0xFFA9A9A9)),
                            const SizedBox(width: 4),
                            Text(
                              time,
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFFA9A9A9),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: 16,
            top: 0,
            child: ClipOval(
              child: ImageHelper.loadImage(imagePath, height: 80, width: 80, fit: BoxFit.cover),
            ),
          ),
        ],
      ),
    );
  }
}

class RatingRow extends StatelessWidget {
  final double rating;
  
  const RatingRow({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    final fullStars = rating.floor();
    final hasHalfStar = (rating - fullStars) >= 0.5;
    
    return Row(
      children: [
        ...List.generate(
          5,
          (index) {
            if (index < fullStars) {
              // Full star
              return const Icon(Icons.star, size: 12, color: Color(0xFFFFAD30));
            } else if (index == fullStars && hasHalfStar) {
              // Half star (for decimal ratings)
              return const Icon(Icons.star_half, size: 12, color: Color(0xFFFFAD30));
            } else {
              // Empty star
              return const Icon(Icons.star_border, size: 12, color: Color(0xFFFFAD30));
            }
          },
        ),
        const SizedBox(width: 4),
        Text(
          rating.toStringAsFixed(1),
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: Color(0xFFA9A9A9),
          ),
        ),
      ],
    );
  }
}
