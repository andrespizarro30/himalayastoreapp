
import 'package:get/get.dart';
import 'package:himalayastoreapp/pages/home/home_page.dart';
import 'package:himalayastoreapp/pages/product/product_detail.dart';

import '../pages/splash/splash_page.dart';

class RouteHelper{

  static const String splash = "/splash";
  static const String home = "/home";
  static const String productDetails = "/productDetails";


  static String getSplash()=>'$splash';
  static String getHome()=>'$home';
  static String getProductDetails(int pageId,String page)=>'$productDetails?pageId=$pageId&page=$page';


  static List<GetPage> routes =[
    GetPage(name: splash, page: ()=>SplashScreen()),
    GetPage(name: home, page: ()=>HomePage()),
    GetPage(
        name: productDetails,
        page: (){
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];
          return ProductDetailScreen(pageId: int.parse(pageId!),page: page!,);
        },
        transition: Transition.circularReveal
    ),
  ];
}