
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:himalayastoreapp/controllers/products_page_controller.dart';

import '../../controllers/authentication_controller.dart';
import '../../controllers/cart_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/app_colors.dart';
import '../../utils/dimensions.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();

}



class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{

  late Animation<double> animation;
  late AnimationController animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _loadResources();

    animationController = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 2)
    )..forward();

    animation = CurvedAnimation(
        parent: animationController,
        curve: Curves.linear
    );


    Timer(
        const Duration(milliseconds: 4000),
            ()=>Get.offNamed(RouteHelper.getHome())
    );

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.himalayaWhite,
      body: ScaleTransition(
        scale: animation,
        child: Center(
          child: Image.asset(
            "assets/image/himalaya_logo.png",
            width: Dimensions.splashImg,
          ),
        ),
      ),
    );

  }

  Future<void> _loadResources() async{
    //await Get.find<ProductsPageController>().getProductsCategoriesList();
    //await Get.find<CartController>().getCartData();
    //await Get.find<AuthenticationPageController>().verifyCurrentUser();
  }

}
