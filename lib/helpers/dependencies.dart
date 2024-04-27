
import 'package:get/get.dart';
import 'package:himalayastoreapp/controllers/cart_controller.dart';
import 'package:himalayastoreapp/controllers/products_page_controller.dart';
import 'package:himalayastoreapp/controllers/products_pager_view_controller.dart';
import 'package:himalayastoreapp/data/repositories/cart_repo.dart';
import 'package:himalayastoreapp/data/repositories/products_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/apis/api_client.dart';
import '../utils/app_constants.dart';

Future<void> init() async{

  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(()=> sharedPreferences);

  //api client
  Get.lazyPut(()=>ApiClient(appBaseUrl: AppConstants.BASE_URL));

  //repos
  Get.lazyPut(() => ProductsRepository(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences: sharedPreferences));

  //controllers
  Get.lazyPut(() => ProductPagerViewController(productsRepository: Get.find()));
  Get.lazyPut(() => ProductsPageController(productsRepository: Get.find(),productPagerViewController: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));



}