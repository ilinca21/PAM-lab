import 'package:flutter/material.dart';

class ScoreBadge extends StatelessWidget {
  const ScoreBadge({super.key, required this.score});
  final double score;

  @override
  Widget build(BuildContext context) {
    return Container(
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
            score.toStringAsFixed(1),
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
