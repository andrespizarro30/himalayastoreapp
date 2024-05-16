import 'dart:io' as io;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:himalayastoreapp/widgets/app_text_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';


import '../../base/request_camera_gallery.dart';
import '../../base/show_custom_message.dart';
import '../../controllers/authentication_controller.dart';
import '../../controllers/products_pager_view_controller.dart';
import '../../permissions/permissions.dart';
import '../../routes/route_helper.dart';
import '../../utils/app_colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/account_widget.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';
import 'package:path/path.dart' as path;

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return GetBuilder<AuthenticationPageController>(builder: (controller){

      return controller.currentFBUserExists ? Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.himalayaBlue,
          title: Center(
            child: BigText(
              text: "Perfil",
              size: 24,
              color: Colors.white,
            ),
          ),
        ),
        body: Stack(
          children: [
            Container(
              width: double.maxFinite,
              margin: EdgeInsets.only(top: Dimensions.height20),
              child: Column(
                children: [
                  //PROFILE ICON
                  Stack(
                    children: [
                      controller.profileImageURL.isNotEmpty ?
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 80,
                        backgroundImage: NetworkImage(
                          controller.profileImageURL,
                        ),
                      ):
                      ApplIcon(
                        icon: Icons.person,
                        backgroundColor: AppColors.himalayaBlue,
                        iconColor: Colors.white,
                        iconSize: Dimensions.iconSize20 * 3.5,
                        size: Dimensions.height30 * 5,
                      ),
                      Positioned(
                          right: Dimensions.width10,
                          bottom: Dimensions.height10,
                          child: GestureDetector(
                            onTap: () async{
                              var permissionStatus = io.Platform.isAndroid ? await requestStoragePermissionIOS() : await requestStoragePermissionIOS();
                              if(permissionStatus.isGranted){
                                controller.openImageRequestContainer();
                              }else
                              if(io.Platform.isIOS){
                                controller.openImageRequestContainer();
                              }
                              else{
                                showCustomSnackBar("Acepte los permisos de cámara requeridos");
                              }

                            },
                            child: ApplIcon(
                              icon: Icons.edit,
                              size: Dimensions.iconSize24 * 1.8,
                              backgroundColor: Colors.white,
                            ),
                          )
                      )
                    ],
                  ),
                  SizedBox(height: Dimensions.height20,),
                  //NAME
                  Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AccountWidget(
                                applIcon: ApplIcon(
                                  icon: Icons.person,
                                  backgroundColor: AppColors.himalayaBlue,
                                  iconColor: Colors.white,
                                  iconSize: Dimensions.iconSize24,
                                  size: Dimensions.height10 * 5,
                                ),
                                bigText: BigText(text: controller.signUpBody.name!,)
                            ),
                            SizedBox(height: Dimensions.height20,),
                            //PHONE
                            GestureDetector(
                              onTap: (){
                                openUpdateDialogBox(context,controller);
                              },
                              child: AccountWidget(
                                  applIcon: ApplIcon(
                                    icon: Icons.phone,
                                    backgroundColor: AppColors.iconColor1,
                                    iconColor: Colors.white,
                                    iconSize: Dimensions.iconSize24,
                                    size: Dimensions.height10 * 5,
                                    text: controller.signUpBody.phone!,
                                  ),
                                  bigText: BigText(text: controller.signUpBody.phone!.isNotEmpty ? controller.signUpBody.phone! : "Actualice # Célular",
                                    color: controller.signUpBody.phone!.isNotEmpty ? Colors.black : Colors.redAccent,
                                  )
                              ),
                            ),
                            SizedBox(height: Dimensions.height20,),
                            //E-MAIL
                            AccountWidget(
                                applIcon: ApplIcon(
                                  icon: Icons.mail,
                                  backgroundColor: AppColors.iconColor2,
                                  iconColor: Colors.white,
                                  iconSize: Dimensions.iconSize24,
                                  size: Dimensions.height10 * 5,
                                ),
                                bigText: BigText(text: controller.signUpBody.email!,)
                            ),
                            controller.signUpBody.userType == "Tecnico" ?
                            SizedBox(height: Dimensions.height20,):
                            SizedBox(height: Dimensions.height40,),
                            controller.signUpBody.userType == "Tecnico" ?
                            GestureDetector(
                              onTap: (){
                                Get.toNamed(RouteHelper.getPendingDeliveries());
                              },
                              child: AccountWidget(
                                  applIcon: ApplIcon(
                                    icon: Icons.list_alt_sharp,
                                    backgroundColor: AppColors.himalayaBlue,
                                    iconColor: Colors.white,
                                    iconSize: Dimensions.iconSize24,
                                    size: Dimensions.height10 * 5,
                                  ),
                                  bigText: BigText(text: "Ver pedidos recibidos",)
                              ),
                            ):
                            SizedBox(height: Dimensions.height40,),
                            SizedBox(height: Dimensions.height40,),
                            GestureDetector(
                              onTap: (){
                                controller.signOut();
                                controller.verifyCurrentUser();
                                Get.find<ProductPagerViewController>().clearIsLoadedMap();
                                Get.offNamed(RouteHelper.signIn);
                              },
                              child: AccountWidget(
                                  applIcon: ApplIcon(
                                    icon: Icons.logout,
                                    backgroundColor: Colors.redAccent,
                                    iconColor: Colors.white,
                                    iconSize: Dimensions.iconSize24,
                                    size: Dimensions.height10 * 5,
                                  ),
                                  bigText: BigText(text: "Logout",)
                              ),
                            ),
                          ],
                        ),
                      )
                  )
                ],
              ),
            ),
            controller.isOpenImageRequestContainer ?
            GestureDetector(
              onTap: (){
                controller.openImageRequestContainer();
              },
              child: Container(
                height: Dimensions.screenHeight,
                width: double.infinity,
                color: Colors.black45,
              ),
            ):Container(),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: GestureDetector(
                onVerticalDragUpdate: (details){
                  controller.closeDraggingUpdateImageRequestContainer(details.delta.dy);
                },
                onVerticalDragEnd: (details){
                  controller.closeDraggingEndImageRequestContainer();
                },
                child: AnimatedContainer(
                  height: controller.imageRequestContainerHeight,
                  duration: Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(Dimensions.radius30),
                          topRight: Radius.circular(Dimensions.radius30)
                      ),
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
                  child: Padding(
                    padding: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: Dimensions.height10,
                          ),
                          BigText(text: "Foto de perfil",size: Dimensions.font16,),
                          SizedBox(
                            height: Dimensions.height10,
                          ),
                          BigText(text: "Toma una foto o selecciona una imagen de tu galería",size: Dimensions.font26,maxLines: 2,),
                          Divider(
                            height: Dimensions.height40,
                            thickness: Dimensions.height10/10,
                            color: AppColors.himalayaGrey,
                          ),
                          Center(
                            child: ElevatedButton(
                              onPressed: (){
                                pickImageFromCamera(controller, "Camara");
                              },
                              child: Text(
                                "Tomar foto"
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.himalayaBlue,
                                foregroundColor: AppColors.himalayaWhite,
                                minimumSize: Size(Dimensions.screenWidth * 0.7, Dimensions.height30 * 2)
                              ),
                            ),
                          ),
                          SizedBox(
                            height: Dimensions.height10,
                          ),
                          Center(
                            child: ElevatedButton(
                              onPressed: (){
                                pickImageFromCamera(controller, "Galeria");
                              },
                              child: Text(
                                  "Seleccionar foto existente"
                              ),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.himalayaWhite,
                                  foregroundColor: AppColors.himalayaGrey,
                                  minimumSize: Size(Dimensions.screenWidth * 0.7, Dimensions.height30 * 2)
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            )
          ],
        ),
      ) :
      Container(
        child: Center(
            child: GestureDetector(
              onTap: (){
                Get.offNamed(RouteHelper.signIn);
              },
              child: Container(
                height: Dimensions.screenHeight * 0.05,
                width: Dimensions.screenWidth * 0.9,
                child: Center(child: Text("Realice el logging o cree una cuenta AQUÍ")),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Dimensions.radius30),
                        topRight: Radius.circular(Dimensions.radius30),
                        bottomLeft: Radius.circular(Dimensions.radius30),
                        bottomRight: Radius.circular(Dimensions.radius30)
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: AppColors.himalayaGrey,
                          blurRadius: 20.0,
                          offset: Offset(0,-5)
                      ),
                      BoxShadow(
                          color: AppColors.himalayaBlue,
                          blurRadius: 20.0,
                          offset: Offset(0,5)
                      ),
                      BoxShadow(
                          color: Colors.white,
                          offset: Offset(0,-5)
                      )
                    ]
                ),
              ),
            )
        ),
      );
    });
  }

  Future pickImageFromCamera(AuthenticationPageController controller,String response) async{

    XFile? returnedImage;

    if(response == "Camara"){
      returnedImage = await ImagePicker().pickImage(source: ImageSource.camera,imageQuality: 30);
    }else
    if(response == "Galeria"){
      returnedImage = await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 30);
    }

    if(returnedImage == null) return;

    String dir = path.dirname(returnedImage.path);
    String newFilename = "My_Profile_Image.jpg";
    String newPathName = path.join(dir,"${newFilename}");
    io.File imageFile = io.File(returnedImage.path).renameSync(newPathName);


    var appDirectory = io.Platform.isAndroid ? await getDownloadsDirectory() : await getApplicationDocumentsDirectory();

    io.Directory folderDir = io.Directory("${appDirectory!.path}/MyPhotoProfile");

    if(await folderDir.exists() == false){
      await folderDir.create(recursive: true);
    }

    io.File newImageFile = await imageFile.copy("${folderDir.path}/${newFilename}");

    controller.updatePhotoProfile(appDirectory.path,newImageFile);

    controller.openImageRequestContainer();

  }

  Future<void> openUpdateDialogBox(BuildContext context, AuthenticationPageController controller) async{

    var response = await showDialog(
        context: context,
        builder: (BuildContext c) => updateDialog(controller,c));

  }

  Widget updateDialog(AuthenticationPageController controller,BuildContext context){

    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14)
      ),
      backgroundColor: AppColors.himalayaBlue,
      child: Container(
        height: Dimensions.screenHeight/3,
        width: Dimensions.screenWidth,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20,),
            Text(
              "Actualizar # Celular",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 16
              ),
            ),
            const SizedBox(height: 20,),
            Divider(
              thickness: 3,
              color: AppColors.himalayaBlue,
            ),

            const SizedBox(height: 10,),

            AppTextField(
              textEditingController: controller.tecUpdatePhoneNumber,
              textHint: "Ingresa # celular",
              icon: Icons.phone,
              textInputType: TextInputType.number,
            ),

            SizedBox(height: Dimensions.height30,),

            Padding(
              padding: EdgeInsets.only(left: Dimensions.height10,right: Dimensions.height10,bottom: 0),
              child: ElevatedButton(
                onPressed: () async{
                  var resp = await controller.updatePhoneNumber();
                  if(resp){
                    Navigator.pop(context);
                  }else{

                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Actualizar",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20
                      ),
                    ),
                    Icon(
                      Icons.update,
                      color: Colors.white,
                      size: 26,
                    )
                  ],
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.himalayaBlue
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
