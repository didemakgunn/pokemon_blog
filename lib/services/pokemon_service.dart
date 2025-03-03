import 'dart:convert';
import 'package:http/http.dart' as http;

class PokemonService {
  final String baseUrl = "https://pokeapi.co/api/v2/pokemon";

  Future<List<dynamic>> fetchPokemons({int limit = 100}) async {
    final response = await http.get(Uri.parse("$baseUrl?limit=$limit"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['results'];
    } else {
      throw Exception('Failed to load Pokémon');
    }
  }

  Future<List<String>> fetchPokemonTypes() async {
    final response =
        await http.get(Uri.parse("https://pokeapi.co/api/v2/type"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['results'] as List)
          .map((type) => type['name'].toString())
          .toList();
    } else {
      throw Exception('Failed to load Pokémon types');
    }
  }
}
