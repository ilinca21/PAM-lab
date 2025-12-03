import 'package:flutter/material.dart';

class BookmarkButton extends StatelessWidget {
  const BookmarkButton({super.key, this.isBookmarked = false, this.onTap});
  
  final bool isBookmarked;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
      width: 24,
      child: Container(
        decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
        child: Center(
          child: GestureDetector(
            onTap: onTap ?? () {},
            child: Icon(
              isBookmarked ? Icons.bookmark : Icons.bookmark_add,
              size: 16,
              color: isBookmarked ? Colors.orange : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
