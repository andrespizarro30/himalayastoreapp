import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:himalayastoreapp/controllers/cart_controller.dart';
import 'package:himalayastoreapp/models/payment_models/banks_list_response_model.dart';
import 'package:himalayastoreapp/utils/app_colors.dart';
import 'package:himalayastoreapp/utils/dimensions.dart';
import 'package:himalayastoreapp/widgets/app_text_field.dart';

import '../../controllers/pse_payment_form_controller.dart';

class PSEPaymentFormScreen extends StatelessWidget {

  String token;

  PSEPaymentFormScreen({
    super.key,
    required this.token
  });

  @override
  Widget build(BuildContext context) {

    SchedulerBinding.instance.addPostFrameCallback((_) async{
      Get.find<PSEPaymentFormController>().getBankList();
    });

    return GetBuilder<PSEPaymentFormController>(builder: (controller){

      return Scaffold(
        appBar: AppBar(
          title: Text("Datos de pago"),
          automaticallyImplyLeading: false,
        ),
        body: Container(
          padding: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20),
          height: Dimensions.screenHeight,
          width: Dimensions.screenHeight,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                      backgroundColor: AppColors.himalayaGrey,
                      radius: Dimensions.height40 * 3,
                      child: ClipOval(
                          child: Image.asset(
                            "assets/images/logo_pse.png",
                            fit: BoxFit.cover,
                          )
                      )
                  ),
                ),
                Text("Seleccione el banco"),
                SizedBox(
                  height: Dimensions.height10,
                ),
                DropdownButton(
                  icon: const Icon(Icons.arrow_drop_down),
                  value: controller.currentSelectedBank,
                  items: controller.banksList.map<DropdownMenuItem<Bank>>((Bank value){
                    return DropdownMenuItem(
                        value: value,
                        child: Text(value.bankName!)
                    );
                  }).toList(),
                  onChanged: (value){
                    controller.selectBank(value!);
                  },
                  menuMaxHeight: Dimensions.screenHeight * 0.5,
                  isExpanded: true,
                ),
                SizedBox(
                  height: Dimensions.height10,
                ),
                Text("Tipo de documento"),
                SizedBox(
                  height: Dimensions.height10,
                ),
                Row(
                  children: [
                    Radio(
                        value: "CC",
                        groupValue: controller.docType,
                        onChanged: (value){
                          controller.selectDocType(value!);
                        }
                    ),
                    SizedBox(
                      width: Dimensions.width10,
                    ),
                    Text("Cédula de Ciudadanía")
                  ],
                ),
                SizedBox(
                  height: Dimensions.height10,
                ),
                Row(
                  children: [
                    Radio(
                        value: "CE",
                        groupValue: controller.docType,
                        onChanged: (value){
                          controller.selectDocType(value!);
                        }
                    ),
                    SizedBox(
                      width: Dimensions.width10,
                    ),
                    Text("Cédula de Extranjería")
                  ],
                ),
                SizedBox(
                  height: Dimensions.height10,
                ),
                Row(
                  children: [
                    Radio(
                        value: "PPN",
                        groupValue: controller.docType,
                        onChanged: (value){
                          controller.selectDocType(value!);
                        }
                    ),
                    SizedBox(
                      width: Dimensions.width10,
                    ),
                    Text("Pasaporte")
                  ],
                ),
                SizedBox(
                  height: Dimensions.height10,
                ),
                Row(
                  children: [
                    Radio(
                        value: "NIT",
                        groupValue: controller.docType,
                        onChanged: (value){
                          controller.selectDocType(value!);
                        }
                    ),
                    SizedBox(
                      width: Dimensions.width10,
                    ),
                    Text("Nit")
                  ],
                ),
                SizedBox(
                  height: Dimensions.height10,
                ),
                Text("Documento de identidad"),
                SizedBox(
                  height: Dimensions.height10,
                ),
                AppTextField(
                    textEditingController: controller.tecDocNumber,
                    textHint: "Digite su documento",
                    icon: Icons.document_scanner,
                    textInputType: TextInputType.number
                ),
                SizedBox(
                  height: Dimensions.height10,
                ),
                Text("Nombre"),
                SizedBox(
                  height: Dimensions.height10,
                ),
                AppTextField(
                    textEditingController: controller.tecName,
                    textHint: "Digite su Nombre",
                    icon: Icons.person,
                    textInputType: TextInputType.text
                ),
                SizedBox(
                  height: Dimensions.height10,
                ),
                Text("Apellido"),
                AppTextField(
                    textEditingController: controller.tecLastName,
                    textHint: "Digite su Apellido",
                    icon: Icons.account_box,
                    textInputType: TextInputType.text
                ),
                Text("E-mail"),
                AppTextField(
                    textEditingController: controller.tecEmail,
                    textHint: "Digite su e-mail",
                    icon: Icons.email,
                    textInputType: TextInputType.emailAddress
                ),
                Text("Telefono"),
                AppTextField(
                    textEditingController: controller.tecPhone,
                    textHint: "Digite su número tel.",
                    icon: Icons.email,
                    textInputType: TextInputType.phone
                ),
                SizedBox(
                  height: Dimensions.height30,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () async{
                      bool isFinishFillIn = await controller.continuePSEPaymentProcess();
                      if(isFinishFillIn){
                        controller.clearAfterFinish();
                        Navigator.pop(context,controller.paymentSendData);
                      }
                    },
                    child: Text(
                        "Continuar ->"
                    ),
                    style: ElevatedButton.styleFrom(
                        foregroundColor: AppColors.himalayaWhite,
                        backgroundColor: AppColors.himalayaBlue,
                        fixedSize: Size(Dimensions.screenWidth * 0.5, Dimensions.height30 * 2)
                    ),
                  ),
                ),
                SizedBox(
                  height: Dimensions.height30,
                ),
              ],
            ),
          ),
        ),
      );
    });

  }
}
