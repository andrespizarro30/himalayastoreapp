
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/repositories/cart_repo.dart';
import '../models/cart_model.dart';
import '../models/products_list_model.dart';
import '../utils/app_colors.dart';

class CartController extends GetxController{

  final CartRepo cartRepo;

  CartController({required this.cartRepo});

  Map<int, CartModel> _items = {};

  Map<int,CartModel> get items => _items;

  List<CartModel> storageItems = [];

  bool _loadingNewDelivery = false;
  bool get loadingNewDelivery => _loadingNewDelivery;

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
    return cartRepo.groupHistoryDataMap();
  }

  List<Map<String,List<CartModel>>> groupHistoryDataList(){
    return cartRepo.groupHistoryDataList();
  }

  void clearCartHistory(){
    cartRepo.clearCartHistory();
    update();
  }

  Future<void> registerNewDelivery()async{

    _loadingNewDelivery = true;
    update();

    var time = DateTime.now();

    await cartRepo.registerNewDeliveryId(time.millisecondsSinceEpoch.toString());

    storageItems = _items.entries.map((e){
      return e.value;
    }).toList();

    storageItems.forEach((cartModel) async {
      await cartRepo.registerNewDeliveryIdDetail(time.millisecondsSinceEpoch.toString(),cartModel);
    });

    _loadingNewDelivery = false;
    update();

  }

}