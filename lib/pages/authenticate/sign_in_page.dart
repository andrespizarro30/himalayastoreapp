
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:himalayastoreapp/pages/authenticate/sign_up_page.dart';

import '../../base/show_custom_message.dart';
import '../../controllers/authentication_controller.dart';
import '../../models/sign_up_model.dart';
import '../../routes/route_helper.dart';
import '../../utils/app_colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/big_text.dart';
import '../../widgets/small_text.dart';

class SignInScreen extends StatelessWidget {

  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {

    TextEditingController emailTextEditController = TextEditingController();
    TextEditingController passwordTextEditController = TextEditingController();

    void _login(AuthenticationPageController authController){

      var email = emailTextEditController.text.trim();
      var pwd = passwordTextEditController.text.trim();

      if(email.isEmpty){
        showCustomSnackBar("Ingresa tu e-mail",title: "Dirección e-mail");
      }else if(!GetUtils.isEmail(email)){
        showCustomSnackBar("Ingrese un e-mail valido",title: "Dirección e-mail");
      }else if(pwd.isEmpty){
        showCustomSnackBar("Ingrese su password",title: "Password");
      }else if(pwd.length<6){
        showCustomSnackBar("Password debe ser al menos de 6 caracteres",title: "Password");
      }else{

        SignUpBody signUpBody = SignUpBody(name: "", phone: "", email: email, password: pwd);

        authController.login(signUpBody).then((status){
          if(status.isSuccess){
            Get.toNamed(RouteHelper.getHome());
          }else{
            showCustomSnackBar(status.message);
          }
        });

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
                  Semantics(
                    label: "Logo de Himalaya Mercado Saludable",
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
                  Container(
                    margin: EdgeInsets.only(left: Dimensions.width20),
                    width: double.maxFinite,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hola",
                          style: TextStyle(
                              fontSize: Dimensions.font20*3.5,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        SmallText(text: "Realiza el loggin de tu cuenta",size: Dimensions.font20,)
                      ],
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

                  Semantics(
                    label: "Texto informativo",
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          RichText(
                              text: TextSpan(
                                  text: "Ingresa a tu cuenta",
                                  style: TextStyle(
                                      color: Colors.grey[500],
                                      fontSize: Dimensions.font20
                                  )
                              )
                          ),
                          SizedBox(width: Dimensions.width20,)
                        ]
                    ),
                  ),

                  SizedBox(height: Dimensions.height20,),

                  GestureDetector(
                    onTap: (){
                      _login(controller);
                    },
                    child: Semantics(
                      label: "Botón de ingreso",
                      child: Container(
                        width: Dimensions.screenWidth/2,
                        height: Dimensions.screenHeight/13,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.radius30),
                            color: AppColors.himalayaBlue
                        ),
                        child: Center(
                          child: BigText(
                            text: "Ingresar",
                            size: Dimensions.font20*1.5,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: Dimensions.screenHeight*0.05,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Semantics(
                        label: "Crea una cuenta de usuario aquí",
                        child: RichText(
                            text: TextSpan(
                                text: "No tienes una cuenta? ",
                                style: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: Dimensions.font20
                                ),
                                children: [
                                  TextSpan(
                                      recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>SignUpScreen(),transition: Transition.fade),
                                      text: "Crea una aquí",
                                      style: TextStyle(
                                        color: AppColors.mainBlackColor,
                                        fontSize: Dimensions.font20,
                                        fontWeight: FontWeight.bold,

                                      )
                                  )
                                ]
                            )
                        ),
                      )
                    ],
                  )
                ],
              )
          ) :
          Center(
                child: Column(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(color: AppColors.himalayaBlue,backgroundColor: Colors.white,),
                    SizedBox(height: Dimensions.height20,),
                    SmallText(text: "Autenticando usuario, por favor espere...")
                  ],
                )
          );
        })
    );
  }
}
