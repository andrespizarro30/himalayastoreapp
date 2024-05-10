import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:himalayastoreapp/controllers/product_rating_controller.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

import '../../models/cart_model.dart';
import '../../utils/app_colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/big_text.dart';
import '../../widgets/small_text.dart';


class ProductRatingScreen extends StatelessWidget {

  List<CartModel> cartModelList;

  ProductRatingScreen({
    super.key,
    required this.cartModelList
  });

  @override
  Widget build(BuildContext context) {

    SchedulerBinding.instance.addPostFrameCallback((_) async{
      cartModelList.forEach((cartData) {
        Get.find<ProductRatingController>().setCountingStars(cartData.productModel!.id!,5,"");
        Get.find<ProductRatingController>().initTextEditControllers(cartData.productModel!.id!);
      });
    });

    return GetBuilder<ProductRatingController>(builder: (controller){
      return Scaffold(
        appBar: AppBar(
          title: Text("Califícanos"),
          automaticallyImplyLeading: !controller.isBtnVisible && !controller.isLoaded,
        ),
        body: (controller.countRatingStars.isNotEmpty && !controller.isLoaded) ? ListView.builder(
            itemCount: cartModelList.length,
            itemBuilder: (_,index){
              return Padding(
                padding: EdgeInsets.only(left: Dimensions.width10,right: Dimensions.width20),
                child: Container(
                  height: Dimensions.height20 * 20,
                  width: double.maxFinite,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: Dimensions.width20 * 5,
                            height: Dimensions.height20 * 5,
                            margin: EdgeInsets.only(bottom: Dimensions.height10),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        cartModelList[index].img!
                                    )
                                ),
                                borderRadius: BorderRadius.circular(Dimensions.radius20),
                                color: Colors.white
                            ),
                          ),
                          SizedBox(width: Dimensions.width10,),
                          Expanded(
                              child: Container(
                                height: Dimensions.height20 * 10,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    BigText(text: cartModelList[index].name!,color: Colors.black,maxLines: 4,overflow: TextOverflow.ellipsis,),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        BigText(text: "Reseña del producto",color: AppColors.mainBlackColor,size: Dimensions.font16,),
                                        SizedBox(width: Dimensions.width20,),
                                        BigText(text: "Calificación",color: AppColors.mainBlackColor,size: Dimensions.font16),
                                        SizedBox(width: Dimensions.width20,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            SmoothStarRating(
                                              rating: controller.countRatingStars[cartModelList[index].id]!,
                                              allowHalfRating: true,
                                              starCount: 5,
                                              color: AppColors.himalayaBlue,
                                              borderColor: Colors.black,
                                              size: Dimensions.font26 * 1.3,
                                              onRatingChanged: (valueOfStars){

                                                String titleStarsRating = "";

                                                if(valueOfStars >= 0 && valueOfStars<2){
                                                  titleStarsRating = "Muy Mal";
                                                }else
                                                if(valueOfStars >= 2 && valueOfStars<3){
                                                  titleStarsRating = "Mal";
                                                }else
                                                if(valueOfStars >= 3 && valueOfStars<4){
                                                  titleStarsRating = "Bueno";
                                                }else
                                                if(valueOfStars >= 4 && valueOfStars<5){
                                                  titleStarsRating = "Muy Bueno";
                                                }else
                                                if(valueOfStars == 5){
                                                  titleStarsRating = "Excelente";
                                                }

                                                controller.setCountingStars(cartModelList[index].id!, valueOfStars, titleStarsRating);

                                              },
                                            ),
                                            SizedBox(
                                              height: 12.0,
                                            ),
                                            Text(
                                              controller.titleStarsRating[cartModelList[index].id]!,
                                              style: TextStyle(
                                                  fontSize: Dimensions.font16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.redAccent
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              )
                          )
                        ],
                      ),
                      AppTextField(
                        textHint: "Escribir reseña del producto",
                        icon: Icons.comment,
                        textEditingController: controller.tecComment[cartModelList[index].id]!,
                        textInputType: TextInputType.name,
                        maxLines: 3,
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      Divider(
                        thickness: Dimensions.height10/5,
                      )
                    ],
                  ),
                ),
              );
            }):
        (controller.countRatingStars.isNotEmpty && controller.isLoaded) ?
        Container(
          color: Colors.white,
          child: Center(
            child: Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/himalaya_logo.png",height: Dimensions.screenHeight / 2,width: Dimensions.screenWidth,),
                  SizedBox(height: Dimensions.height20,),
                  Text("Tu opinión es muy importante para nosotros, gracias!!!",maxLines: 2,),
                  SizedBox(height: Dimensions.height20,),
                  controller.isBtnVisible ?
                  RawMaterialButton(
                    onPressed: () {
                      controller.clearData();
                      Navigator.pop(context);
                    },
                    elevation: 2.0,
                    fillColor: Colors.white,
                    child: Icon(
                      Icons.check,
                      size: 35.0,
                    ),
                    padding: EdgeInsets.all(15.0),
                    shape: CircleBorder(),
                  ):
                  Column(
                    children: [
                      CircularProgressIndicator(color: AppColors.himalayaBlue,),
                      SizedBox(height: Dimensions.height10,),
                      Text("Espera por favor...")
                    ],
                  )
                ],
              ),
            ),
          ),
        ):
        Container(

        ),
        bottomNavigationBar: !controller.isLoaded ? GestureDetector(
          onTap: (){
            Get.find<ProductRatingController>().registerProductRating(cartModelList);
          },
          child: Container(
            height: Dimensions.height40 * 2,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(Dimensions.radius30),topRight: Radius.circular(Dimensions.radius30)),
                color: Colors.white,
                border:Border.all(
                    color: AppColors.mainBlackColor
                )
            ),
            child: Center(
              child: Text("Enviar comentarios",
                style: TextStyle(
                    color: AppColors.himalayaBlue,
                    fontSize: Dimensions.font20 * 1.1
                ),
              ),
            ),
          ),
        ):
        SizedBox(
          height: Dimensions.height10,
        )
      );
    });

  }
}
