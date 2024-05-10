import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:himalayastoreapp/controllers/pending_deliveries_controller.dart';
import 'package:himalayastoreapp/pages/deliveries/pending_deliveriy_details.dart';

import '../../utils/app_colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';
import '../../widgets/small_text.dart';
import '../cart/cart_empty_page.dart';


class PendingDeliveriesScreen extends StatelessWidget {

  const PendingDeliveriesScreen({super.key});

  @override
  Widget build(BuildContext context) {

    SchedulerBinding.instance.addPostFrameCallback((_) async{
      Get.find<PendingDeliviresController>().getPendingDeliveriesId();
    });

    return Scaffold(
      appBar: AppBar(
        title: Text("Pedidos pendientes"),
      ),
      body: GetBuilder<PendingDeliviresController>(builder: (controller){

        String statusGroup = controller.currentStatus;

        return !controller.isLoading && controller.isStatusUpdated == "NA" ? Stack(
            children:[
              SingleChildScrollView(
                  child: MediaQuery.removePadding(
                    removeTop: true,
                    context: context,
                    child: controller.pendingDeliveriesList.isNotEmpty ?
                    ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.pendingDeliveriesList.length,
                        reverse: true,
                        itemBuilder: (context,index){

                          return Container(
                            margin: EdgeInsets.only(left: Dimensions.width10,right: Dimensions.width10),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    ApplIcon(icon: CupertinoIcons.person),
                                    SizedBox(width: Dimensions.width10,),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(controller!.pendingDeliveriesList![index].deliveryDate!),
                                          SizedBox(height: Dimensions.height10,),
                                          Text(controller!.pendingDeliveriesList![index].deliveryCity!,maxLines: 2,overflow: TextOverflow.ellipsis),
                                          SizedBox(height: Dimensions.height10,),
                                          Text("${controller!.pendingDeliveriesList![index].deliveryAddress!} - ${controller!.pendingDeliveriesList![index].deliveryDetailAddress!} - ${controller!.pendingDeliveriesList![index].deliveryReferenceAddress!}",maxLines: 4,overflow: TextOverflow.ellipsis),
                                          SizedBox(height: Dimensions.height10,),
                                          Text(controller!.pendingDeliveriesList![index].deliveryUserName!,maxLines: 2,overflow: TextOverflow.ellipsis,),
                                          SizedBox(height: Dimensions.height10,),
                                          Text(controller!.pendingDeliveriesList![index].deliveryPhone!,maxLines: 1,overflow: TextOverflow.ellipsis,),
                                          SizedBox(height: Dimensions.height10,),
                                          Text(controller!.pendingDeliveriesList![index].deliveryEmail!,maxLines: 2,overflow: TextOverflow.ellipsis,),
                                          SizedBox(height: Dimensions.height10,),
                                          SizedBox(height: Dimensions.height10,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              controller!.pendingDeliveriesList![index].deliveryStatus == "EN" || controller!.pendingDeliveriesList![index].deliveryStatus == "NO" || controller!.pendingDeliveriesList![index].deliveryStatus == null || controller!.pendingDeliveriesList![index].deliveryStatus!.isEmpty ?
                                              BigText(text: "Status: Enviado",color: Colors.blueGrey,size: Dimensions.font16,) :
                                              controller!.pendingDeliveriesList![index].deliveryStatus == "PR" ?
                                              BigText(text: "Status: En proceso",color: AppColors.himalayaBlue,size: Dimensions.font16) :
                                              controller!.pendingDeliveriesList![index].deliveryStatus == "CA" ?
                                              BigText(text: "Status: En camino",color: Colors.green,size: Dimensions.font16) :
                                              BigText(text: "Status: Recibido",color: Colors.orange,size: Dimensions.font16),
                                              ElevatedButton(
                                                onPressed: (){
                                                  controller.openStatusChangeRequestContainer();
                                                  controller.assignCurrentDelivery(controller!.pendingDeliveriesList![index]);
                                                },
                                                child: Text("Actualizar Status",
                                                  style: TextStyle(
                                                      color: AppColors.himalayaWhite,
                                                      fontSize: Dimensions.font16/1.3
                                                  ),
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor: AppColors.himalayaGrey,
                                                    minimumSize: Size(Dimensions.width40/10, Dimensions.height40)
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: Dimensions.width10,),
                                    GestureDetector(
                                      onTap: (){
                                        controller.clearPendingDeliveryDetails();
                                        Get.to(() => PendingDeliveryDetailScreen(delivery: controller.pendingDeliveriesList[index],),transition: Transition.rightToLeft,duration: Duration(milliseconds: 300));
                                      },
                                      child: Icon(Icons.chevron_right)
                                    )
                                  ],
                                ),
                                Divider(height: Dimensions.height10,thickness: Dimensions.height10/4,)
                              ],
                            ),
                          );
                        }
                    ) :
                    NoDataPage(
                      text: "No hay pedidos aún !!!",
                      imgPath: "assets/images/empty_box.png",
                    )
                  )
              ),
              Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: AnimatedSize(
                    curve: Curves.linear,
                    duration: Duration(milliseconds: 300),
                    child: Container(
                      height: controller.statusChangeContainerHeight,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(Dimensions.radius30),
                            topRight: Radius.circular(Dimensions.radius30)
                        ),
                        border: Border.all(
                            color: AppColors.mainBlackColor
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.0,vertical: 18.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SmallText(text: "Cambio status de pedido",color: Colors.black,),
                            SizedBox(height: Dimensions.height10,),
                            BigText(text: "Seleccione el estado actual del pedido",size: Dimensions.font26,maxLines: 2,),
                            Divider(height: Dimensions.height20,),
                            Row(
                              children: [
                                Radio(
                                  value: "EN",
                                  groupValue: statusGroup,
                                  onChanged: (source){
                                    controller.changeCurrentStatus(source!);
                                  },
                                  activeColor: AppColors.himalayaBlue,
                                ),
                                SizedBox(
                                  width: Dimensions.width10,
                                ),
                                Text(
                                  "Enviado"
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Radio(
                                  value: "PR",
                                  groupValue: statusGroup,
                                  onChanged: (source){
                                    controller.changeCurrentStatus(source!);
                                  },
                                  activeColor: AppColors.himalayaBlue
                                ),
                                SizedBox(
                                  width: Dimensions.width10,
                                ),
                                Text(
                                    "En proceso"
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Radio(
                                  value: "CA",
                                  groupValue: statusGroup,
                                  onChanged: (source){
                                    controller.changeCurrentStatus(source!);
                                  },
                                  activeColor: AppColors.himalayaBlue
                                ),
                                SizedBox(
                                  width: Dimensions.width10,
                                ),
                                Text(
                                    "En camino"
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Radio(
                                  value: "RE",
                                  groupValue: statusGroup,
                                  onChanged: (source){
                                    controller.changeCurrentStatus(source!);
                                  },
                                  activeColor: AppColors.himalayaBlue
                                ),
                                SizedBox(
                                  width: Dimensions.width10,
                                ),
                                Text(
                                    "Recibido por usuario"
                                )
                              ],
                            ),
                            ElevatedButton(
                                onPressed: (){
                                  controller.updateDeliveryIdStatus();
                                  controller.openStatusChangeRequestContainer();
                                },
                                child: BigText(text: "Cambiar status",color: Colors.white,),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.himalayaBlue,
                                    minimumSize: Size(Dimensions.screenWidth * 0.9, Dimensions.height40 * 1.5)
                                )
                            ),
                            SizedBox(height: Dimensions.height10,),
                          ],
                        ),
                      ),
                    ),
                  )
              )
            ]
        ):
        controller.isLoading && controller.isStatusUpdated == "NA" ?
        Container(
          child: Center(
            child: Column(
              children: [
                CircularProgressIndicator(color: AppColors.himalayaBlue,),
                SizedBox(
                  height: Dimensions.height10,
                ),
                Text("Actualizando status de pedido, por favor espere...")
              ],
            ),
          ),
        ):
        !controller.isLoading && controller.isStatusUpdated != "NA" ?
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
                  controller.isStatusUpdated == "OK" ?
                  Text("Status actualizado correctamente") :
                  Text("Error al intentar actualizar, intente de nuevo"),
                  SizedBox(height: Dimensions.height20,),
                  RawMaterialButton(
                    onPressed: () {
                      controller.restartStatus();
                    },
                    elevation: 2.0,
                    fillColor: Colors.white,
                    child: Icon(
                      Icons.check,
                      size: 35.0,
                    ),
                    padding: EdgeInsets.all(15.0),
                    shape: CircleBorder(),
                  )
                ],
              ),
            ),
          ),
        ):
        Container(

        );
      })
    );

  }
}
