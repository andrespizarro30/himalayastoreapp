import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:himalayastoreapp/data/repositories/product_rating_repo.dart';
import 'package:himalayastoreapp/models/product_rating_model.dart';

import '../models/cart_model.dart';
import 'cart_controller.dart';

class ProductRatingController  extends GetxController{

  final ProductRatingRepo productRatingRepo;

  ProductRatingController({required this.productRatingRepo});

  Map<int,double> _countRatingStars = {};
  Map<int,double> get countRatingStars => _countRatingStars;

  Map<int,String> _titleStarsRating = {};
  Map<int,String> get titleStarsRating => _titleStarsRating;

  Map<int,TextEditingController> _tecComment = {};
  Map<int,TextEditingController> get tecComment => _tecComment;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  bool _isBtnVisible = false;
  bool get isBtnVisible => _isBtnVisible;

  void setCountingStars(int index,double starts, String comment){
    _countRatingStars[index] = starts;
    _titleStarsRating[index] = comment;
    update();
  }

  void initTextEditControllers(int index){
    _tecComment[index] = TextEditingController();
  }

  Future<void> registerProductRating(List<CartModel> cartModelList) async {

    var time = DateTime.parse(cartModelList[0].time!);

    int noRegsUpdated = 0;

    String deliveryId = time.millisecondsSinceEpoch.toString();

     _countRatingStars.keys.forEach((idKey) async{

      RatingProduct ratingProduct = RatingProduct();
      ratingProduct.productId = idKey;
      ratingProduct.productStars = _countRatingStars[idKey]!.round();
      ratingProduct.productComment = _tecComment[idKey]!.text;
      ratingProduct.deliveryId = deliveryId;

      var response = await productRatingRepo.registerProductRating(ratingProduct);

      String res = response.body["RegisteredRating"];

      if(res=="OK"){
        noRegsUpdated += 1;
        if(noRegsUpdated == cartModelList.length){
          Get.find<CartController>().getDeliveryByUIDandID();
          _isBtnVisible = true;
          update();
        }
      }

    });

    _isLoaded = true;
    update();


  }

  void clearData(){
    _isLoaded = false;
    _isBtnVisible = false;
    _countRatingStars.clear();
    _titleStarsRating.clear();
    _tecComment.clear();
  }

}