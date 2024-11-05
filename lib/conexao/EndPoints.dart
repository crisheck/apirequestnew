
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:apireq/car/CarListModel.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity/connectivity.dart';
import 'package:apireq/car/CarModel.dart';

//Apenas para verificar se foi passado parametro ou não para a função
const String _noValueGiven = "";

// API url
@deprecated
String beers = "https://api.punkapi.com/v2/beers";

//Para quem o emulador estiver funcionando o acesso a internet, usar o ip 10.0.2.2
String carGet = "http://172.16.2.120/apiflutter/list";
String carPost = "http://172.16.2.120/apiflutter/store";
// Aqui usamos o package http para carregar os dados da API


Future<CarListModel> getCarListData([String id = _noValueGiven]) async {
  await Future.delayed(const Duration(seconds: 2), () {});
  var response;
  if (identical(id, _noValueGiven)) {
    response = await http.get(
      Uri.parse(carGet),
    );
  } else {
    response = await http.get(
      Uri.parse(carGet).replace(queryParameters: {'id': id}),
    );
  }
  //json.decode usado para decodificar o response.body(string to map)
  return CarListModel.fromJson(json.decode(response.body));
}

Future<http.Response> createPost(CarModel car, String url) async {
  print("asdf " + jsonEncode(car));
  //Map<String, dynamic> data = new Map<String, dynamic>();
  //data['data'] = car;
  final response = await http.post(Uri.parse(carPost),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: ''
      },
      body: jsonEncode(car));
  print("321 " + jsonEncode(car));
  return response;
}

CarListModel postFromJson(String str) {
  final jsonData = json.decode(str);
  return CarListModel.fromJson(jsonData);
}

Future<CarListModel> callAPI(CarModel car) async {
  //CarModel car = CarModel(id: "15", model: "teste", price: 17.0);
  print(car.toJson());
  //CarListModel.fromJson(json.decode(response.body));
  createPost(car, carPost).then((response) {
    print(response.body);
    if (response.statusCode == 200) {
      print("1 " + response.body);
      /*print("gfff " +
          CarListModel.fromJson(json.decode(response.body))
              .carList
              .first
              .model);*/
      return CarListModel.fromJson(json.decode(response.body));
    } else {
      print("2 " + response.statusCode.toString());
      return response.statusCode.toString();
    }
  }).catchError((error) {
    print('errors : $error');
    return error.toString();
  });
  throw "Erro1";
}

/*Future<CarListModel> postCar(int idd, String modell, double pricee) async {
  CarModel car = new CarModel(id: idd, model: modell, price: pricee);
  final response = await http.post(carPost, body: json.encode([car.toJson()]));
  print("3 " + response.toString());
  return CarListModel.fromJson(json.decode(response.body));
}*/

// método para definir se há conexão com a internet
Future<bool> isConnected() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    return true;
  } else if (connectivityResult == ConnectivityResult.wifi) {
    return true;
  }
  return false;
}

Widget loadingView() {
  return Center(
    child: CircularProgressIndicator(
      backgroundColor: Colors.red,
    ),
  );
}

Widget noDataView(String msg) => Center(
      child: Text(
        msg,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
      ),
    );
