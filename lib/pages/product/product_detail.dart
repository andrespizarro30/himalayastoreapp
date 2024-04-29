import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:himalayastoreapp/controllers/products_page_controller.dart';
import 'package:himalayastoreapp/controllers/products_pager_view_controller.dart';
import 'package:himalayastoreapp/models/products_list_model.dart';
import 'package:himalayastoreapp/pages/product/product_more_details.dart';
import 'package:himalayastoreapp/widgets/product_detail_column.dart';

import '../../controllers/cart_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/app_colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';
import '../../widgets/expandable_text_widget.dart';
import '../../widgets/small_text.dart';

class ProductDetailScreen extends StatelessWidget {

  int index;
  String product_category;

  ProductDetailScreen({
    super.key,
    required this.index,
    required this.product_category
  });

  @override
  Widget build(BuildContext context) {

    ProductModel product = Get.find<ProductPagerViewController>().productMap[product_category]![index];
    Get.find<ProductsPageController>().initProduct(product,Get.find<CartController>());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: Dimensions.productDetailImgSize,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            product.productImage2!
                        ),
                        fit: BoxFit.cover
                    )
                ),
              )
          ),
          Positioned(
              top: Dimensions.height45,
              left: Dimensions.width20,
              right: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    child: ApplIcon(icon: Icons.clear),
                    onTap: (){
                      Navigator.pop(context);
                    },
                  ),
                  GetBuilder<ProductsPageController>(builder: (controller){
                    return GestureDetector(
                      onTap: (){
                        if(controller.totalItems>=1){
                          Get.toNamed(RouteHelper.getCartPage("product_detail"));
                        }
                      },
                      child: Stack(
                        children: [
                          ApplIcon(icon: Icons.shopping_cart_outlined),
                          controller.totalItems>=1 ?
                          Positioned(
                              right: 0,
                              top: 0,
                              child: ApplIcon(
                                icon: Icons.circle,
                                size: 20,
                                iconColor: Colors.transparent,
                                backgroundColor: AppColors.himalayaBlue,
                              )
                          ) :
                          Container(),
                          controller.totalItems>=1 ?
                          Positioned(
                            right: 3,
                            top: 3,
                            child: SmallText(
                              text: controller.totalItems.toString(),
                              color: Colors.white,
                              size: 12,
                            ),
                          ) :
                          Container()
                        ],
                      ),
                    );
                  })
                ],
              )
          ),
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: Dimensions.productDetailImgSize-Dimensions.height20,
              child: Container(
                  padding: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20,top: Dimensions.height20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(Dimensions.radius20),
                          topLeft: Radius.circular(Dimensions.radius20)
                      ),
                      color: Colors.white
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ColumnProductDetail(text: product.productName!,starts: product.productStars!,product_qty_available: product.product_qty_available!,),
                      SizedBox(height: Dimensions.height20,),
                      BigText(text: "Introduce ${product.id.toString()}"),
                      SizedBox(height: Dimensions.height20,),
                      Expanded(
                        child: SingleChildScrollView(
                            child: ExpandableText(text: product.productDescription!)
                        ),
                      )
                    ],
                  )
              )
          ),
          Positioned(
            right: Dimensions.width20,
            top: Dimensions.screenHeight/3.3,
            child: FloatingActionButton(
              backgroundColor: AppColors.himalayaBlue,
              onPressed: () {
                Get.to(() => ProductMoreDetailsScreen(product: product),transition: Transition.rightToLeft,duration: Duration(milliseconds: 500));
              },
              child: Icon(
                Icons.info_outline,
                color: AppColors.himalayaWhite,
              ),
            )
          )
        ],
      ),
      bottomNavigationBar: GetBuilder<ProductsPageController>(builder: (productContoller){
        return Container(
          height: Dimensions.bottomHeightBar,
          padding: EdgeInsets.only(top: Dimensions.height30,bottom: Dimensions.height30,left: Dimensions.width20,right: Dimensions.width20),
          decoration: BoxDecoration(
              color: AppColors.buttonBackGroundColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(Dimensions.radius20*2),
                topLeft: Radius.circular(Dimensions.radius20*2),
              )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(top: Dimensions.height20,bottom: Dimensions.height20,right: Dimensions.width20,left: Dimensions.width20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: Colors.white
                ),
                child: Row(
                  children: [
                    GestureDetector(
                        onTap:(){
                          productContoller.setQuantity(false);
                        },
                        child: Icon(Icons.remove,color: AppColors.signColor,)
                    ),
                    SizedBox(width: Dimensions.width10/2,),
                    BigText(
                      text: productContoller.inCartItems.toString()
                    ),
                    SizedBox(width: Dimensions.width10/2,),
                    GestureDetector(
                        onTap: (){
                          productContoller.setQuantity(true);
                        },
                        child: Icon(Icons.add,color: AppColors.signColor,)
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: (){
                  productContoller.addItem(product);
                },
                child: Container(
                  padding: EdgeInsets.only(top: Dimensions.height20,bottom: Dimensions.height20,right: Dimensions.width20,left: Dimensions.width20),
                  child: BigText(text: "\$ ${product.productPrice!} | Add to cart", color: Colors.white,),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: AppColors.himalayaBlue
                  ),
                ),
              )
            ],
          ),
        );
      })
    );

  }

}
