
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:himalayastoreapp/controllers/products_pager_view_controller.dart';

import '../data/repositories/products_repository.dart';
import '../models/cart_model.dart';
import '../models/products_category_list_model.dart';
import '../models/products_list_model.dart';
import '../utils/app_colors.dart';
import 'cart_controller.dart';

class ProductsPageController extends GetxController{

  final ProductsRepository productsRepository;
  final ProductPagerViewController productPagerViewController;

  ProductsPageController({
    required this.productsRepository,
    required this.productPagerViewController
  });

  List<ProductsCategories> _productsCategoriesList=[];
  List<ProductsCategories> get productsCategoriesList => _productsCategoriesList;

  late CartController _cartController;

  bool _isLoaded = false;
  bool get isLoaded =>_isLoaded;

  int _quantity = 0;
  int get quantity => _quantity;

  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;

  Future<void> getProductsCategoriesList()async{
    Response response = await productsRepository.getProductsCategoriesList();
    if(response.statusCode == 200){
      _productsCategoriesList=[];
      _productsCategoriesList.addAll(ProductsCategoriesListModel.fromJson(response.body).productsCategoriesList);

      //productPagerViewController.clearIsLoadedMap(_productsCategoriesList);

      _isLoaded = true;
      update();
    }else{

    }
  }

  void setQuantity(bool isIncrement){
    if(isIncrement){
      _quantity = _quantity + 1;
    }else{
      _quantity = _quantity - 1;
    }

    _quantity = checkQuantity(_quantity);

    update();
  }

  int checkQuantity(int quantity){
    if((_inCartItems+quantity)<0){
      Get.snackbar(
          "Item Count",
          "Item number can't be less than zero",
          backgroundColor: AppColors.himalayaBlue,
          colorText: Colors.white,
          duration: Duration(seconds: 1)
      );
      if(_inCartItems>0){
        _quantity = -_inCartItems;
        return _quantity;
      }
      return 0;
    }else
    if((_inCartItems+quantity)>20){
      Get.snackbar(
          "Item Count",
          "Item number can't be greater than 20",
          backgroundColor: AppColors.himalayaBlue,
          colorText: Colors.white,
          duration: Duration(seconds: 1)
      );
      return 20;
    }else{
      return quantity;
    }
  }

  void initProduct(ProductModel productModel,CartController cartController){
    _quantity = 0;
    _inCartItems = 0;
    _cartController = cartController;

    var exist = false;
    exist = _cartController.existInCart(productModel);

    print("Exists ${exist.toString()}");

    if(exist){
      _inCartItems = _cartController.getQuantity(productModel);
    }

    print("The quantity of product ${productModel.id} in the cart is ${_inCartItems}");

    //update();

  }

  void addItem(ProductModel product){

    _cartController.addItem(product, _quantity);

    _quantity = 0;
    _inCartItems = _cartController.getQuantity(product);

    _cartController.items.forEach((key, value) {
      print("The id is ${key.toString()} and value is ${value.quantity.toString()}");
    });

    update();

  }

  int get totalItems{
    return _cartController.totalItems;
  }

  List<CartModel> get getItems{
    return _cartController.getItems;
  }


}