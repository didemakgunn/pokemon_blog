import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PokemonDetailPage extends StatefulWidget {
  final String name;
  final String url;

  const PokemonDetailPage({super.key, required this.name, required this.url});

  @override
  State<PokemonDetailPage> createState() => _PokemonDetailPageState();
}

class _PokemonDetailPageState extends State<PokemonDetailPage> {
  Map<String, dynamic>? pokemonData;

  @override
  void initState() {
    super.initState();
    fetchPokemonDetails();
  }

  Future<void> fetchPokemonDetails() async {
    final response = await http.get(Uri.parse(widget.url));

    if (response.statusCode == 200) {
      setState(() {
        pokemonData = json.decode(response.body);
      });
    } else {
      throw Exception("Failed to load Pokémon details");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        title: Text(
          widget.name.toUpperCase(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: pokemonData == null
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: widget.name,
                    child: ClipOval(
                      child: Image.network(
                        pokemonData!['sprites']['other']['official-artwork']
                            ['front_default'],
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          // ignore: deprecated_member_use
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 10,
                          spreadRadius: 3,
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "Abilities",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 10,
                          children: (pokemonData!['abilities'] as List)
                              .map((ability) => Chip(
                                    label: Text(ability['ability']['name']),
                                    backgroundColor: Colors.blueGrey[200],
                                  ))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
