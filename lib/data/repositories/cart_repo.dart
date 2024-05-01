import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:himalayastoreapp/controllers/main_page_controller.dart';
import 'package:himalayastoreapp/models/deliveries_id_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/cart_model.dart';

import 'package:collection/collection.dart';

import '../../models/deliveries_id_details_model.dart';
import '../../utils/app_constants.dart';
import '../apis/api_client.dart';

class CartRepo extends GetxService{

  final SharedPreferences sharedPreferences;
  final ApiClient apiClient;
  final FirebaseAuth firebaseAuth;

  CartRepo({
    required this.sharedPreferences,
    required this.apiClient,
    required this.firebaseAuth
  });

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

  Future<Response> registerNewDeliveryId(String deliveryId)async{

    var time = DateTime.now();

    Deliveries deliveries = Deliveries();
    deliveries.deliveryUserName = firebaseAuth.currentUser!.displayName!.split(";")[0];
    deliveries.deliveryUID = firebaseAuth.currentUser!.uid!;
    deliveries.deliveryAddress = Get.find<MainPageController>().currentAddressDetailModel.formattedAddress;
    deliveries.deliveryDetailAddress = Get.find<MainPageController>().currentAddressDetailModel.detailAddress;
    deliveries.deliveryReferenceAddress = Get.find<MainPageController>().currentAddressDetailModel.referenceAddress;
    deliveries.deliveryCity = Get.find<MainPageController>().currentAddressDetailModel.cityCountryAddress;
    deliveries.deliveryPosition = Get.find<MainPageController>().currentAddressDetailModel.position;
    deliveries.deliveryDate = "${time.year}-${time.month}-${time.day} ${time.hour}:${time.minute}:${time.second}";
    deliveries.deliveryToken = sharedPreferences.getString(AppConstants.FIRESTORE_TOKENS);
    deliveries.deliveryId = deliveryId;
    deliveries.deliverySent = "NO";

    return await apiClient.postData(AppConstants.REGISTER_NEW_DELIVERY_ID, deliveries.toJson());

  }

  Future<Response> registerNewDeliveryIdDetail(String deliveryId,CartModel cartModel)async{

    DeliveriesDetail deliveriesDetail = DeliveriesDetail();
    deliveriesDetail.id = cartModel.id;
    deliveriesDetail.deliveryId = deliveryId;
    deliveriesDetail.deliveryUID = firebaseAuth.currentUser!.uid!;
    deliveriesDetail.productCategory = cartModel.productModel!.productCategory!;
    deliveriesDetail.productName = cartModel.name;
    deliveriesDetail.productPrice = cartModel.price;
    deliveriesDetail.productQty = cartModel.quantity;
    deliveriesDetail.productSent = "NO";

    return await apiClient.postData(AppConstants.REGISTER_NEW_DELIVERY_ID_DETAIL, deliveriesDetail.toJson());

  }



}