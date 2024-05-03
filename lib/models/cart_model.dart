

import 'package:himalayastoreapp/models/products_list_model.dart';

class CartModel {
  int? id;
  String? name;
  String? description;
  int? price;
  String? img;

  int? quantity;
  bool? isExist;
  String? time;

  String? status;

  ProductModel? productModel;

  CartModel(
      {this.id,
        this.name,
        this.description,
        this.price,
        this.img,
        this.quantity,
        this.isExist,
        this.time,
        this.status = "",
        this.productModel
      });

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    img = json['img'];
    quantity = json['quantity'];
    isExist = json['isExist'];
    time = json['time'];
    status = json['status'];
    productModel = ProductModel.fromJson(json['product']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['img'] = this.img;
    data['quantity'] = this.quantity;
    data['isExist'] = this.isExist;
    data['time'] = this.time;
    data['status'] = this.status;
    data['product'] = this.productModel!.toJson();
    return data;
  }
}