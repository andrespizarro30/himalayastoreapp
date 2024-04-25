import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:himalayastoreapp/widgets/product_detail_column.dart';
import 'package:dots_indicator/dots_indicator.dart';

import '../routes/route_helper.dart';
import '../utils/app_colors.dart';
import '../utils/dimensions.dart';
import 'big_text.dart';

class PagerViewScreen extends StatefulWidget {

  String category;
  String productName;

  PagerViewScreen({super.key,
    required this.category,
    required this.productName
  });

  @override
  State<PagerViewScreen> createState() => _PagerViewScreenState(category: this.category,productName: this.productName);
}

class _PagerViewScreenState extends State<PagerViewScreen> {

  String category;
  String productName;

  _PagerViewScreenState({
      required this.category,
      required this.productName
  });

  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = Dimensions.pageViewContainer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
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

    return Column(
      children: [
        BigText(text: category,size: Dimensions.font16,color: AppColors.himalayaGrey,),
        SizedBox(
          height: Dimensions.height10,
        ),
        Container(
          color: AppColors.himalayaWhite,
          height: Dimensions.pageView,
          child: PageView.builder(
              controller: pageController,
              itemCount: 6,
              itemBuilder: (context, index){
                return GestureDetector(
                    onTap: (){
                      Get.toNamed(RouteHelper.getProductDetails(index,"home"));
                    },
                    child: _buildPageItem(index)
                );
              }
          ),
        ),
        DotsIndicator(
          dotsCount: 6,
          position: _currPageValue.round(),
          decorator: DotsDecorator(
            color: Colors.grey,
            activeColor: AppColors.himalayaBlue,
            size: const Size.square(9.0),
            activeSize: const Size(18.0, 9.0),
            activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          ),
        ),
        SizedBox(height: Dimensions.height20,)
      ],
    );

  }

  Widget _buildPageItem(int index) {

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
          Container(
              height: Dimensions.pageViewContainer,
              margin: EdgeInsets.only(left: Dimensions.width10,right: Dimensions.width10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  //color: index.isEven?Color(0xFF69c5df):Color(0xFF9294cc),
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://firebasestorage.googleapis.com/v0/b/kapitaltaskmanager.appspot.com/o/delivery_app%2Fimagen1.jpg?alt=media&token=09662d0d-5c80-4711-96b8-6887400f3569"
                      ),
                      fit: BoxFit.cover
                  )
              )
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageViewTextContainer,
              margin: EdgeInsets.only(left: Dimensions.width30,right: Dimensions.width30,bottom: Dimensions.height30),
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
                  child: ColumnProductDetail(text: productName,)
              ),
            ),
          )
        ],
      ),
    );
  }
}
