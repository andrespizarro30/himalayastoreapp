import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:himalayastoreapp/controllers/cart_controller.dart';
import 'package:himalayastoreapp/utils/app_constants.dart';
import 'package:himalayastoreapp/widgets/app_icon.dart';
import 'package:himalayastoreapp/widgets/small_text.dart';

import '../../controllers/credit_card_page_controller.dart';
import '../../controllers/main_page_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';
import '../cart_payments/payment_methods_page.dart';

import 'package:u_credit_card/src/utils/credit_card_helper.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {

    SchedulerBinding.instance.addPostFrameCallback((_) async{
      Get.find<CreditCardController>().getCurrentSelectedPaymentMethod();
    });

    return GetBuilder<CreditCardController>(builder: (controller){
      return Scaffold(
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(left: Dimensions.height10/3,right: Dimensions.height10/3),
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                      expandedHeight: Dimensions.height40 * 2.5,
                      flexibleSpace: FlexibleSpaceBar(
                        centerTitle: false,
                        title: Align(
                            alignment: Alignment.bottomLeft,
                            child: BigText(text: "Haz tu pedido",color: Colors.black,size: Dimensions.font20 * 1.1,)
                        ),
                      ),
                      pinned: true,
                      floating: false,
                      automaticallyImplyLeading: false,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero
                      )
                  ),
                  SliverList(
                      delegate: SliverChildListDelegate(
                          [
                            SizedBox(height: Dimensions.height10,),
                            Padding(
                              padding: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SmallText(text:"Dirección de entrega",color: AppColors.himalayaBlue,),
                                  SizedBox(height: Dimensions.height10/5,),
                                  BigText(text: Get.find<MainPageController>().currentAddressDetailModel.formattedAddress!,maxLines: 3,),
                                  SizedBox(height: Dimensions.height20,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SmallText(text:"Método de pago",color: AppColors.himalayaBlue,size: Dimensions.font16*1.1,),
                                      GestureDetector(
                                        onTap: (){
                                          Get.to(() => PaymentMethodsScreen(),transition: Transition.rightToLeft,duration: Duration(milliseconds: 300));
                                        },
                                        child: SmallText(text:"Cambiar",color: Colors.green,size: Dimensions.font16*1.1,)
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: Dimensions.height20,),
                                  Container(
                                    height: Dimensions.screenHeight/15,
                                    width: Dimensions.screenWidth*0.9,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            CircleAvatar(
                                                backgroundColor: AppColors.himalayaGrey,
                                                radius: Dimensions.height20 * 1.25,
                                                child: ClipOval(
                                                    child: Image.asset(
                                                      controller.currentSelectedPaymentMethod.cardNumber != AppConstants.PSE_PAYMENT_METHOD && controller.currentSelectedPaymentMethod.cardNumber!.isNotEmpty ?
                                                      CreditCardHelper.getCardLogoFromCardNumber(cardNumber: controller.currentSelectedPaymentMethod.cardNumber!):
                                                      "assets/images/logo_pse.png",
                                                      fit: BoxFit.cover,
                                                    )
                                                )
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            BigText(text: controller.currentSelectedPaymentMethod.cardNumber != AppConstants.PSE_PAYMENT_METHOD && controller.currentSelectedPaymentMethod.cardNumber!.isNotEmpty ?
                                            "Credito * ${controller.currentSelectedPaymentMethod.cardNumber!.substring(controller.currentSelectedPaymentMethod.cardNumber!.length - 4,controller.currentSelectedPaymentMethod.cardNumber!.length)}":
                                            AppConstants.PSE_PAYMENT_METHOD),
                                            SmallText(text: controller.currentSelectedPaymentMethod.cardNumber != AppConstants.PSE_PAYMENT_METHOD && controller.currentSelectedPaymentMethod.cardNumber!.isNotEmpty ?
                                            "${controller.currentSelectedPaymentMethod.cardHolderName!} ${controller.currentSelectedPaymentMethod.cardHolderLastName ?? ""}" :
                                            "e-Payco")
                                          ],
                                        ),
                                        controller.currentSelectedPaymentMethod.cardNumber != AppConstants.PSE_PAYMENT_METHOD && controller.currentSelectedPaymentMethod.cardNumber!.isNotEmpty ?
                                        Text("Número de cuotas",style: TextStyle(fontSize: Dimensions.font16/1.3),):
                                        SizedBox(),
                                        controller.currentSelectedPaymentMethod.cardNumber != AppConstants.PSE_PAYMENT_METHOD && controller.currentSelectedPaymentMethod.cardNumber!.isNotEmpty ?
                                        Row(
                                          children: [
                                            Text(controller.duesNumber.toString(),style: TextStyle(fontSize: Dimensions.font16/1.3),),
                                            GestureDetector(
                                              onTap: (){
                                                controller.openDuesSelectContainer();
                                              },
                                              child: Icon(Icons.arrow_drop_down)
                                            )
                                          ],
                                        ):
                                        SizedBox()
                                      ],
                                    )
                                  ),
                                  SizedBox(height: Dimensions.height20,),
                                  Container(
                                    height: Dimensions.screenHeight/3,
                                    width: Dimensions.screenWidth * 0.9,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(Dimensions.radius30)),
                                      color: Colors.grey.shade100,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(Dimensions.width20),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Costo de productos"),
                                              Text(Get.find<CartController>().totalAmount.toString())
                                            ],
                                          ),
                                          SizedBox(height: Dimensions.height10,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Tarifa de servicio"),
                                              Text("0")
                                            ],
                                          ),
                                          SizedBox(height: Dimensions.height10,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Costo de envío"),
                                              Text("15000")
                                            ],
                                          ),
                                          SizedBox(height: Dimensions.height10,),

                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ]
                      )
                  )
                ],
              ),
            ),
            Positioned(
                left: Dimensions.width10,
                top: Dimensions.height40,
                child: GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: ApplIcon(icon: Icons.arrow_back_ios,iconColor: Colors.black,backgroundColor: Colors.grey.shade200,size: Dimensions.iconSize24 * 1.5,)
                )
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(Dimensions.radius30),topRight: Radius.circular(Dimensions.radius30))
                ),
                height: controller.duesSelectContainerHeight,
                child: SingleChildScrollView(
                  child: Column(
                    children: List.generate(24, (index){
                      return GestureDetector(
                        onTap: (){
                          controller.selectDuesNumber(index+1);
                          controller.openDuesSelectContainer();
                        },
                        child: Container(
                          height: Dimensions.height40 * 1.4,
                          width: Dimensions.screenWidth,
                          child: Center(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: Dimensions.height10,
                                  ),
                                  Text((index+1).toString()),
                                  SizedBox(
                                    height: Dimensions.height10,
                                  ),
                                  Divider(
                                    height: Dimensions.height10,
                                    thickness: Dimensions.height10/5,
                                  )
                                ],
                              )
                          )
                        ),
                      );
                    }),
                  ),
                ),
              )
            )
          ],
        ),
        bottomNavigationBar: Container(
          height: Dimensions.screenHeight/8,
          decoration: BoxDecoration(
            border: Border.all(),
            color: Colors.white
          ),
          child: Padding(
            padding: EdgeInsets.only(top: Dimensions.height20, left: Dimensions.width20,bottom: Dimensions.height10,right: Dimensions.width20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    SmallText(text: "Total a pagar",color: AppColors.mainBlackColor,),
                    SizedBox(height: Dimensions.height10,),
                    BigText(
                        text: "\$ ${(Get.find<CartController>().totalAmount+15000).toString()}"
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () async{
                    Navigator.pop(context);
                    await Get.find<CartController>().getPaymentToken(controller);
                    //await Get.find<CartController>().registerNewDelivery();
                    //Get.find<CartController>().addToHistoryList();
                  },
                  child: Container(
                    padding: EdgeInsets.only(top: Dimensions.height10,bottom: Dimensions.height10,right: Dimensions.width40,left: Dimensions.width40),
                    child: BigText(text: "Hacer pedido", color: Colors.white,),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius20),
                        color: AppColors.himalayaBlue
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });

  }
}
