import 'package:flutter/material.dart';
import 'package:himalayastoreapp/pages/home/product_body_page.dart';

import '../../utils/app_colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';
import '../../widgets/small_text.dart';

class MainProductsScreen extends StatefulWidget {
  const MainProductsScreen({super.key});

  @override
  State<MainProductsScreen> createState() => _MainProductsScreenState();
}

class _MainProductsScreenState extends State<MainProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: RefreshIndicator(
          color: AppColors.himalayaBlue,
          onRefresh: _loadResources,
          child: Column(
            children: [
              Container(
                child: Container(
                  margin: EdgeInsets.only(top: Dimensions.height45,bottom: Dimensions.height15),
                  padding: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          BigText(
                              text: "Colombia",
                              color: AppColors.himalayaBlue
                          ),
                          Row(
                            children: [
                              SmallText(
                                text: "Pereira",
                                color: Colors.black54,
                              ),
                              Icon(Icons.arrow_drop_down_rounded)
                            ],
                          )
                        ],
                      ),
                      Center(
                        child: Container(
                          width: Dimensions.width45,
                          height: Dimensions.height45,
                          child: Icon(Icons.search,color: Colors.white,size: Dimensions.iconSize24,),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimensions.radius15),
                              color: AppColors.himalayaBlue
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                  child: SingleChildScrollView(
                    child: ProductsBodyScreen(),
                  )
              )
            ],
          ),
        )
    );
  }

  Future<void> _loadResources() async{

  }

}
