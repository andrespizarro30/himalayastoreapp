import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:himalayastoreapp/utils/app_colors.dart';

import '../../controllers/pending_deliveries_controller.dart';
import '../../models/deliveries_id_model.dart';
import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';
import '../../widgets/small_text.dart';


class PendingDeliveryDetailScreen extends StatelessWidget {

  Deliveries delivery;

  PendingDeliveryDetailScreen({
    super.key,
    required this.delivery
  });

  @override
  Widget build(BuildContext context) {

    SchedulerBinding.instance.addPostFrameCallback((_) async{
      Get.find<PendingDeliviresController>().getPendingDeliveriesIdDetails(delivery);
    });

    return Scaffold(
      appBar: AppBar(
        title: Semantics(
          label: "Página de detalle del pedido",
          child: Text("Detalle del pedido")
        ),
      ),
      body: GetBuilder<PendingDeliviresController>(builder: (controller){
        return controller.pendingDeliveryDetailList.isNotEmpty ?
        ListView.builder(
            itemCount: controller.pendingDeliveryDetailList.length,
            itemBuilder: (_,index){
              return Padding(
                padding: EdgeInsets.only(left: Dimensions.width10,right: Dimensions.width10),
                child: Container(
                  height: Dimensions.height40 * 3.5,
                  width: double.maxFinite,
                  child: Row(
                    children: [
                      Container(
                        width: Dimensions.width20 * 5,
                        height: Dimensions.height20 * 5,
                        margin: EdgeInsets.only(bottom: Dimensions.height10),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    controller.pendingDeliveryDetailList[index].productImg!
                                )
                            ),
                            borderRadius: BorderRadius.circular(Dimensions.radius20),
                            color: Colors.white
                        ),
                      ),
                      SizedBox(width: Dimensions.width10,),
                      Expanded(
                          child: Container(
                            height: Dimensions.height20 * 6.5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                BigText(text: controller.pendingDeliveryDetailList[index].productName!,color: Colors.black,maxLines: 4,overflow: TextOverflow.ellipsis,),
                                SmallText(text: controller.pendingDeliveryDetailList[index].productCategory!,overflow: TextOverflow.ellipsis,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    BigText(text: "\$ ${controller.pendingDeliveryDetailList[index].productPrice!}",color: AppColors.himalayaBlue,),
                                    SizedBox(width: Dimensions.width20,),
                                    BigText(text: "x"),
                                    SizedBox(width: Dimensions.width20,),
                                    BigText(text: "${controller.pendingDeliveryDetailList[index].productQty!}",color: AppColors.mainBlackColor,),
                                  ],
                                )
                              ],
                            ),
                          )
                      )
                    ],
                  ),
                ),
              );
            }) :
        Container(
          child: Center(
            child: Column(
              children: [
                CircularProgressIndicator(color: AppColors.himalayaBlue,),
                Text("Cargando detalles del pedido, por favor espere...")
              ],
            ),
          ),
        );
      }),
      bottomNavigationBar: GetBuilder<PendingDeliviresController>(builder: (controller){

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
            child: controller.pendingDeliveryDetailList.isNotEmpty ? Row(
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
                      SizedBox(width: Dimensions.width10/2,),
                      BigText(
                          text: "\$ ${controller.totalAmount.toString()}"
                      ),
                      SizedBox(width: Dimensions.width10/2,),
                    ],
                  ),
                )
              ],
            ) : Container(),
          );
        })
    );
  }
}
