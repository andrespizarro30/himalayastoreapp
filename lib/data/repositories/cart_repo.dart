import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/cart_model.dart';

import 'package:collection/collection.dart';

import '../../utils/app_constants.dart';

class CartRepo extends GetxService{

  final SharedPreferences sharedPreferences;

  CartRepo({required this.sharedPreferences});

  List<String> cart = [];

  List<String> cartHistory = [];

  void addToCartList(List<CartModel> carList){

    var time = DateTime.now().toString();
    cart = [];


    carList.forEach((element) {
      element.time = time;
      cart.add(json.encode(element.toJson()));
    });


    //carList.forEach((element) => cart.add(json.encode(element.toJson())));
    
    sharedPreferences.setStringList(AppConstants.CART_LIST, cart);

  }

  List<CartModel> getCartList(){

    List<CartModel> cartList = [];

    if(sharedPreferences.containsKey(AppConstants.CART_LIST)){

      List<String> carts = [];

      carts = sharedPreferences.getStringList(AppConstants.CART_LIST)!;
      cart = carts;

      /*
      carts.forEach((element) {
        cartList.add(CartModel.fromJson(json.decode(element)));
      });
      */

      carts.forEach((element) => cartList.add(CartModel.fromJson(json.decode(element))));

    }

    return cartList;

  }

  List<CartModel> getCartHistoryList(){

    List<CartModel> cartListHistory = [];

    if(sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)){

      cartHistory = [];

      cartHistory = sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;

      cartHistory.forEach((element) {
        cartListHistory.add(CartModel.fromJson(json.decode(element)));
      });

    }

    return cartListHistory;

  }

  void addToCartHistoryList(){

    if(sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)){
      cartHistory = sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }

    cart.forEach((element) {
      cartHistory.add(element);
    });

    removeCart();
    
    sharedPreferences.setStringList(AppConstants.CART_HISTORY_LIST, cartHistory);

    print("The lenght of history list is ${getCartHistoryList().length}");

    for(int i=0; i<getCartHistoryList().length;i++){
      print("The time for order ${i.toString()} is ${getCartHistoryList()[i].time.toString()}");
    }



  }

  void removeCart(){
    cart = [];
    sharedPreferences.remove(AppConstants.CART_LIST);
  }

  Map<String,List<CartModel>> groupHistoryDataMap(){

    Map<String,List<CartModel>> cartItemsPerOrder = Map();

    var data = getCartHistoryList();

    cartItemsPerOrder = data.groupListsBy((element) => element.time!);

    return cartItemsPerOrder;

  }

  List<Map<String,List<CartModel>>> groupHistoryDataList(){

    List<Map<String,List<CartModel>>> listOfMaps = [];

    Map<String,List<CartModel>> cartItemsPerOrder = Map();

    var data = getCartHistoryList();

    cartItemsPerOrder = data.groupListsBy((element) => element.time!);

    cartItemsPerOrder.entries.forEach((element) {
      Map<String,List<CartModel>> listDateOrders = Map();
      listDateOrders.assign(element.key, element.value);
      listOfMaps.add(listDateOrders);
    });

    return listOfMaps;

  }

  Map<String,int> orderTimes(){

    Map<String,int> cartItemsPerOrder = Map();

    getCartHistoryList().forEach((element) {
      if(cartItemsPerOrder.containsKey(element.time.toString())){
        cartItemsPerOrder.update(element.time.toString(), (value) => ++value);
      }else{
        cartItemsPerOrder.putIfAbsent(element.time.toString(), () => 1);
      }
    });

    return cartItemsPerOrder;

  }

  List<int> cartOrderTimeToList(){
    return orderTimes().entries.map((e) => e.value).toList();
  }

  void printHistoryList(){

    var a = sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST);

    var b = a.toString();

    print("SHARED PREFERENCES " + b);
  }

  void clearCartHistory(){
    removeCart();
    sharedPreferences.remove(AppConstants.CART_HISTORY_LIST);
  }

}