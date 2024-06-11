import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:himalayastoreapp/base/show_custom_message.dart';
import 'package:himalayastoreapp/controllers/products_pager_view_controller.dart';
import 'package:himalayastoreapp/widgets/product_detail_column.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:shimmer/shimmer.dart';

import '../controllers/products_page_controller.dart';
import '../models/products_list_model.dart';
import '../routes/route_helper.dart';
import '../utils/app_colors.dart';
import '../utils/dimensions.dart';
import 'big_text.dart';

class PagerViewScreen extends StatefulWidget {

  String product_category;

  PagerViewScreen({super.key,
    required this.product_category
  });

  @override
  State<PagerViewScreen> createState() => _PagerViewScreenState(product_category: this.product_category);
}

class _PagerViewScreenState extends State<PagerViewScreen> {

  String product_category;

  _PagerViewScreenState({
    required this.product_category
  });

  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = Dimensions.pageViewContainer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) async{
      pageController.addListener(() {
        setState(() {
          _currPageValue = pageController.page!;
        });
      });
      _loadResources(product_category);
    });

  }

  @override
  void dispose() {
    // TODO: implement dispose

    pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return GetBuilder<ProductPagerViewController>(builder: (controller){
      return controller.isLoaded.isNotEmpty ?
          !controller.isLoaded[product_category]! ?
          Column(
            children: [
              BigText(text: product_category,size: Dimensions.font16,color: AppColors.himalayaGrey,),
              SizedBox(
                height: Dimensions.height10,
              ),
              Container(
                color: AppColors.himalayaWhite,
                height: Dimensions.pageView * 1.1,
                child: PageView.builder(
                    controller: pageController,
                    itemCount: controller.productMap[product_category]!.length,
                    itemBuilder: (context, index){
                      return GestureDetector(
                          onTap: (){
                            if(controller.productMap[product_category]![index].product_qty_available! > 0){
                              controller.selectCurrentProduct(index);
                              Get.toNamed(RouteHelper.getProductDetails(index.toString(),product_category));
                            }else{
                              showCustomSnackBar("Producto no dispobible en el momento", title: "Sin Dispobilidad", backgroundColor: Colors.deepOrangeAccent);
                            }
                          },
                          child: Semantics(
                            label: "Click para conocer información del producto",
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: index == controller.productIndexSelected ? [
                                  BoxShadow(
                                      offset: const Offset(-5,-10),
                                      color: AppColors.himalayaBlue
                                  )
                                ]:
                                []
                              ),
                              child: _buildPageItem(index,controller.productMap[product_category]![index])
                            ),
                          )
                      );
                    }
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      DotsIndicator(
                        dotsCount: controller.productMap[product_category]!.length,
                        position: _currPageValue.round(),
                        mainAxisSize: MainAxisSize.min,
                        decorator: DotsDecorator(
                          color: Colors.grey,
                          activeColor: AppColors.himalayaBlue,
                          size: const Size.square(9.0),
                          activeSize: const Size(18.0, 9.0),
                          activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: Dimensions.height20,)
            ],
          ) :
          Padding(
            padding: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20),
            child: Column(
              children: [
                Container(
                    width: Dimensions.screenWidth,
                    height: Dimensions.pageView,
                    child: Shimmer.fromColors(
                        baseColor: Colors.grey.shade400,
                        highlightColor: Colors.white,
                        child: Container(
                            width:Dimensions.screenWidth,
                            height: Dimensions.pageView,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade400
                            )
                        )
                    )
                ),
                SizedBox(height: Dimensions.height10,)
              ],
            ),
          ) :
        Padding(
          padding: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20),
          child: Column(
            children: [
              Container(
                  width: Dimensions.screenWidth,
                  height: Dimensions.pageView,
                  child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade400,
                      highlightColor: Colors.white,
                      child: Container(
                          width:Dimensions.screenWidth,
                          height: Dimensions.pageView,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade400
                          )
                      )
                  )
              ),
              SizedBox(height: Dimensions.height10,)
            ],
          ),
        );
    });

  }

  Widget _buildPageItem(int index,ProductModel product) {

    Matrix4 matrix = new Matrix4.identity();

    if(index==_currPageValue.floor()){
      var currScale = 1 - (_currPageValue-index)*(1-_scaleFactor);
      var currTrans = _height * (1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    }else if (index == _currPageValue.floor()+1){
      var currScale = _scaleFactor+(_currPageValue-index+1)*(1-_scaleFactor);
      var currTrans = _height * (1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    }else if (index == _currPageValue.floor()-1){
      var currScale = 1 - (_currPageValue-index)*(1-_scaleFactor);
      var currTrans = _height * (1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    }else{
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, _height*(1-_scaleFactor)/2, 1);
    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          Hero(
            tag: product.id.toString(),
            child: Container(
                height: Dimensions.pageViewContainer,
                width: Dimensions.screenWidth * 0.8,
                margin: EdgeInsets.only(left: Dimensions.width10,right: Dimensions.width10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius30),
                    //color: index.isEven?Color(0xFF69c5df):Color(0xFF9294cc),
                    /*
                    image: DecorationImage(
                        image: NetworkImage(
                            product.productImage!
                        ),
                        fit: BoxFit.cover
                    )
                    */
                ),
                child: Semantics(
                  label: "Imagen de ${product.productName}",
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(Dimensions.radius30),
                    child: FadeInImage(
                        placeholder: AssetImage('assets/images/loading_gif.gif'),
                        image: Image.network(product.productImage!).image,
                        fit: BoxFit.cover
                    ),
                  ),
                ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: Dimensions.width10 / 5,
            left: Dimensions.width10 / 5,
            child: Container(
                height: Dimensions.pageViewTextContainer * 1.1,
                margin: EdgeInsets.only(left: Dimensions.width30,right: Dimensions.width30,bottom: Dimensions.height40),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius30),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: AppColors.himalayaBlue,
                          blurRadius: 5.0,
                          offset: Offset(0,5)
                      ),
                      BoxShadow(
                          color: Colors.white,
                          offset: Offset(-5,0)
                      ),
                      BoxShadow(
                          color: Colors.white,
                          offset: Offset(5,0)
                      )
                    ]
                ),
                child: Container(
                    padding: EdgeInsets.only(top: Dimensions.height10,left: Dimensions.width15,right: Dimensions.width15),
                    child: ColumnProductDetail(text: product.productName!,starts: product.productStars!,product_qty_available: product.product_qty_available!,)
                )
            )
          )
        ],
      ),
    );
  }

  Future<void> _loadResources(String product_category) async{
    await Get.find<ProductPagerViewController>().getProductsListByCategory(product_category);
  }

}
