// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Pokemon pokemonFromJson(String str) => Pokemon.fromJson(json.decode(str));

String pokemonToJson(Pokemon data) => json.encode(data.toJson());

class Pokemon {
  Pokemon({
    required this.weight,
    required this.height,
    required this.id,
    required this.name,
    this.sprites,
  });

  int height;
  int id;
  String name;
  Sprites? sprites;
  int weight;

  factory Pokemon.fromJson(Map<String, dynamic> json) => Pokemon(
        height: json["height"],
        id: json["id"],
        name: json["name"],
        sprites: Sprites.fromJson(json["sprites"]),
        weight: json["weight"],
      );

  Map<String, dynamic> toJson() => {
        "height": height,
        "id": id,
        "name": name,
        "sprites": sprites!.toJson(),
        "weight": weight,
      };
}

class Sprites {
  Sprites({
    required this.frontDefault,
  });

  String frontDefault;

  factory Sprites.fromJson(Map<String, dynamic> json) => Sprites(
        frontDefault: json["front_default"],
      );

  Map<String, dynamic> toJson() => {
        "front_default": frontDefault,
      };
}
