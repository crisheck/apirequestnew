import 'package:flutter/material.dart';
import 'package:apireq/car/CarModel.dart';
import 'package:apireq/car/CarListModel.dart';
import 'package:apireq/conexao/EndPoints.dart';

class CarUI extends StatefulWidget {
  @override
  _CarUI createState() => _CarUI();
}

class _CarUI extends State {
  Future<CarListModel>? carListFuture;

  @override
  void initState() {
    super.initState();
    // Verifica conexão e carrega lista
    isConnected().then((internet) {
      if (internet) {
        setState(() {
          carListFuture = getCarListData();
        });
      } else {
        // Caso não haja internet
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Sem conexão com a Internet.'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: FutureBuilder<CarListModel>(
        future: carListFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Exibe animação de carregamento
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    backgroundColor: Colors.red,
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Carregando carros...",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            );
          }

          // Caso de erro
          if (snapshot.hasError) {
            return noDataView(
              "Erro ao carregar: ${snapshot.error.toString()}",
            );
          }

          // Caso sem dados
          if (!snapshot.hasData ||
              snapshot.data == null ||
              snapshot.data!.carList == null ||
              snapshot.data!.carList!.isEmpty) {
            return noDataView("Nenhum carro encontrado.");
          }

          // Se chegou aqui, temos dados válidos
          final cars = snapshot.data!.carList!;
          return ListView.builder(
            itemCount: cars.length,
            itemBuilder: (context, index) {
              return generateColum(cars[index]);
            },
          );
        },
      ),
    );
  }

  // Widget para exibir cada item da lista
  Widget generateColum(CarModel item) => Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 3,
        margin: const EdgeInsets.symmetric(vertical: 6),
        child: ListTile(
          leading: const Icon(Icons.directions_car, color: Colors.blueAccent),
          title: Text(
            item.model ?? "Modelo desconhecido",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          subtitle: Text(
            "ID: ${item.id ?? '-'}",
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
      );
}
