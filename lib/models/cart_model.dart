import 'package:food_delivery/models/products_model.dart';

class CartModel {
  int? id;
  String? name;
  int? price;
  String? img;
  String? time;
  int? quantity;
  bool? isExist;
  ProductModel? product;

  CartModel({
    this.id,
    this.name,
    this.price,
    this.quantity,
    this.isExist,
    this.time,
    this.img,
    this.product,
  });
  // Convert String to object
  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    img = json['img'];
    time = json['time'];
    quantity = json['quantity'];
    isExist = json['isExist'];
    product = ProductModel.fromJson(json['product']);
  }

  // Convert object to String[Map]
Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['id'] = id;
  data['name'] = name;
  data['price'] = price;
  data['img'] = img;
  data['time'] = time;
  data['quantity'] = quantity;
  data['isExist'] = isExist;
  data['product'] = product?.toJson();
  return data;
  /*
  //or
  return {
   data['id'] : id;
  data['name'] : name;
  data['price'] : price;
  data['img'] :img;
  data['time'] : time;
  data['quantity'] : quantity;
  data['isExist'] : isExist;
  }
   */
}
}
