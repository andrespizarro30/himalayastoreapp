import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:himalayastoreapp/controllers/authentication_controller.dart';
import 'package:himalayastoreapp/controllers/main_page_controller.dart';
import 'package:himalayastoreapp/controllers/products_page_controller.dart';
import 'package:himalayastoreapp/controllers/products_pager_view_controller.dart';

import 'controllers/cart_controller.dart';
import 'controllers/select_address_page_controller.dart';
import 'routes/route_helper.dart';
import 'helpers/dependencies.dart' as dep;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductsPageController>(builder: (_){
      return GetBuilder<ProductPagerViewController>(builder: (_){
        return GetBuilder<AuthenticationPageController>(builder: (_){
          return GetBuilder<CartController>(builder: (_){
            return GetBuilder<MainPageController>(builder: (_){
              return GetBuilder<SelectAddressPageController>(builder: (_){
                return GetMaterialApp(
                  debugShowCheckedModeBanner: false,
                  //home: SignInPage(),
                  initialRoute: RouteHelper.getSplash(),
                  getPages: RouteHelper.routes,
                );
              });
            });
          });
        });
      });
    });
  }
}