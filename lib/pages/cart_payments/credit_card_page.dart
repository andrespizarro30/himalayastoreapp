import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:himalayastoreapp/controllers/credit_card_page_controller.dart';
import 'package:himalayastoreapp/utils/app_colors.dart';
import 'package:himalayastoreapp/utils/dimensions.dart';
import 'package:himalayastoreapp/widgets/small_text.dart';
import 'package:u_credit_card/u_credit_card.dart';

import '../../base/credit_card_input_formatter.dart';
import '../../base/show_custom_message.dart';

class CreditCardScreen extends StatelessWidget {
  const CreditCardScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return GetBuilder<CreditCardController>(builder: (controller){

      SchedulerBinding.instance.addPostFrameCallback((_) async{
        if(controller.isCreditCardSaved){
          controller.clearCreditCardSaved();
          showCustomSnackBar("Tarjeta Salvada Correctamente",backgroundColor: Colors.green,title: "Muy bien...");
          Navigator.pop(context);
        }
      });

      return Scaffold(
          appBar: AppBar(title: const Text("Agregar tarjeta")),
          body: Container(
            height: Dimensions.screenHeight,
            width: Dimensions.screenWidth,
            child: Padding(
              padding: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CreditCardUi(
                      width: Dimensions.screenWidth*0.9,
                      cardHolderFullName: "${controller.tecCardHolderName.text} ${controller.tecCardHolderLastName.text}",
                      cardNumber: controller.tecCardNumber.text,
                      validThru: controller.tecValidThru.text,
                      topLeftColor: AppColors.himalayaBlue,
                      doesSupportNfc: true,
                      placeNfcIconAtTheEnd: true,
                      cardType: CardType.credit,
                      cardProviderLogo: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: Dimensions.height20 * 1.5,
                        backgroundImage: AssetImage(
                            "assets/images/himalaya_logo.png"
                        ),
                      ),
                      cardProviderLogoPosition: CardProviderLogoPosition.left,
                      enableFlipping: true,
                      cvvNumber: controller.tecCVVNumber.text,
                    ),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    SmallText(
                      text: "Número de la tarjeta",
                      color: Colors.black,
                      size: Dimensions.font16,
                    ),
                    TextField(
                      controller: controller.tecCardNumber,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        controller.onChangeTECCardNumber(controller.tecCardNumber.text);
                      },
                      decoration: InputDecoration(
                          hintText: "XXXX-XXXX-XXXX-XXXX"
                      ),
                      inputFormatters: [
                        MaskedCardNumberInputFormatter(
                          mask: 'xxxx-xxxx-xxxx-xxxx',
                          separator: '-',
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Dimensions.height30,
                    ),
                    SmallText(
                      text: "Nombre en la tarjeta",
                      color: Colors.black,
                      size: Dimensions.font16,
                    ),
                    TextField(
                      controller: controller.tecCardHolderName,
                      keyboardType: TextInputType.text,
                      onChanged: (value) {
                        controller.onChangeTECCardHolderName(value);
                      },
                      decoration: InputDecoration(
                          hintText: "Nombre(s)"
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    SmallText(
                      text: "Apellido en la tarjeta",
                      color: Colors.black,
                      size: Dimensions.font16,
                    ),
                    TextField(
                      controller: controller.tecCardHolderLastName,
                      keyboardType: TextInputType.text,
                      onChanged: (value) {
                        controller.onChangeTECCardHolderLastName(value);
                      },
                      decoration: InputDecoration(
                          hintText: "Apellidos(s)"
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    SmallText(
                      text: "Fecha de expiración",
                      color: Colors.black,
                      size: Dimensions.font16,
                    ),
                    TextField(
                      controller: controller.tecValidThru,
                      keyboardType: TextInputType.datetime,
                      onChanged: (value) {
                        if(value.length == 2){
                          controller.tecValidThru.text += "/";
                        }
                        if(value.length<=5){
                          controller.onChangeTECValidThru(controller.tecValidThru.text);
                        }
                      },
                      decoration: InputDecoration(
                        hintText: "MM/YYYY"
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    SmallText(
                      text: "CVC/CVV",
                      color: Colors.black,
                      size: Dimensions.font16,
                    ),
                    TextField(
                      controller: controller.tecCVVNumber,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        controller.onChangeTECCVVNumber(value);
                      },
                      decoration: InputDecoration(
                          hintText: "XXX"
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.height40,
                    ),
                    GestureDetector(
                      onTap: (){
                        controller.saveCreditCardInfo();
                      },
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.only(left: Dimensions.width40 * 3,right: Dimensions.width40 * 3,top: Dimensions.height20,bottom: Dimensions.height20),
                          child: Text(
                            "Guardar",
                            style: TextStyle(
                              color: Colors.white
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.himalayaBlue,
                            borderRadius: BorderRadius.all(Radius.elliptical(Dimensions.radius30, Dimensions.radius30))
                          ),
                        )
                      ),
                    )
                  ],
                ),
              ),
            )
          )
      );
    });

  }
}
