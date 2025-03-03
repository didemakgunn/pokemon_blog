import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final bool isHighlighted;

  const SectionTitle(
      {super.key, required this.title, required this.isHighlighted});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: isHighlighted ? Colors.black : Colors.black38,
      ),
    );
  }
}
