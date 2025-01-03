import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:himalayastoreapp/controllers/products_pager_view_controller.dart';
import 'package:himalayastoreapp/pages/cart/payment_page.dart';

import '../../base/show_custom_message.dart';
import '../../controllers/authentication_controller.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/main_page_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/app_colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';
import '../../widgets/small_text.dart';
import 'cart_empty_page.dart';

class CartScreen extends StatelessWidget {

  String page;

  CartScreen(
    {
      super.key,
      required this.page
    }
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<CartController>(builder: (controller){
        return !controller.doingPayment && !controller.loadingNewDelivery && !controller.isMessageSent ? Stack(
          children: [
            Positioned(
                top: Dimensions.height20*3,
                left: Dimensions.width20,
                right: Dimensions.width20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Visibility(
                      visible: page.isNotEmpty ? true : false,
                      child: GestureDetector(
                        onTap:(){
                          Navigator.pop(context);
                        },
                        child: Semantics(
                          label: "Botón ir atrás",
                          child: ApplIcon(
                            icon: Icons.arrow_back_ios,
                            iconColor: Colors.white,
                            backgroundColor: AppColors.himalayaBlue,
                            iconSize: Dimensions.iconSize24,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: Dimensions.width20*5,),
                    GetBuilder<CartController>(builder: (controller){
                      return Stack(
                        children: [
                          Semantics(
                            label: "Icono carrito de compra con ${controller.totalItems} items",
                            child: ApplIcon(
                              icon: Icons.shopping_cart_outlined,
                              iconColor: Colors.white,
                              backgroundColor: AppColors.himalayaBlue,
                              iconSize: Dimensions.iconSize24,
                            ),
                          ),
                          controller.totalItems>=1 ?
                          Positioned(
                              right: 0,
                              top: 0,
                              child: ApplIcon(
                                icon: Icons.circle,
                                size: 20,
                                iconColor: Colors.transparent,
                                backgroundColor: Colors.redAccent,
                              )
                          ) :
                          Container(),
                          controller.totalItems>=1 ?
                          Positioned(
                            right: 3,
                            top: 3,
                            child: SmallText(
                              text: controller.totalItems.toString(),
                              color: Colors.white,
                              size: 12,
                            ),
                          ) :
                          Container()
                        ],
                      );
                    })
                  ],
                )
            ),
            Positioned(
                top: Dimensions.height20 * 5,
                left: Dimensions.width20,
                right: Dimensions.width20,
                bottom: 0,
                child: Container(
                  margin: EdgeInsets.only(top: Dimensions.height15),
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: GetBuilder<CartController>(builder: (controller){

                      var _cartList = controller.getItems;

                      return _cartList.length>0 ? ListView.builder(
                          itemCount: _cartList.length,
                          itemBuilder: (_,index){
                            return Container(
                              height: 100,
                              width: double.maxFinite,
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      var productCategory = _cartList[index].productModel!.productCategory!;

                                      var productIndex = Get.find<ProductPagerViewController>()
                                          .productMap[productCategory]!
                                          .indexWhere((productModel) => productModel.id == _cartList[index].productModel!.id);

                                      Get.toNamed(RouteHelper.getProductDetails(productIndex.toString(),productCategory));
                                    },
                                    child: Semantics(
                                      label:"Imagen de producto ${_cartList[index].name}",
                                      child: Container(
                                        width: Dimensions.width20 * 5,
                                        height: Dimensions.height20 * 5,
                                        margin: EdgeInsets.only(bottom: Dimensions.height10),
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    _cartList[index].img!
                                                )
                                            ),
                                            borderRadius: BorderRadius.circular(Dimensions.radius20),
                                            color: Colors.white
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: Dimensions.width10,),
                                  Expanded(
                                      child: Container(
                                        height: Dimensions.height20 * 5,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            BigText(text: _cartList[index].name!,color: Colors.black,),
                                            SmallText(text: _cartList[index].description!,overflow: TextOverflow.ellipsis,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                BigText(text: "\$ ${_cartList[index].price!.toString()}",color: AppColors.himalayaBlue,),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.only(top: Dimensions.height10,bottom: Dimensions.height10,right: Dimensions.height10,left: Dimensions.height10),
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(Dimensions.radius20),
                                                          color: Colors.white
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          GestureDetector(
                                                              onTap:(){
                                                                controller.addItem(_cartList[index].productModel!, -1);
                                                              },
                                                              child: Semantics(label:"Quitar una unidad de producto del carrito",child: Icon(Icons.remove,color: AppColors.signColor,))
                                                          ),
                                                          SizedBox(width: Dimensions.width10/2,),
                                                          Semantics(
                                                            label: "${_cartList[index].quantity!.toString()} unidades de ${_cartList[index].name} en el carrito",
                                                            child: BigText(
                                                                text: _cartList[index].quantity!.toString()
                                                            ),
                                                          ),
                                                          SizedBox(width: Dimensions.width10/2,),
                                                          GestureDetector(
                                                              onTap: (){
                                                                controller.addItem(_cartList[index].productModel!, 1);
                                                              },
                                                              child: Semantics(label:"Agregar una unidad de producto del carrito",child: Icon(Icons.add,color: AppColors.signColor,))
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                  )
                                ],
                              ),
                            );
                          }) : NoDataPage(text: "El carrito esta vacio, pide ya!!!");
                    }),
                  ),
                )
            )
          ],
        ):
        !controller.doingPayment &&  controller.loadingNewDelivery && !controller.isMessageSent ?
        Container(
            height: Dimensions.screenHeight,
            width: double.infinity,
            color: Colors.white,
            child: Center(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: AppColors.himalayaBlue,
                    ),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    Text("Enviando pedido... por favor espere...")
                  ],
                ),
              ),
            )
        ):
        controller.doingPayment && !controller.loadingNewDelivery && !controller.isMessageSent ?
        Container(
            height: Dimensions.screenHeight,
            width: double.infinity,
            color: Colors.white,
            child: Center(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: AppColors.himalayaBlue,
                    ),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    Text("Realizando el pago... por favor espere...")
                  ],
                ),
              ),
            )
        ):
        controller.creditCardPaymentResponse.data != null && controller.creditCardPaymentResponse!.data!.transaction != null &&
          !controller.doingPayment &&
          controller.creditCardPaymentResponse.data!.transaction!.data!.estado == "Aceptada" &&
          controller.loadingNewDelivery &&
          controller.isMessageSent ?
            Container(
            height: Dimensions.screenHeight,
            width: double.infinity,
            color: Colors.white,
            child: Center(
              child: Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/himalaya_logo.png",height: Dimensions.screenHeight / 2,width: Dimensions.screenWidth,),
                    SizedBox(height: Dimensions.height20,),
                    Text("Pedido pagado y enviado correctamente, espere la confirmación de la tienda"),
                    SizedBox(height: Dimensions.height20,),
                    Text("Pago Aceptado",style: TextStyle(color: Colors.green),),
                    SizedBox(height: Dimensions.height20,),
                    Text("Referencia de pago: ${controller.creditCardPaymentResponse.data!.transaction!.data!.refPayco.toString()}"),
                    SizedBox(height: Dimensions.height20,),
                    Text("Fecha de pago: ${controller.creditCardPaymentResponse.data!.transaction!.data!.fecha}"),
                    SizedBox(height: Dimensions.height20,),
                    RawMaterialButton(
                      onPressed: () {
                        controller.cleanAfterSent();
                        if(page.isNotEmpty){
                          Navigator.pop(context);
                        }
                      },
                      elevation: 2.0,
                      fillColor: Colors.white,
                      child: Icon(
                        Icons.check,
                        size: 35.0,
                        color: Colors.green,
                      ),
                      padding: EdgeInsets.all(15.0),
                      shape: CircleBorder(),
                    )
                  ],
                ),
              ),
            ),
          ):
        controller.pseTransactionConfirm.data != null &&
          !controller.doingPayment &&
          controller.pseTransactionConfirm.data!.estado == "Aceptada" &&
          controller.loadingNewDelivery &&
          controller.isMessageSent ?
            Container(
          height: Dimensions.screenHeight,
          width: double.infinity,
          color: Colors.white,
          child: Center(
            child: Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/himalaya_logo.png",height: Dimensions.screenHeight / 2,width: Dimensions.screenWidth,),
                  SizedBox(height: Dimensions.height20,),
                  Text("Pedido pagado y enviado correctamente, espere la confirmación de la tienda"),
                  SizedBox(height: Dimensions.height20,),
                  Text("Pago Aceptado",style: TextStyle(color: Colors.green),),
                  SizedBox(height: Dimensions.height20,),
                  Text("Referencia de pago: ${controller.pseTransactionConfirm.data!.refPayco.toString()}"),
                  SizedBox(height: Dimensions.height20,),
                  Text("Fecha de pago: ${controller.pseTransactionConfirm.data!.fecha}"),
                  SizedBox(height: Dimensions.height20,),
                  RawMaterialButton(
                    onPressed: () {
                      controller.cleanAfterSent();
                      if(page.isNotEmpty){
                        Navigator.pop(context);
                      }
                    },
                    elevation: 2.0,
                    fillColor: Colors.white,
                    child: Icon(
                      Icons.check,
                      size: 35.0,
                      color: Colors.green,
                    ),
                    padding: EdgeInsets.all(15.0),
                    shape: CircleBorder(),
                  )
                ],
              ),
            ),
          ),
        ) :
        controller.creditCardPaymentResponse.data != null && controller.creditCardPaymentResponse!.data!.transaction != null &&
          !controller.doingPayment &&
          controller.creditCardPaymentResponse.data!.transaction!.data!.estado == "Rechazada" &&
          !controller.loadingNewDelivery &&
          controller.isMessageSent ?
            Container(
          height: Dimensions.screenHeight,
          width: double.infinity,
          color: Colors.white,
          child: Center(
            child: Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/himalaya_logo.png",height: Dimensions.screenHeight / 2,width: Dimensions.screenWidth,),
                  SizedBox(height: Dimensions.height20,),
                  Text("Pago Rechazado, intente nuevamente",style: TextStyle(color: Colors.red),),
                  SizedBox(height: Dimensions.height20,),
                  Text("Referencia de pago: ${controller.creditCardPaymentResponse.data!.transaction!.data!.refPayco.toString()}"),
                  SizedBox(height: Dimensions.height20,),
                  Text("Mensaje entidad: ${controller.creditCardPaymentResponse.data!.transaction!.data!.respuesta}"),
                  SizedBox(height: Dimensions.height20,),
                  Text("Fecha de pago: ${controller.creditCardPaymentResponse.data!.transaction!.data!.fecha}"),
                  SizedBox(height: Dimensions.height20,),
                  SizedBox(height: Dimensions.height20,),
                  RawMaterialButton(
                    onPressed: () {
                      controller.cleanAfterSent();
                      if(page.isNotEmpty){
                        Navigator.pop(context);
                      }
                    },
                    elevation: 2.0,
                    fillColor: Colors.white,
                    child: Icon(
                      Icons.close,
                      size: 35.0,
                      color: Colors.red,
                    ),
                    padding: EdgeInsets.all(15.0),
                    shape: CircleBorder(),
                  )
                ],
              ),
            ),
          ),
        ):
        controller.pseTransactionConfirm.data != null &&
          !controller.doingPayment &&
          controller.pseTransactionConfirm.data!.estado == "Rechazada" &&
          !controller.loadingNewDelivery &&
          controller.isMessageSent ?
            Container(
          height: Dimensions.screenHeight,
          width: double.infinity,
          color: Colors.white,
          child: Center(
            child: Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/himalaya_logo.png",height: Dimensions.screenHeight / 2,width: Dimensions.screenWidth,),
                  SizedBox(height: Dimensions.height20,),
                  Text("Pago Rechazado, intente nuevamente",style: TextStyle(color: Colors.red),),
                  SizedBox(height: Dimensions.height20,),
                  Text("Referencia de pago: ${controller.pseTransactionConfirm.data!.refPayco.toString()}"),
                  SizedBox(height: Dimensions.height20,),
                  Text("Mensaje entidad: ${controller.pseTransactionConfirm.data!.respuesta}"),
                  SizedBox(height: Dimensions.height20,),
                  Text("Fecha de pago: ${controller.pseTransactionConfirm.data!.fecha}"),
                  SizedBox(height: Dimensions.height20,),
                  SizedBox(height: Dimensions.height20,),
                  RawMaterialButton(
                    onPressed: () {
                      controller.cleanAfterSent();
                      if(page.isNotEmpty){
                        Navigator.pop(context);
                      }
                    },
                    elevation: 2.0,
                    fillColor: Colors.white,
                    child: Icon(
                      Icons.close,
                      size: 35.0,
                      color: Colors.red,
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
          height: Dimensions.screenHeight,
          width: double.infinity,
          color: Colors.white,
          child: Center(
            child: Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/himalaya_logo.png",height: Dimensions.screenHeight / 2,width: Dimensions.screenWidth,),
                  SizedBox(height: Dimensions.height20,),
                  Text("Error en la transacción, intente nuevamente",style: TextStyle(color: Colors.red),),
                  SizedBox(height: Dimensions.height20,),
                  Text(controller.pseErrorTransaction.textResponse != null ?
                        controller.pseErrorTransaction.textResponse! :
                        controller.creditCardPaymentResponse.textResponse != null ?
                        controller.creditCardPaymentResponse.textResponse! :
                        ""
                  ),
                  SizedBox(height: Dimensions.height20,),
                  Text(controller.pseErrorTransaction!.data != null ?
                      controller.pseErrorTransaction!.data!.error!.errores![0].errorMessage! :
                      controller.creditCardPaymentResponse.lastAction != null ?
                      controller.creditCardPaymentResponse.lastAction! :
                      ""
                  ),
                  SizedBox(height: Dimensions.height20,),
                  SizedBox(height: Dimensions.height20,),
                  RawMaterialButton(
                    onPressed: () {
                      controller.cleanAfterSent();
                      if(page.isNotEmpty){
                        Navigator.pop(context);
                      }
                    },
                    elevation: 2.0,
                    fillColor: Colors.white,
                    child: Icon(
                      Icons.close,
                      size: 35.0,
                      color: Colors.red,
                    ),
                    padding: EdgeInsets.all(15.0),
                    shape: CircleBorder(),
                  )
                ],
              ),
            ),
          ),
        );
      }),
      bottomNavigationBar: GetBuilder<CartController>(builder: (controller){

        var _cartList = controller.getItems;

        return Visibility(
          visible: !controller.doingPayment && !controller.loadingNewDelivery && !controller.isMessageSent ? true : false,
          child: Container(
            height: Dimensions.bottomHeightBar,
            padding: EdgeInsets.only(top: Dimensions.height30,bottom: Dimensions.height30,left: Dimensions.width40,right: Dimensions.width40),
            decoration: BoxDecoration(
                color: AppColors.buttonBackGroundColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(Dimensions.radius20*2),
                  topLeft: Radius.circular(Dimensions.radius20*2),
                )
            ),
            child: _cartList.length>0 ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Semantics(
                  label: "Sub total ${controller.totalAmount.toString()} pesos",
                  child: Column(
                    children: [
                      SmallText(text: "Sub total",color: AppColors.mainBlackColor,),
                      SizedBox(height: Dimensions.height10,),
                      BigText(
                          text: "\$ ${controller.totalAmount.toString()}"
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () async{
                    if(Get.find<AuthenticationPageController>().firebaseAuth.currentUser != null){
                      if(Get.find<AuthenticationPageController>().signUpBody!.phone!.isNotEmpty){
                        if(Get.find<MainPageController>().currentAddressDetailModel.position!.isNotEmpty &&
                            Get.find<MainPageController>().currentAddressDetailModel.cityCountryAddress! != "Ingrese su dirección"){
                          if(controller.totalAmount >= 50000){
                            Get.to(() => PaymentScreen(),transition: Transition.rightToLeft,duration: Duration(milliseconds: 300));
                          }else{
                            showCustomSnackBar("Valor mínimo de pedido \$50.000",backgroundColor: Colors.redAccent);
                          }
                        }else{
                          showCustomSnackBar("Ingrese una dirección de domicilio",backgroundColor: AppColors.himalayaGrey);
                        }
                      }else{
                        showCustomSnackBar("Actualice número telefónico",backgroundColor: AppColors.himalayaGrey);
                      }

                    }else{
                      Get.toNamed(RouteHelper.signIn);
                    }
                  },
                  child: Semantics(
                    label: "Botón ir a pagar",
                    child: Container(
                      padding: EdgeInsets.only(top: Dimensions.height10,bottom: Dimensions.height10,right: Dimensions.width40,left: Dimensions.width40),
                      child: BigText(text: "Ir a pagar", color: Colors.white,),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radius20),
                          color: AppColors.himalayaBlue
                      ),
                    ),
                  ),
                )
              ],
            ) : Container(),
          ),
        );
      }),
    );
  }
}
