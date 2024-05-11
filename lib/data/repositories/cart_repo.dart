import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:himalayastoreapp/controllers/authentication_controller.dart';
import 'package:himalayastoreapp/controllers/main_page_controller.dart';
import 'package:himalayastoreapp/data/apis/payment_api.dart';
import 'package:himalayastoreapp/models/deliveries_id_model.dart';
import 'package:himalayastoreapp/models/payment_models/pse_payment_send_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/cart_model.dart';

import 'package:collection/collection.dart';

import '../../models/deliveries_id_details_model.dart';
import '../../models/payment_models/credit_card_payment_send_model.dart';
import '../../models/user_model.dart';
import '../../utils/app_constants.dart';
import '../apis/api_client.dart';

import 'package:http/http.dart' as http;

class CartRepo extends GetxService{

  final SharedPreferences sharedPreferences;
  final ApiClient apiClient;
  final PaymentApi paymentApi;
  final FirebaseAuth firebaseAuth;

  CartRepo({
    required this.sharedPreferences,
    required this.apiClient,
    required this.paymentApi,
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

  void addToCartHistoryList(String payReference){

    if(sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)){
      cartHistory = sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }

    cart.forEach((element) {
      CartModel elementCartModel = CartModel.fromJson(json.decode(element));
      elementCartModel.payReference = payReference;
      cartHistory.add(json.encode(elementCartModel.toJson()));
    });

    removeCart();
    
    sharedPreferences.setStringList(AppConstants.CART_HISTORY_LIST, cartHistory);

    print("The lenght of history list is ${getCartHistoryList().length}");

    for(int i=0; i<getCartHistoryList().length;i++){
      print("The time for order ${i.toString()} is ${getCartHistoryList()[i].time.toString()}");
    }



  }

  void modifyCartHistoryListStatus(Deliveries delivery){

    if(sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)){
      cartHistory = sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }

    if(cartHistory.isNotEmpty){

      List<CartModel> carList = [];

      cartHistory.forEach((cartModelString) {

        var carModel = CartModel.fromJson(json.decode(cartModelString));

        var time = DateTime.parse(carModel.time!);

        var cartModelId = time.millisecondsSinceEpoch.toString();

        if(delivery.deliveryId == cartModelId){

          carModel.status = delivery.deliveryStatus;
          carModel.payReference = delivery.payReference;

        }

        carList.add(carModel);

      });

      carList.forEach((element) {
        cart.add(json.encode(element.toJson()));
      });

      cartHistory.clear();
      cartHistory = [];

      cart.forEach((element) {
        cartHistory.add(element);
      });

      clearCartHistory();

      sharedPreferences.setStringList(AppConstants.CART_HISTORY_LIST, cartHistory);

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

  Future<Response> getDeliveryByUIDandID(String deliveryId) async {

    var time = DateTime.parse(deliveryId);

    deliveryId = time.millisecondsSinceEpoch.toString();

    Map<String,String> data = {};

    data['DeliveryId'] = deliveryId;
    data['DeliveryUID'] = firebaseAuth.currentUser!.uid!;

    return await apiClient.getDataWithQuery(AppConstants.DELIVERY_BY_UID_AND_ID,data);

  }

  Future<String> getPaymentToken() async{

    Response response = await paymentApi.getToken(AppConstants.PAYMENT_LOGIN);

    String token = response.body["token"];

    paymentApi.updateHeader(token);

    return token;

  }

  Future<Response> creditCardPayment(CreditCardPaymentSend creditCardPaymentSend) async{

    return await paymentApi.postData(AppConstants.CREDIT_CARD_PAYMENT,creditCardPaymentSend.toJson());

  }

  Future<Response> psePayment(PSEPaymentSend psePaymentSend) async{

    return await paymentApi.postData(AppConstants.PSE_PAYMENT,psePaymentSend.toJson());

  }

  Future<Response> pseTransactionConfirm(String transactionID) async{

    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['transactionID'] = int.parse(transactionID);

    return await paymentApi.postData(AppConstants.TRANSACTION_CONFIRM,data);

  }

  Future<Response> registerNewDeliveryId(String deliveryId,String payReference)async{

    var time = DateTime.now();

    Deliveries deliveries = Deliveries();
    deliveries.deliveryUserName = firebaseAuth.currentUser!.displayName!.split(";")[0];
    deliveries.deliveryUID = firebaseAuth.currentUser!.uid!;
    deliveries.deliveryAddress = Get.find<MainPageController>().currentAddressDetailModel.formattedAddress;
    deliveries.deliveryDetailAddress = Get.find<MainPageController>().currentAddressDetailModel.detailAddress;
    deliveries.deliveryReferenceAddress = Get.find<MainPageController>().currentAddressDetailModel.referenceAddress;
    deliveries.deliveryCity = Get.find<MainPageController>().currentAddressDetailModel.cityCountryAddress;
    deliveries.deliveryPhone = Get.find<AuthenticationPageController>().signUpBody.phone;
    deliveries.deliveryEmail = Get.find<AuthenticationPageController>().signUpBody.email;
    deliveries.deliveryPosition = Get.find<MainPageController>().currentAddressDetailModel.position;
    deliveries.deliveryDate = "${time.year}-${time.month}-${time.day} ${time.hour}:${time.minute}:${time.second}";
    deliveries.deliveryToken = sharedPreferences.getString(AppConstants.FIRESTORE_TOKENS);
    deliveries.deliveryId = deliveryId;
    deliveries.deliveryStatus = "EN";
    deliveries.payReference = payReference;

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
    deliveriesDetail.status = "EN";
    deliveriesDetail.productImg = cartModel.img;

    return await apiClient.postData(AppConstants.REGISTER_NEW_DELIVERY_ID_DETAIL, deliveriesDetail.toJson());

  }

  Future<bool> sendNotificationToDeliveryReceiver(String deliveryId,List<UsersModel> deliveiresReceivers) async{

    final headers = {
      'content-type': 'application/json',
      'Authorization': 'key=${AppConstants.FIREBASE_MESSAGING_AUTH_TOKEN}'
    };

    Map<String,dynamic> body = {
      "notification":{
        "body": "Nuevo pedido recibido",
        "title": "Tienda Himalaya"
      },
      "priority": "high",
      "data": {
        "DeliveryUID": deliveryId,
        "DeliveryId": firebaseAuth.currentUser!.uid!,
        "DeliveryUserName": firebaseAuth.currentUser!.displayName!.split(";")[0],
        "DeliveryCity": Get.find<MainPageController>().currentAddressDetailModel.cityCountryAddress
      },
      "to": deliveiresReceivers[0].userToken
    };

    var bodyEncoded = json.encode(body);

    String url="https://fcm.googleapis.com/fcm/send";

    final response = await http.post(Uri.parse(url),headers: headers,body: bodyEncoded,encoding: Encoding.getByName('utf-8'));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }

  }



}