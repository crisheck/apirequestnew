import 'CarModel.dart';

class CarListModel {
  List<CarModel>? carList;

  CarListModel({this.carList});

  CarListModel.fromJson(List<dynamic>? parsedJson) {
    carList = [];
    parsedJson!.forEach((v) {
      carList!.add(CarModel.fromJson(v));
    });
  }
}
