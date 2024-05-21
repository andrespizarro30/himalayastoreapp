
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:himalayastoreapp/base/show_custom_message.dart';
import 'package:himalayastoreapp/controllers/authentication_controller.dart';
import 'package:himalayastoreapp/controllers/credit_card_page_controller.dart';
import 'package:himalayastoreapp/controllers/main_page_controller.dart';
import 'package:himalayastoreapp/models/payment_models/pse_error_response_model.dart';
import 'package:himalayastoreapp/models/payment_models/pse_payment_response_model.dart';
import 'package:himalayastoreapp/models/payment_models/pse_payment_transaction_confirm_model.dart';
import 'package:himalayastoreapp/models/user_model.dart';
import 'package:himalayastoreapp/utils/app_constants.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/repositories/cart_repo.dart';
import '../models/cart_model.dart';
import '../models/deliveries_id_model.dart';
import '../models/payment_models/credit_card_payment_response_model.dart';
import '../models/payment_models/credit_card_payment_send_model.dart';
import '../models/payment_models/pse_payment_send_model.dart';
import '../models/products_list_model.dart';
import '../utils/app_colors.dart';
import 'products_page_controller.dart';

class CartController extends GetxController{

  final CartRepo cartRepo;

  CartController({required this.cartRepo});

  Map<int, CartModel> _items = {};

  Map<int,CartModel> get items => _items;

  List<CartModel> storageItems = [];

  bool _loadingNewDelivery = false;
  bool get loadingNewDelivery => _loadingNewDelivery;

  bool _doingPayment = false;
  bool get doingPayment => _doingPayment;

  bool _isMessageSent = false;
  bool get isMessageSent => _isMessageSent;

  Map<String,List<CartModel>> _cartItemsPerOrder = Map();
  Map<String,List<CartModel>> get cartItemsPerOrder => _cartItemsPerOrder;

  CreditCardPaymentResponse _creditCardPaymentResponse = CreditCardPaymentResponse();
  CreditCardPaymentResponse get creditCardPaymentResponse => _creditCardPaymentResponse;

  PSEPaymentResponse _psePaymentResponse = PSEPaymentResponse();
  PSEPaymentResponse get psePaymentResponse => _psePaymentResponse;

  PSETransactionConfirm _pseTransactionConfirm = PSETransactionConfirm();
  PSETransactionConfirm get pseTransactionConfirm => _pseTransactionConfirm;

  PSEErrorTransaction _pseErrorTransaction = PSEErrorTransaction();
  PSEErrorTransaction get pseErrorTransaction => _pseErrorTransaction;

  late Timer _timer;
  Timer get timer => _timer;

  void addItem(ProductModel product, int quantity){

    var totalQuantity = 0 ;

    if(_items.containsKey(product.id!)){
      _items.update(product.id!, (value){

        totalQuantity = value.quantity!+quantity;

        return CartModel(
            id : value.id!,
            name : value.name!,
            description : value.description!,
            price : value.price!,
            img : value.img!,
            quantity : value.quantity!+quantity,
            isExist : true,
            time : DateTime.now().toString(),
            status: "EN",
            productModel: product
        );
      });

      if(totalQuantity<=0){
        _items.remove(product.id!);
      }

    }else{
      if(quantity>0){
        _items.putIfAbsent(product.id!, () {
          return CartModel(
              id : product.id!,
              name : product.productName!,
              description : product.productDescription!,
              price : product.productPrice!,
              img : product.productImage!,
              quantity : quantity,
              isExist : true,
              time : DateTime.now().toString(),
              status: "EN",
              productModel: product
          );
        });
      }else{
        Get.snackbar(
            "Conteo de items",
            "Debe agregar al menos un item",
            backgroundColor: AppColors.himalayaBlue,
            colorText: Colors.white,
            duration: Duration(seconds: 2)
        );
      }
    }

    cartRepo.addToCartList(getItems);

    update();

  }

  existInCart(ProductModel productsModel){
    if(_items.containsKey(productsModel.id)){
      return true;
    }
    return false;
  }

  int getQuantity(ProductModel productsModel){
    var quantity = 0;
    if(_items.containsKey(productsModel.id)){
      _items.forEach((key, value) {
        if(productsModel.id == key){
          quantity = value.quantity!;
        }
      });
      //quantity = _items[productsModel.id]!.quantity!;
    }
    return quantity;
  }

  int get totalItems{

    var totalQuantity = 0;

    _items.forEach((key, value) {
      totalQuantity += value.quantity!;
    });

    return totalQuantity;
  }

  List<CartModel> get getItems{
    return _items.entries.map((e){
      return e.value;
    }).toList();
  }

  int get totalAmount{

    var total = 0;

    _items.forEach((key, value) {
      total += value.quantity! * value.price!;
    });

    return total;
  }

  List<CartModel> getCartData(){

    setCart = cartRepo.getCartList();

    return storageItems;

  }

  set setCart(List<CartModel> items){

    storageItems =  items;

    for(int i = 0; i < storageItems.length ; i++){

      _items.putIfAbsent(storageItems[i].productModel!.id!, () => storageItems[i]);

    }

  }

  set setOneMoreCartItems(List<CartModel> oneMoreItems){

    Map<int,CartModel> moreOrderItems =Map();

    oneMoreItems.forEach((element) {
      element.status = "EN";
      moreOrderItems.putIfAbsent(element.id!, () => element);
    });

    _items = {};

    _items = moreOrderItems;

    cartRepo.addToCartList(oneMoreItems);

    update();
  }

  void addToHistoryList(String payReference){
    cartRepo.addToCartHistoryList(payReference);
    clear();
  }

  void clear(){
    _items = {};
    update();
  }

  List<CartModel> getCartHistoryList(){
    return cartRepo.getCartHistoryList();
  }

  List<int> getOrderTimes(){
    return cartRepo.cartOrderTimeToList();
  }

  Map<String,List<CartModel>> groupHistoryDataMap(){

    _cartItemsPerOrder = cartRepo.groupHistoryDataMap();

    return _cartItemsPerOrder;
  }

  List<Map<String,List<CartModel>>> groupHistoryDataList(){
    return cartRepo.groupHistoryDataList();
  }

  void clearCartHistory(){
    cartRepo.clearCartHistory();
    update();
  }

  Future<void> getDeliveryByUIDandID() async {

    _cartItemsPerOrder.keys.forEach((deliveryId) async{

      Response response = await cartRepo.getDeliveryByUIDandID(deliveryId);

      if(response.statusCode == 200){

        var delivery = Deliveries.fromJson(response.body[0]);

        cartRepo.modifyCartHistoryListStatus(delivery);

        update();

      }else{

      }

    });

  }

  Future<String> getPaymentToken() async{

    _doingPayment = true;
    update();

    return await cartRepo.getPaymentToken();

  }

  Future<void> creditCardPayment(CreditCardController creditCardController,String totalCost) async{

    CreditCardPaymentSend creditCardPaymentSend = CreditCardPaymentSend();
    creditCardPaymentSend.value = "5000";//CAMBIAR AQUI POR totalCost
    creditCardPaymentSend.docType = "CC";
    creditCardPaymentSend.docNumber = "111111";
    creditCardPaymentSend.name = creditCardController.currentSelectedPaymentMethod.cardHolderName;
    creditCardPaymentSend.lastName = creditCardController.currentSelectedPaymentMethod.cardHolderLastName;
    creditCardPaymentSend.email = Get.find<AuthenticationPageController>().signUpBody.email;
    creditCardPaymentSend.cellPhone = Get.find<AuthenticationPageController>().signUpBody.phone;
    creditCardPaymentSend.phone = "000000";
    creditCardPaymentSend.cardNumber = creditCardController.currentSelectedPaymentMethod.cardNumber;
    creditCardPaymentSend.cardExpYear = creditCardController.currentSelectedPaymentMethod.expYear;
    creditCardPaymentSend.cardExpMonth = creditCardController.currentSelectedPaymentMethod.expMonth;
    creditCardPaymentSend.cardCvc = creditCardController.currentSelectedPaymentMethod.cvv;
    creditCardPaymentSend.dues = creditCardController.duesNumber.toString();

    Response response = await cartRepo.creditCardPayment(creditCardPaymentSend);

    _doingPayment = false;
    update();

    if(response.body["success"]){
      _creditCardPaymentResponse = CreditCardPaymentResponse.fromJson(response.body);
      if(creditCardPaymentResponse.data!.transaction!.data!.estado == "Aceptada"){
        await registerNewDelivery(_pseTransactionConfirm.data!.refPayco!.toString());
        addToHistoryList(_pseTransactionConfirm.data!.refPayco!.toString());
        Get.find<CreditCardController>().deletePromoCodeUsed();
        showCustomSnackBar("Transacción Aceptada");
      }else{
        _isMessageSent = true;
        showCustomSnackBar("Transacción rechazada, intente de nuevo");
        update();
      }
    }else{
      _isMessageSent = true;
      showCustomSnackBar("Transacción rechazada, intente de nuevo");
      update();
    }
  }

  Future<void> psePayment(PSEPaymentSend paymentSendData) async{

    Response response = await cartRepo.psePayment(paymentSendData);

    if(response.body["success"]){
      _psePaymentResponse = PSEPaymentResponse.fromJson(response.body);
      if(psePaymentResponse.data!.estado == "Pendiente"){

        final Uri url = Uri.parse(psePaymentResponse.data!.urlbanco!);

        bool transactionAccepted = false;

        await launchUrl(url, mode: LaunchMode.externalApplication);

        _timer = Timer.periodic(Duration(milliseconds: 15000), (Timer t) async{

          Response response = await cartRepo.pseTransactionConfirm(psePaymentResponse.data!.transactionID!);
          if(response.body["success"]){
            _pseTransactionConfirm = PSETransactionConfirm.fromJson(response.body);
            if(_pseTransactionConfirm.data!.estado == "Aceptada" && !transactionAccepted){
              transactionAccepted = true;
              _doingPayment = false;
              update();
              await registerNewDelivery(_pseTransactionConfirm.data!.refPayco!.toString());
              addToHistoryList(_pseTransactionConfirm.data!.refPayco!.toString());
              showCustomSnackBar("Transacción Aceptada");
              _timer.cancel();
              Get.find<CreditCardController>().deletePromoCodeUsed();
            }else
            if(_pseTransactionConfirm.data!.estado == "Rechazada"){
              _isMessageSent = true;
              _doingPayment = false;
              showCustomSnackBar("Transacción rechazada, intente de nuevo");
              _timer.cancel();
              update();
            }else{
              print(_pseTransactionConfirm.data!.estado);
            }
          }else{
            _isMessageSent = true;
            _doingPayment = false;
            showCustomSnackBar("Transacción rechazada, intente de nuevo");
            _timer.cancel();
            update();
          }

        });


      }else{
        _isMessageSent = true;
        _doingPayment = false;
        showCustomSnackBar("Transacción rechazada, intente de nuevo");
        update();
      }
    }else{
      _pseErrorTransaction = PSEErrorTransaction.fromJson(response.body);
      _isMessageSent = true;
      _doingPayment = false;
      showCustomSnackBar("Transacción rechazada, intente de nuevo");
      update();
    }
  }

  Future<void> registerNewDelivery(String payReference)async{

    _loadingNewDelivery = true;
    update();

    storageItems = _items.entries.map((e){
      return e.value;
    }).toList();

    var time = DateTime.parse(storageItems[0].time!);

    await cartRepo.registerNewDeliveryId(time.millisecondsSinceEpoch.toString(),payReference);

    storageItems.forEach((cartModel) async {
      await cartRepo.registerNewDeliveryIdDetail(time.millisecondsSinceEpoch.toString(),cartModel);
    });

    List<UsersModel> deliveiresReceivers = Get.find<ProductsPageController>().deliveriesReceiverList;

    _isMessageSent = await cartRepo.sendNotificationToDeliveryReceiver(time.millisecondsSinceEpoch.toString(),deliveiresReceivers);

    update();

  }

  void cleanAfterSent(){
    _creditCardPaymentResponse = CreditCardPaymentResponse();
    _psePaymentResponse = PSEPaymentResponse();
    _isMessageSent=false;
    _doingPayment=false;
    _loadingNewDelivery = false;
    update();
  }

  void refreshOne(){
    update();
  }

}