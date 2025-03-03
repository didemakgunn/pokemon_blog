import 'package:flutter/material.dart';
import 'package:blog_app/screens/pokemon_detail_page.dart';

class PokemonCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String detailsUrl;

  const PokemonCard(
      {super.key,
      required this.name,
      required this.imageUrl,
      required this.detailsUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                PokemonDetailPage(name: name, url: detailsUrl),
          ),
        );
      },
      child: Container(
        width: 160,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.blue[100],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black, width: 1.3),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(imageUrl, height: 100),
            const SizedBox(height: 10),
            Text(
              name.toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}
