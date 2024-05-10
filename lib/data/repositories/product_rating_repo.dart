
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/cart_model.dart';
import '../../models/product_rating_model.dart';
import '../../utils/app_constants.dart';
import '../apis/api_client.dart';

class ProductRatingRepo{

  final SharedPreferences sharedPreferences;
  final ApiClient apiClient;
  final FirebaseAuth firebaseAuth;

  ProductRatingRepo({
    required this.sharedPreferences,
    required this.apiClient,
    required this.firebaseAuth
  });

  List<CartModel> cartListHistory = [];

  Future<Response> registerProductRating(RatingProduct ratingProduct) async {

    ratingProduct.buyerUid = firebaseAuth.currentUser!.uid;
    ratingProduct.buyerName = firebaseAuth.currentUser!.displayName!.split(";")[0];

    return await apiClient.postData(AppConstants.REGISTER_PRODUCT_RATING,ratingProduct.toJson());

  }

}