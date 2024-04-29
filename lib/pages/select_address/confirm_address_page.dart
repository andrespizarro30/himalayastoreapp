import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../base/show_custom_message.dart';
import '../../controllers/select_address_page_controller.dart';
import '../../models/address_details_model.dart';
import '../../utils/app_colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';
import '../../widgets/small_text.dart';
import '../../widgets/text_field_right_icon.dart';

class ConfirmAddressPage extends StatelessWidget {

  const ConfirmAddressPage({super.key});

  @override
  Widget build(BuildContext context) {

    TextEditingController cityCountryTextController = TextEditingController();
    TextEditingController addressTextController = TextEditingController();
    TextEditingController addressDetailTextController = TextEditingController();
    TextEditingController addressReferenceTextController = TextEditingController();

    void _saveNewAddress(SelectAddressPageController controller){

      var cityCountry = cityCountryTextController.text.trim();
      var formattedAddress = addressTextController.text.trim();
      var detailAddress = addressDetailTextController.text.trim();
      var referenceAddress = addressReferenceTextController.text.trim();
      var position = controller.currentPosition;

      if(cityCountry.isEmpty){
        showCustomSnackBar("Ingresa tu ciudad",title: "Ciudad");
      }else if(formattedAddress.isEmpty){
        showCustomSnackBar("Ingresa tu dirección",title: "Dirección");
      }else{

        AddressDetailModel addressDetailModel = AddressDetailModel(
          cityCountryAddress: cityCountry,
          formattedAddress: formattedAddress,
          detailAddress: detailAddress,
          referenceAddress: referenceAddress,
          position: "${position.latitude},${position.longitude}"
        );

        controller.saveNewAddress(addressDetailModel).then((saveResult){
          if(saveResult){
            showCustomSnackBar("Dirección guardada correctamente",title: "Validación");
          }else{
            showCustomSnackBar("Dirección no se guardó, intente de nuevo");
          }
        });

      }

    }

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios)
        ),
        title: BigText(
          text: "Confirma tu dirección",
        ),
      ),
      body: GetBuilder<SelectAddressPageController>(builder: (controller){

        cityCountryTextController.text = "${controller.placeAddress["locality"] != null ? controller.placeAddress["locality"]! : ""} - ${controller.placeAddress["country"] != null ? controller.placeAddress["country"]! : ""}";
        addressTextController.text = controller.placeAddress["formatted_address"] != null ? controller.placeAddress["formatted_address"]! : "";
        addressDetailTextController.text = controller.addressWithOutDetail ? "" : "";

        return Container(
          height: Dimensions.screenHeight,
          width: Dimensions.screenWidth,
          padding: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Dimensions.height10,),
                SmallText(text: "Ciudad, País",size: 12,),
                SizedBox(height: Dimensions.height10/2,),
                TextFieldRightIcon(
                  textEditingController: cityCountryTextController,
                  textHint: 'Ciudad, País',
                  icon: CupertinoIcons.placemark,
                  textInputType: TextInputType.text,
                  isEnabled: false,
                ),
                SizedBox(height: Dimensions.height10,),
                SmallText(text: "Dirección o lugar",size: 12,),
                SizedBox(height: Dimensions.height10/2,),
                TextFieldRightIcon(
                  textEditingController: addressTextController,
                  textHint: 'Dirección actual',
                  icon: Icons.close,
                  textInputType: TextInputType.text,
                  isEnabled: true,
                ),
                SizedBox(height: Dimensions.height10,),
                SmallText(text: "Detalle: apto / piso / casa",size: 12,),
                SizedBox(height: Dimensions.height10/2,),
                TextFieldRightIcon(
                  textEditingController: addressDetailTextController,
                  textHint: "ej. Edificio 'tal' apto 'tal'",
                  icon: Icons.close,
                  textInputType: TextInputType.text,
                  isEnabled: !controller.addressWithOutDetail,
                ),
                Row(
                  children: [
                    Checkbox(
                        value: controller.addressWithOutDetail,
                        onChanged: (bool? value){
                          controller.checkAddressWithoutDetail();
                        },
                      checkColor: Colors.white,
                      activeColor: AppColors.himalayaBlue,
                    ),
                    SmallText(text: "Dirección sin detalle",size: 12,)
                  ],
                ),
                SizedBox(height: Dimensions.height40,),
                SmallText(text: "Referencias",size: 15,),
                SizedBox(height: Dimensions.height20,),
                TextFieldRightIcon(
                  textEditingController: addressReferenceTextController,
                  textHint: "ej. casa esquinera con carpa blanca en antejardín",
                  icon: Icons.close,
                  textInputType: TextInputType.text,
                  isEnabled: !controller.addressWithOutDetail,
                  maxLines: 4,
                ),
                SizedBox(height: Dimensions.height40,),
                ElevatedButton(
                    onPressed: (){
                      _saveNewAddress(controller);
                      Navigator.pop(context,"close_address_page");
                    },
                    child: BigText(text: "Guardar",color: Colors.white,),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.himalayaBlue,
                        minimumSize: Size(Dimensions.screenWidth * 0.9, Dimensions.height40 * 1.5)
                    )
                ),
            
              ],
            ),
          ),
        );
      }),
    );

  }
}
