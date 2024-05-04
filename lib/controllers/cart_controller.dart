
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:himalayastoreapp/controllers/main_page_controller.dart';
import 'package:himalayastoreapp/models/user_model.dart';

import '../data/repositories/cart_repo.dart';
import '../models/cart_model.dart';
import '../models/deliveries_id_model.dart';
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

  bool _isMessageSent = false;
  bool get isMessageSent => _isMessageSent;

  Map<String,List<CartModel>> _cartItemsPerOrder = Map();
  Map<String,List<CartModel>> get cartItemsPerOrder => _cartItemsPerOrder;

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

  void addToHistoryList(){
    cartRepo.addToCartHistoryList();
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

  Future<void> registerNewDelivery()async{

    _loadingNewDelivery = true;
    update();

    storageItems = _items.entries.map((e){
      return e.value;
    }).toList();

    var time = DateTime.parse(storageItems[0].time!);

    await cartRepo.registerNewDeliveryId(time.millisecondsSinceEpoch.toString());

    storageItems.forEach((cartModel) async {
      await cartRepo.registerNewDeliveryIdDetail(time.millisecondsSinceEpoch.toString(),cartModel);
    });

    List<UsersModel> deliveiresReceivers = Get.find<ProductsPageController>().deliveriesReceiverList;

    _isMessageSent = await cartRepo.sendNotificationToDeliveryReceiver(time.millisecondsSinceEpoch.toString(),deliveiresReceivers);

    update();

  }

  void cleanAfterSent(){
    _isMessageSent=false;
    _loadingNewDelivery = false;
    update();
  }

  void refreshOne(){
    update();
  }

}