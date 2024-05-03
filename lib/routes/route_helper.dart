
import 'package:get/get.dart';
import 'package:himalayastoreapp/pages/authenticate/sign_in_page.dart';
import 'package:himalayastoreapp/pages/cart/cart_page.dart';
import 'package:himalayastoreapp/pages/deliveries/pending_deliveries.dart';
import 'package:himalayastoreapp/pages/home/home_page.dart';
import 'package:himalayastoreapp/pages/product/product_detail.dart';

import '../models/products_list_model.dart';
import '../pages/select_address/confirm_address_page.dart';
import '../pages/select_address/search_address_page.dart';
import '../pages/select_address/select_address_page.dart';
import '../pages/splash/splash_page.dart';

class RouteHelper{

  static const String splash = "/splash";
  static const String home = "/home";
  static const String productDetails = "/productDetails";
  static const String cartPage = "/cartPage";
  static const String signIn = "/signIn";
  static const String searchAddressPage = "/searchSelectConfirm";
  static const String confirmAddressPage = "/addressSelectConfirm";
  static const String selectAddressPage = "/addressSelect";
  static const String pendingDeliveries = "/pendingDeliveries";

  static String getSplash()=>'$splash';
  static String getHome()=>'$home';
  static String getProductDetails(String index,String product_category)=>'$productDetails?index=$index&product_category=$product_category';
  static String getCartPage(String page)=>'$cartPage?page=$page';
  static String getSignIn()=>'$signIn';
  static String getSearchAddress()=>'$searchAddressPage';
  static String getConfirmAddress()=>'$confirmAddressPage';
  static String getSelectAddress()=>'$selectAddressPage';
  static String getPendingDeliveries()=>'$pendingDeliveries';


  static List<GetPage> routes =[
    GetPage(name: splash, page: ()=>SplashScreen()),
    GetPage(name: signIn, page: ()=>SignInScreen(),transition: Transition.fade),
    GetPage(name: home, page: ()=>HomePage()),
    GetPage(name: searchAddressPage, page: ()=>SearchAddressPage()),
    GetPage(name: confirmAddressPage, page: ()=>ConfirmAddressPage()),
    GetPage(name: selectAddressPage, page: ()=>SelectAddressPage()),
    GetPage(
        name: productDetails,
        page: (){
          var index = Get.parameters['index'];
          var product_category = Get.parameters['product_category'];
          return ProductDetailScreen(index: int.parse(index!),product_category: product_category!);
        },
        transition: Transition.circularReveal
    ),
    GetPage(
        name: cartPage,
        page: (){
          var page = Get.parameters['page'];
          return CartScreen(page: page!,);
        },
        transition: Transition.cupertino
    ),
    GetPage(name: pendingDeliveries, page: ()=>PendingDeliveriesScreen()),
  ];
}