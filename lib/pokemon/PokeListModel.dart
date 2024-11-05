// To parse this JSON data, do
//
//     final pokemonList = pokemonListFromJson(jsonString);

import 'dart:convert';

PokemonList pokemonListFromJson(String str) =>
    PokemonList.fromJson(json.decode(str));

String pokemonListToJson(PokemonList data) => json.encode(data.toJson());

class PokemonList {
  PokemonList({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  int count;
  String next;
  dynamic previous;
  List<Result> results;

  factory PokemonList.fromJson(Map<String, dynamic> json) => PokemonList(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    required this.name,
    required this.url,
    required this.id,
  });

  String name;
  String url;
  String id;

  factory Result.fromJson(Map<String, dynamic> json) {
    var valores = (json["url"]).split("/");
    String idFromUrl = valores[valores.length - 2];
    return Result(name: json["name"], url: json["url"], id: idFromUrl);
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
        "id": id,
      };
}
