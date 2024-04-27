
import 'package:get/get.dart';
import 'package:himalayastoreapp/pages/home/home_page.dart';
import 'package:himalayastoreapp/pages/product/product_detail.dart';

import '../models/products_list_model.dart';
import '../pages/splash/splash_page.dart';

class RouteHelper{

  static const String splash = "/splash";
  static const String home = "/home";
  static const String productDetails = "/productDetails";


  static String getSplash()=>'$splash';
  static String getHome()=>'$home';
  static String getProductDetails(String index,String product_category)=>'$productDetails?index=$index&product_category=$product_category';


  static List<GetPage> routes =[
    GetPage(name: splash, page: ()=>SplashScreen()),
    GetPage(name: home, page: ()=>HomePage()),
    GetPage(
        name: productDetails,
        page: (){
          var index = Get.parameters['index'];
          var product_category = Get.parameters['product_category'];
          return ProductDetailScreen(index: int.parse(index!),product_category: product_category!);
        },
        transition: Transition.circularReveal
    ),
  ];
}