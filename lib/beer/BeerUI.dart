import 'package:flutter/material.dart';
import 'BeerModel.dart';
import 'package:apireq/beer/BeerListModel.dart';
import 'package:apireq/conexao/EndPoints.dart';

class BeerUI extends StatefulWidget {
  @override
  _BeerUI createState() => _BeerUI();
}

class _BeerUI extends State {
  Future<BeerListModel>? beerListFuture;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: FutureBuilder<BeerListModel>(
          future: beerListFuture,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            // Com switch conseguimos identificar em que ponto da conexão estamos
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                {
                  return loadingView();
                }
              case ConnectionState.active:
                {
                  break;
                }
              case ConnectionState.done:
                {
                  // Se o estado é de finalizado, será trabalhado os dados do snapshot recebido
                  // snapshot representa um instantâneo (foto) dos dados recebidos
                  // Se o snapshot tem informações, apresenta
                  if (snapshot.hasData) {
                    if (snapshot.data!.beerList != null) {
                      if (snapshot.data!.beerList.length > 0) {
                        // preenche a lista
                        return ListView.builder(
                            itemCount: snapshot.data!.beerList.length,
                            itemBuilder: (context, index) {
                              return generateColum(
                                  snapshot.data!.beerList[index]);
                            });
                      } else {
                        // Em caso de retorno de lista vazia
                        return noDataView("1 No data found");
                      }
                    } else {
                      // Apresenta erro se a lista ou os dados são nulos
                      return noDataView("2 No data found");
                    }
                  } else if (snapshot.hasError) {
                    // Apresenta mensagem se teve algum erro
                    return noDataView("1 beer Something went wrong: " +
                        snapshot.error.toString());
                  } else {
                    return noDataView("2 Something went wrong");
                  }
                }
              case ConnectionState.none:
                {
                  return loadingView();
                }
            }
            throw "Error1";
          }),
    );
  }

  @override
  void initState() {
    // Verificamos a conexão com a internet
    isConnected().then((internet) {
      if (internet) {
        // define o estado enquanto carrega as informações da API
        setState(() {
          // chama a API para apresentar os dados
          // Aqui estamos no initState (ao iniciar a aplicação/tela), mas pode ser iniciado com um click de botão.
         // beerListFuture = getBeerListData();
        });
      }
    });
    super.initState();
  }

  Widget generateColum(BeerModel item) => Card(
        child: ListTile(
          leading: Image.network(item.imageUrl),
          title: Text(
            item.name,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          subtitle:
              Text(item.tagline, style: TextStyle(fontWeight: FontWeight.w600)),
        ),
      );
}
