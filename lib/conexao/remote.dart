import 'package:apireq/pokemon/PokeUI.dart';
import 'package:apireq/pokemon/PokeModel.dart';
import 'package:apireq/pokemon/PokeListModel.dart';
import 'package:http/http.dart' as http;

class RemoteService {
  static Future<PokemonList>? getPokemonsList() async {
    var client = http.Client();
    var uri = Uri.parse('https://pokeapi.co/api/v2/pokemon');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return pokemonListFromJson(json);
    } else {
      return PokemonList(
          results: List.empty(), count: 0, previous: "", next: "");
    }
  }

  static Future<PokemonList>? getPokemonsListLink(String link) async {
    var client = http.Client();
    var uri = Uri.parse(link);
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return pokemonListFromJson(json);
    } else {
      return PokemonList(
          results: List.empty(), count: 0, previous: "", next: "");
    }
  }

  static Future getPokemon(var number) async {
    var client = http.Client();
    var uri =
        Uri.parse('https://pokeapi.co/api/v2/pokemon/' + number.toString());
    dynamic response;
    try {
      response = await client.get(uri);
    } catch (e) {
      return "erro de conexão com a api";
    }

    var json = response.body;
    return pokemonFromJson(json);
  }
}
