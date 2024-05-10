
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../base/show_custom_message.dart';
import '../../controllers/authentication_controller.dart';
import '../../models/sign_up_model.dart';
import '../../utils/app_colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/big_text.dart';
import '../../widgets/small_text.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {

    TextEditingController emailTextEditController = TextEditingController();
    TextEditingController passwordTextEditController = TextEditingController();
    TextEditingController nameTextEditController = TextEditingController();
    TextEditingController phoneTextEditController = TextEditingController();
    bool isTechnician = false;

    var signUpImages = [
      "f.png",
      "g.png"
    ];

    void _registration(AuthenticationPageController authController){

      var email = emailTextEditController.text.trim();
      var pwd = passwordTextEditController.text.trim();
      var name = nameTextEditController.text.trim();
      var phone = phoneTextEditController.text.trim();
      var userType = isTechnician ? "Tecnico" : "Usuario";

      if(name.isEmpty){
        showCustomSnackBar("Ingresa tu nombre",title: "Nombre");
      }else if(phone.isEmpty){
        showCustomSnackBar("Ingresa tu número celular",title: "Celular");
      }else if(email.isEmpty){
        showCustomSnackBar("Ingresa tu e'mail",title: "Dirección e-mail");
      }else if(!GetUtils.isEmail(email)){
        showCustomSnackBar("Ingresa un e-mail válido",title: "Dirección e-mail");
      }else if(pwd.isEmpty){
        showCustomSnackBar("Ingresa tu passwrod",title: "Password");
      }else if(pwd.length<6){
        showCustomSnackBar("Password debe contener al menos 6 caracteres",title: "Password");
      }else{

        SignUpBody signUpBody = SignUpBody(name: name, phone: phone, email: email, password: pwd, userType: userType);

        authController.registration(signUpBody);

      }

    }


    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthenticationPageController>(builder: (controller){
        return !controller.isLoading ? SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: Dimensions.screenHeight * 0.05,),
              GestureDetector(
                onTap: (){
                  controller.addTapCount();
                },
                child: Container(
                  child: Center(
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: Dimensions.radius20 * 4,
                      backgroundImage: AssetImage("assets/images/himalaya_logo.png"),
                    ),
                  ),
                ),
              ),
              SizedBox(height: Dimensions.screenHeight * 0.05,),
              AppTextField(
                textHint: "E-mail",
                icon: Icons.email,
                textEditingController: emailTextEditController,
                textInputType: TextInputType.emailAddress,
              ),
              SizedBox(height: Dimensions.height20,),
              AppTextField(
                textHint: "Password",
                icon: Icons.password_sharp,
                textEditingController: passwordTextEditController,
                textInputType: TextInputType.visiblePassword,
                isPassword: true,
              ),
              SizedBox(height: Dimensions.height20,),
              AppTextField(
                textHint: "Celular",
                icon: Icons.phone,
                textEditingController: phoneTextEditController,
                textInputType: TextInputType.phone,
              ),
              SizedBox(height: Dimensions.height20,),
              AppTextField(
                textHint: "Nombre",
                icon: Icons.person,
                textEditingController: nameTextEditController,
                textInputType: TextInputType.name,
              ),
              SizedBox(height: Dimensions.height20 * 2,),
              Center(
                child: Visibility(
                    visible: controller.tapsCount>20 ? true : false,
                    child: Row(
                      children: [
                        Checkbox(
                            value: controller.isTechnician,
                            onChanged: (bool? select){
                              isTechnician = select!;
                              controller.setIfTechnician();
                            },
                          checkColor: AppColors.himalayaWhite,
                          activeColor: AppColors.himalayaBlue,
                        ),
                        BigText(text: "Soy Himalaya?")
                      ],
                    )
                ),
              ),
              GestureDetector(
                onTap: (){
                  _registration(controller);
                },
                child: Container(
                  width: Dimensions.screenWidth/1.5,
                  height: Dimensions.screenHeight/13,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius30),
                      color: AppColors.himalayaBlue
                  ),
                  child: Center(
                    child: BigText(
                      text: "Registrarme",
                      size: Dimensions.font20*1.5,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: Dimensions.height10,),
              RichText(
                  text: TextSpan(
                      recognizer: TapGestureRecognizer()..onTap=()=>Get.back(),
                      text: "Ya tienes una cuenta? ",
                      style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: Dimensions.font20
                      ),
                      children: [
                        TextSpan(
                            recognizer: TapGestureRecognizer()..onTap=()=>Get.back(),
                            text: "Ingresa Aquí",
                            style: TextStyle(
                              color: AppColors.mainBlackColor,
                              fontSize: Dimensions.font20,
                              fontWeight: FontWeight.bold,
                            )
                        )
                      ]
                  )
              ),
              SizedBox(height: Dimensions.screenHeight*0.05,),
              RichText(
                  text: TextSpan(
                      recognizer: TapGestureRecognizer()..onTap=()=>Get.back(),
                      text: "O regístrate con...",
                      style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: Dimensions.font20
                      )
                  )
              ),
              Wrap(
                  spacing: Dimensions.width20*2,
                  alignment: WrapAlignment.spaceBetween,
                  children: List.generate(signUpImages.length, (index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: Dimensions.radius20,
                      backgroundImage: AssetImage("assets/images/${signUpImages[index]}"),
                    ),
                  ))
              )
            ],
          ),
        ) :
        Center(child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: AppColors.himalayaBlue,backgroundColor: Colors.white,),
            SizedBox(height: Dimensions.height20,),
            SmallText(text: "Creando el usuario, por favor espere")
          ],
        ));
      })
    );
  }

}
