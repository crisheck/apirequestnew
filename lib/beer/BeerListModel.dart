import 'BeerModel.dart';

class BeerListModel {
  List<BeerModel>? beerList;

  BeerListModel({this.beerList});

  BeerListModel.fromJson(List<dynamic> parsedJson) {
    beerList = [];
    parsedJson.forEach((v) {
      beerList!.add(BeerModel.fromJson(v));
    });
  }
}
