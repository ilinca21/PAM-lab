import 'package:flutter/material.dart';
import 'package:pam_lab2/bookmarkbutton.dart';
import 'package:pam_lab2/cooktime.dart';
import 'package:pam_lab2/scorebadge.dart';
import 'utils/image_helper.dart';

class RecipeOverview extends StatelessWidget {
  const RecipeOverview({
    super.key,
    required this.imageUrl,
    required this.preptime,
    required this.score,
    required this.name,
    required this.reviewCount,
    this.isBookmarked = false,
  });
  final String imageUrl;
  final String preptime;
  final double score;
  final String name;
  final String reviewCount;
  final bool isBookmarked;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: FlashCard(
            imageUrl: imageUrl,
            preptime: preptime,
            score: score,
            isBookmarked: isBookmarked,
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: InfoRow(title: name, reviewCount: reviewCount),
        ),
      ],
    );
  }
}

class FlashCard extends StatelessWidget {
  const FlashCard({
    super.key,
    required this.imageUrl,
    required this.preptime,
    required this.score,
    this.isBookmarked = false,
  });
  final String imageUrl;
  final String preptime;
  final double score;
  final bool isBookmarked;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ImageHelper.loadImage(imageUrl, height: 150, width: 315),
        Container(
          width: 315,
          height: 150,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Colors.black],
            ),
          ),
        ),
        Positioned(top: 10, right: 10, child: ScoreBadge(score: score)),
        Positioned(
          right: 10,
          bottom: 10,
          child: Row(
            children: [
              CookTime(preptime: preptime),
              const SizedBox(width: 10),
              BookmarkButton(isBookmarked: isBookmarked),
            ],
          ),
        ),
      ],
    );
  }
}

class InfoRow extends StatelessWidget {
  const InfoRow({super.key, required this.title, required this.reviewCount});
  final String title;
  final String reviewCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 41,
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              softWrap: true,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
          ),
          // Spacer(),
          Text(
            '($reviewCount Reviews)',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: Color(0xFFA9A9A9),
            ),
          ),
        ],
      ),
    );
  }
}
