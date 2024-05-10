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
import '../../widgets/chat_bubble.dart';
import '../../widgets/expandable_text_widget.dart';
import '../../widgets/small_text.dart';
import '../cart/cart_empty_page.dart';

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
      body: GetBuilder<ProductsPageController>(builder: (controller){
        return Stack(
          children: [
            Positioned(
                left: 0,
                right: 0,
                child: Hero(
                  tag: product.id.toString(),
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
                    GestureDetector(
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
                                backgroundColor: Colors.redAccent,
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
                    )
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
                        ColumnProductDetail(text: product.productName!,starts: product.productStars!,product_qty_available: product.product_qty_available!,seeComment: true,productId: product.id!,),
                        SizedBox(height: Dimensions.height20,),
                        BigText(text: "Producto ${product.id.toString()}"),
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
            ),
            Positioned(
              right: 0,
              left: 0,
              top: 0,
              bottom: 0,
              child: controller.isOpenCommentsContainer ?
              GestureDetector(
                onTap: (){
                  controller.openCommentContainer();
                },
                child: Container(
                  height: Dimensions.screenHeight,
                  width: double.infinity,
                  color: Colors.black45,
                ),
              ):Container()
            ),
            Positioned(
                right: Dimensions.screenWidth/3,
                left: Dimensions.screenWidth/3,
                top: Dimensions.screenHeight * 0.2,
                child: controller.isOpenCommentsContainer ?
                GestureDetector(
                  onTap: (){
                    controller.openCommentContainer();
                  },
                  child: FloatingActionButton(
                    onPressed: () {
                      controller.openCommentContainer();
                    },
                    child: Icon(Icons.close,color: AppColors.himalayaWhite,),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    backgroundColor: Colors.black45,
                  ),
                ):SizedBox(width: 0,height: 0,)
            ),
            Positioned(
              right: 0,
              left: 0,
              bottom: 0,
              child: GestureDetector(
                  onVerticalDragUpdate: (details){
                    //controller.closeDraggingUpdateAddressRequestContainer(details.delta.dy);
                  },
                  onVerticalDragEnd: (details){
                    //controller.closeDraggingEndAddressRequestContainer();
                  },
                  child: AnimatedContainer(
                    height: controller.commentContainerHeight,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(Dimensions.radius30),
                            topRight: Radius.circular(Dimensions.radius30)
                        )
                    ),
                    duration: Duration(milliseconds: 300),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.0,vertical: 18.0),
                      child: !controller.loadingComments ?
                        controller.ratingsProductList.isNotEmpty ?
                        SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.only(left: Dimensions.width10/5,right: Dimensions.width10/5),
                            child: Column(
                              children: List.generate(controller.ratingsProductList.length, (index){
                                String uid = controller.ratingsProductList[index].buyerUid!;
                                String photoLink = "https://firebasestorage.googleapis.com/v0/b/himalayastoreapp.appspot.com/o/MyPhotoProfile%2F$uid%2FMy_Profile_Image.jpg?alt=media&token=8fde7696-8dc2-4ba5-a806-395b03687002";
                                return Column(
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          CircleAvatar(
                                            backgroundColor: Colors.white,
                                            radius: Dimensions.height20 * 1.25,
                                            backgroundImage: NetworkImage(
                                                photoLink
                                            ),
                                          ),
                                          SizedBox(width: Dimensions.width20,),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(controller.ratingsProductList[index].buyerName!),
                                                ChatBubble(message: controller.ratingsProductList[index].productComment!,bubbleColor: AppColors.himalayaBlue,),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: Dimensions.height20,)
                                  ],
                                );;
                              }),
                            ),
                          ),
                        ):
                        Container(
                          width: double.maxFinite,
                          height: Dimensions.screenHeight * 0.7,
                          child: NoDataPage(
                            text: "Sin comentarios aún, obtén este producto y se el primero !!!",
                            imgPath: "assets/images/empty_bubble.png",
                          ),
                        ):
                        Container(
                          width: double.maxFinite,
                          height: Dimensions.screenHeight * 0.7,
                          child: Center(
                            child: CircularProgressIndicator(color: AppColors.himalayaBlue,),
                          ),
                        ),
                    ),
                  )
              )
            )
          ],
        );
      }),
      bottomNavigationBar: GetBuilder<ProductsPageController>(builder: (productContoller){
        return Container(
          height: !productContoller.isOpenCommentsContainer ? Dimensions.bottomHeightBar : 0,
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
                  Get.find<CartController>().refreshOne();
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
