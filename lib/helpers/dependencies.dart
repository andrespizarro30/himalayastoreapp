
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:himalayastoreapp/controllers/cart_controller.dart';
import 'package:himalayastoreapp/controllers/main_page_controller.dart';
import 'package:himalayastoreapp/controllers/pending_deliveries_controller.dart';
import 'package:himalayastoreapp/controllers/products_page_controller.dart';
import 'package:himalayastoreapp/controllers/products_pager_view_controller.dart';
import 'package:himalayastoreapp/controllers/select_address_page_controller.dart';
import 'package:himalayastoreapp/data/repositories/cart_repo.dart';
import 'package:himalayastoreapp/data/repositories/google_map_repository.dart';
import 'package:himalayastoreapp/data/repositories/main_page_repository.dart';
import 'package:himalayastoreapp/data/repositories/pending_deliveries_repo.dart';
import 'package:himalayastoreapp/data/repositories/products_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/authentication_controller.dart';
import '../data/apis/api_client.dart';
import '../data/apis/google_maps_api_client.dart';
import '../data/repositories/authentication_repository.dart';
import '../utils/app_constants.dart';

Future<void> init() async{

  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(()=> sharedPreferences);

  //Firebase instances
  final firebaseAuth = FirebaseAuth.instance;
  Get.lazyPut(()=> firebaseAuth);

  final firebaseStore = FirebaseFirestore.instance;
  Get.lazyPut(()=> firebaseStore);

  final firebaseMessaging = FirebaseMessaging.instance;
  Get.lazyPut(()=> firebaseMessaging);

  final firebaseStorage = FirebaseStorage.instance;
  Get.lazyPut(()=> firebaseStorage);

  //api client
  Get.lazyPut(()=>ApiClient(appBaseUrl: AppConstants.BASE_URL));
  Get.lazyPut(()=>GoogleMapsApiClient(appBaseUrl: AppConstants.GOOGLE_MAPS_API_BASE_URL));

  //repos
  Get.lazyPut(() => ProductsRepository(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences: sharedPreferences, apiClient: Get.find(),firebaseAuth: Get.find()));
  Get.lazyPut(() => AuthenticationRepo(firebaseAuth: Get.find(),apiClient: Get.find(),sharedPreferences: Get.find()));
  Get.lazyPut(() => MainPageRepo(sharedPreferences: Get.find()));
  Get.lazyPut(() => GoogleMapRepo(googleMapsApiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => PendingDeliveriesRepo(sharedPreferences: Get.find(),apiClient: Get.find()));


  //controllers
  Get.lazyPut(() => ProductPagerViewController(productsRepository: Get.find()));
  Get.lazyPut(() => ProductsPageController(productsRepository: Get.find(),productPagerViewController: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
  Get.lazyPut(() => AuthenticationPageController(authRepo: Get.find(),firebaseAuth: Get.find(),firebaseStorage: Get.find()));
  Get.lazyPut(() => MainPageController(mainPageRepo: Get.find()));
  Get.lazyPut(() => SelectAddressPageController(googleMapRepo: Get.find()));
  Get.lazyPut(() => PendingDeliviresController(pendingDeliveriesRepo: Get.find()));


}