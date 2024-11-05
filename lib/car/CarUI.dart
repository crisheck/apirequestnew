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
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: FutureBuilder<CarListModel>(
          future: carListFuture,
          builder: (context, snapshot) {
            // Com switch conseguimos identificar em que ponto da conexão estamos
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                {
                  return CircularProgressIndicator(
                      backgroundColor: Colors.red,
                    );
                }
              case ConnectionState.active:
                { break; }
              case ConnectionState.done:
                { if (snapshot.hasData) {
                    if (snapshot.data!.carList != null) {
                      if (snapshot.data!.carList!.length > 0) {
                        return ListView.builder(
                            itemCount: snapshot.data!.carList!.length,
                            itemBuilder: (context, index) {
                              return generateColum(
                                  snapshot.data!.carList![index]);
                            });
                      } else {
                        return Text("1 No data found");
                      }
                    } else {
                      return noDataView("2 No data found");
                    } } else if (snapshot.hasError) {
                    return noDataView("1 car Something went wrong: " +
                        snapshot.error.toString());
                  } else {
                    return noDataView("2 Something went wrong");
                  } }
              case ConnectionState.none:
                { break; }
            } throw "Error"; }),
    );
  }
  @override
  void initState() {
    isConnected().then((internet) {
      if (internet) { setState(() { carListFuture = getCarListData();
        }); } });
    super.initState();
  }
  Widget generateColum(CarModel item) => Card(
        child: ListTile(
          title: Text(
            item.model!,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          subtitle: Text(item.id.toString(),
              style: TextStyle(fontWeight: FontWeight.w600)),
        ),  );}
