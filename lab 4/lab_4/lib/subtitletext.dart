import 'package:flutter/material.dart';

class SubtitleText extends StatelessWidget {
  final String text;
  SubtitleText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: Colors.grey[600], fontSize: 16),
    );
  }
}