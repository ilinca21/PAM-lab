import 'package:flutter/material.dart';

class CookTime extends StatelessWidget {
  const CookTime({super.key, required this.preptime});
  final String preptime;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25,
      child: Row(
        children: [
          Icon(Icons.av_timer_outlined, size: 14, color: Color(0xFFA9A9A9)),
          const SizedBox(width: 4),
          Text(
            preptime,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w400,
              color: Color(0xFFA9A9A9),
            ),
          ),
        ],
      ),
    );
  }
}
