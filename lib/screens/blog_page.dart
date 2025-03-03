import 'package:flutter/material.dart';
import 'package:blog_app/services/pokemon_service.dart';
import 'package:blog_app/widgets/pokemon_card.dart';
import 'package:blog_app/widgets/search_bar.dart';
import 'package:blog_app/widgets/section_title.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  Future<List<dynamic>>? pokemons;
  final PokemonService _pokemonService = PokemonService();
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    pokemons = _pokemonService.fetchPokemons(limit: 100);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const Icon(Icons.menu, color: Colors.black),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.account_circle, color: Colors.black),
          ),
        ],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            SearchBarWidget(
              onSearch: (query) {
                setState(() {
                  searchQuery = query.toLowerCase();
                });
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SectionTitle(title: 'Featured', isHighlighted: true),
                SectionTitle(title: 'Latest', isHighlighted: false),
                SectionTitle(title: 'Trending', isHighlighted: false),
              ],
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: FutureBuilder<List<dynamic>>(
                future: pokemons,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Hata: ${snapshot.error}"));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text("Pokémon bulunamadı."));
                  }

                  final filteredPokemons = snapshot.data!.where((pokemon) {
                    return pokemon['name'].toLowerCase().contains(searchQuery);
                  }).toList();

                  return Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: filteredPokemons
                        .map((pokemon) => PokemonCard(
                              name: pokemon['name'],
                              imageUrl:
                                  "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${_getPokemonId(pokemon['url'])}.png",
                              detailsUrl: pokemon['url'],
                            ))
                        .toList(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getPokemonId(String url) {
    return url.split('/')[url.split('/').length - 2];
  }
}
