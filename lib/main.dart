import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:himalayastoreapp/controllers/products_page_controller.dart';

import 'controllers/cart_controller.dart';
import 'routes/route_helper.dart';
import 'helpers/dependencies.dart' as dep;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductsPageController>(builder: (_){
      return GetBuilder<CartController>(builder: (_){
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          //home: SignInPage(),
          initialRoute: RouteHelper.getSplash(),
          getPages: RouteHelper.routes,
        );
      });
    });
  }
}