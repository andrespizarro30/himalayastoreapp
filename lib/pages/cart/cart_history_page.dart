import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controllers/cart_controller.dart';
import '../../models/cart_model.dart';
import '../../routes/route_helper.dart';
import '../../utils/app_colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';
import '../../widgets/small_text.dart';
import 'cart_empty_page.dart';

class CartHistoryScreen extends StatelessWidget {
  const CartHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {

    //List<int> orderTimes = Get.find<CartController>().getOrderTimes();

    //List<Map<String,List<CartModel>>> groupHistoryDataList = Get.find<CartController>().groupHistoryDataList();

    Map<String,List<CartModel>> groupHistoryDataMap = Get.find<CartController>().groupHistoryDataMap();

    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            height: Dimensions.height10*10,
            color: AppColors.himalayaBlue,
            width: double.maxFinite,
            padding: EdgeInsets.only(top: 45),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BigText(text: "Cart History", color: Colors.white,),
                GetBuilder<CartController>(builder: (controller){
                  return GestureDetector(
                    onTap: (){
                      if(controller.totalItems>=1){
                        Get.toNamed(RouteHelper.getCartPage("cart_history"));
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
                              backgroundColor: AppColors.iconColor2,
                            )
                        ) :
                        Container(),
                        controller.totalItems>=1 ?
                        Positioned(
                          right: 3,
                          top: 3,
                          child: SmallText(
                            text: Get.find<CartController>().totalItems.toString(),
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
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
                  child: MediaQuery.removePadding(
                    removeTop: true,
                    context: context,
                    child: GetBuilder<CartController>(builder: (controller){
                      return controller.getCartHistoryList().length>0 ?
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: groupHistoryDataMap.length,
                          reverse: true,
                          itemBuilder: (context,index){

                            var date = groupHistoryDataMap.keys.elementAt(index);

                            List<CartModel> cartModelList = groupHistoryDataMap.values.elementAt(index);

                            cartModelList = cartModelList.reversed.map((e) => e).toList();

                            return Container(
                              height: Dimensions.height30*4.5,
                              margin: EdgeInsets.only(left: Dimensions.width10,right: Dimensions.width10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  ((){
                                    var outputFormat = DateFormat("dd/MM/yyyy hh:mm a");
                                    var outputDate = outputFormat.format(DateTime.parse(date));
                                    return Text(outputDate);
                                  }()),
                                  Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Wrap(
                                            direction: Axis.horizontal,
                                            children: List.generate(cartModelList.length>3?3:cartModelList.length, (index) {
                                              return Row(
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(bottom: Dimensions.height20),
                                                    width:80,
                                                    height: 80,
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(Dimensions.radius15/2),
                                                        color: Colors.white38,
                                                        image: DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image: NetworkImage(
                                                              //AppConstants.BASE_URL + AppConstants.UPLOAD_URL + cartModelList[index].img!
                                                                cartModelList[index].img!
                                                            )
                                                        )
                                                    ),
                                                  ),
                                                  SizedBox(width: Dimensions.width10,)
                                                ],
                                              );
                                            })
                                        ),
                                        Container(
                                          height: Dimensions.height20 * 4,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SmallText(text: "Total"),
                                              BigText(text: "${cartModelList.length} Items",size: Dimensions.font20,color: AppColors.titleColor,),
                                              GestureDetector(
                                                onTap: (){

                                                  List<CartModel> cartModelList = groupHistoryDataMap.values.elementAt(index);

                                                  controller.setOneMoreCartItems = cartModelList;

                                                },
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(horizontal: Dimensions.width10,vertical: Dimensions.height10/2),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(Dimensions.radius15/3),
                                                    border: Border.all(width: 1,color: AppColors.himalayaBlue),
                                                  ),
                                                  child: SmallText(text: "One more",color: AppColors.himalayaBlue,),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ]
                                  )
                                ],
                              ),
                            );
                          }
                      ) :
                      NoDataPage(
                        text: "Make your firts order now !!!",
                        imgPath: "assets/image/empty_box.png",
                      );
                    }),
                  )
              )
          ),
        ],
      ),
    );
  }


}
