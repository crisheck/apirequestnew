class CarModel {
  String? model;
  var price;
  int? id;
  CarModel({this.model, this.price, this.id});
  CarModel.fromJson(Map<String, dynamic> json) {
    model = json['model'];
    price = json['price'];
    id = json['id'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['model'] = this.model;
    data['price'] = this.price;
    return data;
  }
}
