import 'package:flutter/material.dart';
import 'package:apireq/pokemon/PokeModel.dart';

import '../conexao/remote.dart';

class PokeUI extends StatefulWidget {
  final String? id;
  final String? name;
  const PokeUI({Key? key, this.id, this.name}) : super(key: key);

  @override
  State<PokeUI> createState() => _PokemonDetailState();
}

class _PokemonDetailState extends State<PokeUI> {
  Pokemon? pokemon;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    //fetch data from API
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.name.toString()),
        ),
        body: FutureBuilder(
          future: RemoteService.getPokemon(widget.id),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return mostraPokemon(snapshot.data);
              } else {
                return const Text("Erro de conexão");
              }
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [const CircularProgressIndicator()])
                  ]);
            } else {
              return const Text("Erro de conexão");
            }
          },
        ));
  }

  mostraPokemon(Pokemon pokemon) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(pokemon.sprites!.frontDefault),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Poke-ID:' + pokemon.id.toString(),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Altura: ' + pokemon.height.toString(),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Peso: ' + pokemon.weight.toString(),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ],
        )
      ],
    );
  }
}
