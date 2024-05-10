import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:himalayastoreapp/controllers/credit_card_page_controller.dart';
import 'package:himalayastoreapp/models/card_info_model.dart';
import 'package:himalayastoreapp/pages/cart_payments/credit_card_page.dart';
import 'package:himalayastoreapp/utils/app_constants.dart';
import 'package:himalayastoreapp/widgets/big_text.dart';

import '../../utils/app_colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/small_text.dart';

import 'package:u_credit_card/src/utils/credit_card_helper.dart';

class PaymentMethodsScreen extends StatelessWidget {
  const PaymentMethodsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    SchedulerBinding.instance.addPostFrameCallback((_) async{
      Get.find<CreditCardController>().getSavedCreditCards();
    });

    return Scaffold(
      appBar: AppBar(
        title: Text("Tus métodos de pago"),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: Dimensions.height20,
            ),
            SmallText(text: "Total a pagar",size: Dimensions.font26,),
            SizedBox(
                height: Dimensions.height10
            ),
            SmallText(text: "\$ 20000",size: Dimensions.font26*1.2,color: Colors.black,),
            SizedBox(
                height: Dimensions.height40
            ),
            SmallText(text: "Disponibles",size: Dimensions.font20,color: Colors.black),
            SizedBox(
                height: Dimensions.height20
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Metodos de pago"),
                GestureDetector(
                  onTap: (){
                    Get.to(() => CreditCardScreen(),transition: Transition.rightToLeft,duration: Duration(milliseconds: 300));
                  },
                  child: Container(
                    padding: EdgeInsets.only(top: Dimensions.height10/2,bottom: Dimensions.height10/2,right: Dimensions.width20,left: Dimensions.width20),
                    child: Text(
                      "+ Agregar",
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.all(Radius.circular(Dimensions.radius30)),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: Dimensions.height30,
            ),
            Padding(
              padding: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(Dimensions.radius30)),
                  boxShadow: [
                    BoxShadow(
                        color: AppColors.himalayaGrey,
                        blurRadius: 20.0,
                        offset: Offset(0,-5)
                    ),
                    BoxShadow(
                        color: Colors.white,
                        offset: Offset(-5,0)
                    ),
                    BoxShadow(
                        color: Colors.white,
                        offset: Offset(0,-5)
                    )
                  ]
                ),
                height: Dimensions.screenHeight * 0.5,
                width: Dimensions.screenWidth * 0.9,
                child: GetBuilder<CreditCardController>(builder: (controller){
                  return SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(Dimensions.height20),
                      child: Column(
                          children: List.generate(controller.cardInfoList.length + 1, (index){
                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        CircleAvatar(
                                            backgroundColor: AppColors.himalayaGrey,
                                            radius: Dimensions.height20 * 1.25,
                                            child: ClipOval(
                                                child: Image.asset(
                                                  controller.cardInfoList.length > index ?
                                                  CreditCardHelper.getCardLogoFromCardNumber(cardNumber: controller.cardInfoList[index].cardNumber!):
                                                  "assets/images/logo_pse.png",
                                                  fit: BoxFit.cover,
                                                )
                                            )
                                        ),
                                        SizedBox(
                                          height: Dimensions.height20,
                                        ),
                                        controller.cardInfoList.length > index ?
                                        GestureDetector(
                                          onTap: (){
                                            controller.deleteCreditCard(controller.cardInfoList[index]);
                                          },
                                          child: Icon(
                                              Icons.delete_forever
                                          ),
                                        ):
                                        SizedBox()
                                      ],
                                    ),
                                    SizedBox(
                                      width: Dimensions.width20,
                                    ),
                                    Column(
                                      children: [
                                        BigText(text: controller.cardInfoList.length > index ?
                                        "Credito * ${controller.cardInfoList[index].cardNumber!.substring(controller.cardInfoList[index].cardNumber!.length - 4,controller.cardInfoList[index].cardNumber!.length)}":
                                        AppConstants.PSE_PAYMENT_METHOD),
                                        SmallText(text: controller.cardInfoList.length > index ?
                                        "${controller.cardInfoList![index].cardHolderName!} ${controller.cardInfoList![index].cardHolderLastName ?? ""}" :
                                        "e-Payco")
                                      ],
                                    ),
                                    Radio(
                                      value: controller.cardInfoList.length > index ? controller.cardInfoList[index].cardNumber! : AppConstants.PSE_PAYMENT_METHOD,
                                      groupValue: controller.selectedPayMethod,
                                      onChanged: (value){
                                        controller.selectPaymentMethod(value!);
                                        Navigator.pop(context);
                                      },
                                      activeColor: AppColors.himalayaBlue,
                                    )
                                  ],
                                ),
                                Divider(thickness: Dimensions.height10/6,height: Dimensions.height30*2,),
                              ],
                            );
                          })
                      ),
                    ),
                  );
                }),
              ),
            )
          ],
        ),
      )
    );
  }
}
