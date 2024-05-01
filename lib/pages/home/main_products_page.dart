import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:himalayastoreapp/controllers/main_page_controller.dart';
import 'package:himalayastoreapp/controllers/products_page_controller.dart';
import 'package:himalayastoreapp/pages/home/product_body_page.dart';

import '../../controllers/authentication_controller.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/products_pager_view_controller.dart';
import '../../controllers/select_address_page_controller.dart';
import '../../permissions/permissions.dart';
import '../../routes/route_helper.dart';
import '../../utils/app_colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';
import '../../widgets/icon_text_widget.dart';
import '../../widgets/small_text.dart';

class MainProductsScreen extends StatefulWidget {
  const MainProductsScreen({super.key});

  @override
  State<MainProductsScreen> createState() => _MainProductsScreenState();
}

class _MainProductsScreenState extends State<MainProductsScreen> {
  @override
  Widget build(BuildContext context){

    SchedulerBinding.instance.addPostFrameCallback((_) async{
      _loadResources();
      requestLocationPermissions();
    });

    return Scaffold(
        body: GetBuilder<MainPageController>(builder: (mainPageController){
          return RefreshIndicator(
            color: AppColors.himalayaBlue,
            onRefresh: _loadResources,
            child: Stack(
                children:[
                  mainPageController.isOpenAddressRequestContainer ?
                  Container(
                    height: Dimensions.screenHeight,
                    width: double.infinity,
                    color: Colors.black45,
                  ):Container(),
                  Column(
                    children: [
                      Container(
                        child: Container(
                          margin: EdgeInsets.only(top: Dimensions.height45,bottom: Dimensions.height15),
                          padding: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  mainPageController.getSavedAddress();
                                  mainPageController.openAdressRequestContainer();
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Row(
                                      children: [
                                        BigText(
                                            text: mainPageController.currentAddressDetailModel.cityCountryAddress!.length>=35 ?
                                            "${mainPageController.currentAddressDetailModel.cityCountryAddress!.substring(0,35)}..." :
                                            mainPageController.currentAddressDetailModel.cityCountryAddress!,
                                            color: AppColors.himalayaBlue
                                        ),
                                        Icon(Icons.arrow_drop_down)
                                      ],
                                    ),
                                    SmallText(
                                      text: mainPageController.currentAddressDetailModel.formattedAddress!.length>=35 ?
                                      "${mainPageController.currentAddressDetailModel.formattedAddress!.substring(0,35)}..." :
                                      mainPageController.currentAddressDetailModel.formattedAddress!,
                                      color: Colors.black54,
                                      size: 14,
                                      overflow: TextOverflow.ellipsis
                                    ),
                                  ],
                                ),
                              ),
                              Center(
                                child: Container(
                                  width: Dimensions.width45,
                                  height: Dimensions.height45,
                                  child: Icon(Icons.search,color: Colors.white,size: Dimensions.iconSize24,),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(Dimensions.radius15),
                                      color: AppColors.himalayaBlue
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                          child: SingleChildScrollView(
                            child: ProductsBodyScreen(),
                          )
                      )
                    ],
                  ),
                  Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child:  GestureDetector(
                          onVerticalDragUpdate: (details){
                            mainPageController.closeDraggingUpdateAddressRequestContainer(details.delta.dy);
                          },
                          onVerticalDragEnd: (details){
                            mainPageController.closeDraggingEndAddressRequestContainer();
                          },
                          child: AnimatedContainer(
                            height: mainPageController.addressRequestContainerHeight,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(Dimensions.radius30),
                                    topRight: Radius.circular(Dimensions.radius30)
                                )
                            ),
                            duration: Duration(milliseconds: 300),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24.0,vertical: 18.0),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    BigText(text: "Agrega o escoge una dirección", size: Dimensions.font20 * 1.5,maxLines: 2,),
                                    SizedBox(
                                      height: Dimensions.height20,
                                    ),
                                    Divider(
                                      height: Dimensions.height10/2,
                                      color: Colors.grey[400],
                                    ),
                                    SizedBox(
                                      height: Dimensions.height20,
                                    ),
                                    GestureDetector(
                                      onTap: () async{
                                        var response = await Get.toNamed(RouteHelper.getSearchAddress());
                                        if(response == "load_address"){
                                          mainPageController.getSavedAddress();
                                        }
                                        Get.find<SelectAddressPageController>().cleanAddress();
                                      },
                                      child: IconTextWidget(
                                        applIcon: ApplIcon(
                                          icon: Icons.gps_fixed,
                                          backgroundColor: Colors.white,
                                          iconColor: Colors.black,
                                          iconSize: Dimensions.iconSize24,
                                          size: Dimensions.height10 * 5,
                                        ),
                                        bigText: BigText(text: "Ingresa una nueva dirección",size: Dimensions.font16 * 1.1,),
                                        borderColor: AppColors.himalayaBlue,
                                      ),
                                    ),
                                    SizedBox(
                                      height: Dimensions.height20,
                                    ),
                                    GestureDetector(
                                      onTap: () async{
                                        Get.find<SelectAddressPageController>().deleteSelectedLocation();
                                        var response = await Get.toNamed(RouteHelper.getSelectAddress());
                                        if(response == "load_address"){
                                          mainPageController.getSavedAddress();
                                        }
                                      },
                                      child: IconTextWidget(
                                        applIcon: ApplIcon(
                                          icon: Icons.near_me,
                                          backgroundColor: Colors.white,
                                          iconColor: Colors.black,
                                          iconSize: Dimensions.iconSize24,
                                          size: Dimensions.height10 * 5,
                                        ),
                                        bigText: BigText(text: "Ubicación actual",size: Dimensions.font16 * 1.1,),
                                        borderColor: AppColors.himalayaBlue,
                                      ),
                                    ),
                                    SizedBox(
                                      height: Dimensions.height20,
                                    ),
                                    Divider(
                                      height: Dimensions.height10/2,
                                      color: Colors.grey[400],
                                    ),
                                    mainPageController.addressSaved.isNotEmpty ?
                                    Column(
                                        children: List.generate(mainPageController.addressSaved.length, (index){

                                          return Column(
                                            children: [
                                              SizedBox(height: Dimensions.height10,),
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Flexible(
                                                    child: GestureDetector(
                                                        onTap: (){
                                                          mainPageController.selectCurrentAddress(index);
                                                          mainPageController.openAdressRequestContainer();
                                                          mainPageController.getCurrentAddress();
                                                        },
                                                        child: BigText(text: mainPageController.addressSaved[index].formattedAddress!,maxLines: 2,)
                                                    ),
                                                  ),
                                                  SizedBox(width: Dimensions.width10,),
                                                  index == 0 ?
                                                  Icon(Icons.check_circle_rounded, color: AppColors.himalayaBlue,) :
                                                  !mainPageController.isReadyToDelete[index]! ?
                                                  GestureDetector(
                                                      onTap:(){
                                                        mainPageController.updateIfReadyToDelete(index, true);
                                                      },
                                                      child: Icon(Icons.more_vert)
                                                  ) :
                                                  GestureDetector(
                                                      onTap:(){
                                                        mainPageController.openDeleteAdressRequestContainer();
                                                      },
                                                      child: Icon(Icons.delete_forever)
                                                  )
                                                ],
                                              ),
                                              Divider(height: Dimensions.height20,)
                                            ],
                                          );
                                        })
                                    ):Container()
                                  ],
                                ),
                              ),
                            ),
                          )
                      )
                  ),
                  mainPageController.isOpenDeleteAddressRequestContainer ?
                  GestureDetector(
                    onTap: (){
                      mainPageController.openDeleteAdressRequestContainer();
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
                      child: AnimatedSize(
                        curve: Curves.linear,
                        duration: Duration(milliseconds: 300),
                        child: Container(
                          height: mainPageController.deleteAddressRequestContainerHeight,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(Dimensions.radius30),
                                  topRight: Radius.circular(Dimensions.radius30)
                              )
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24.0,vertical: 18.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SmallText(text: "ELIMINAR DIRECCIÓN",color: Colors.black,),
                                SizedBox(height: Dimensions.height10,),
                                BigText(text: "Seguro desea eliminar la dirección?",size: Dimensions.font26,maxLines: 2,),
                                Divider(height: Dimensions.height20,),
                                ElevatedButton(
                                    onPressed: (){
                                      mainPageController.deleteSpecificAddress();
                                      mainPageController.openDeleteAdressRequestContainer();
                                    },
                                    child: BigText(text: "Eliminar",color: Colors.white,),
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.himalayaBlue,
                                        minimumSize: Size(Dimensions.screenWidth * 0.9, Dimensions.height40 * 1.5)
                                    )
                                ),
                                SizedBox(height: Dimensions.height10,),
                                ElevatedButton(
                                    onPressed: (){
                                      mainPageController.openDeleteAdressRequestContainer();
                                    },
                                    child: BigText(text: "Cancelar",color: Colors.black,),
                                    style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.black,
                                        backgroundColor: Colors.white,
                                        minimumSize: Size(Dimensions.screenWidth * 0.9, Dimensions.height40 * 1.5)
                                    )
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                  )
                ]
            ),
          );
        })
    );
  }

  Future<void> _loadResources() async{
    await Get.find<ProductsPageController>().getProductsCategoriesList();
    await Get.find<ProductsPageController>().getDeliveryReceiverData();
    await Get.find<CartController>().getCartData();
    await Get.find<AuthenticationPageController>().verifyCurrentUser();
    await Get.find<AuthenticationPageController>().getProfileData();
    Get.find<MainPageController>().getCurrentAddress();
  }

  Future<void> requestLocationPermissions()async{
    requestGeolocationPermissions();
  }

}
