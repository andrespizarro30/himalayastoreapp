import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:himalayastoreapp/models/instant_messages_model.dart';
import 'package:himalayastoreapp/push_notifications/local_notification_service.dart';
import 'package:himalayastoreapp/utils/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../base/show_custom_message.dart';
import '../controllers/cart_controller.dart';
import '../models/deliveries_id_model.dart';
import '../utils/app_constants.dart';



class PushNotificationSystem{

  BuildContext context;

  PushNotificationSystem({required this.context});

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future initializeCloudMessaging() async{

    //1.Terminated
    //cuando la app esta completamente cerrada y abre directamente desde la notificación

    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? remoteMessage)
    {
      if(remoteMessage != null){

        final delivery = Deliveries.fromJson(remoteMessage.data);


      }
    });

    //2.Foreground
    //cuando la app esta abierta y recive una notificación
    FirebaseMessaging.onMessage.listen((RemoteMessage? remoteMessage) {
      if(remoteMessage != null){

        if(remoteMessage.notification!.body! == "Nuevo pedido recibido"){
          final delivery = Deliveries.fromJson(remoteMessage.data);
          showCustomSnackBar("Nuevo pedido recibido desde ${delivery.deliveryCity}",title: "Tienda Himalaya",backgroundColor: AppColors.himalayaBlue);
        }else{
          final deliveryStatus = remoteMessage.data["DeliveryStatus"];
          String messageStatus = "";

          if(deliveryStatus == "EN"){
            messageStatus = "Pedido ha sido recibido";
          }else
          if(deliveryStatus == "PR"){
            messageStatus = "Pedido en proceso";
          }else
          if(deliveryStatus == "CA"){
            messageStatus = "Pedido en camino";
          }else
          if(deliveryStatus == "RE"){
            messageStatus = "Pedido entregado";
          }
          showCustomSnackBar(messageStatus,title: "Tienda Himalaya",backgroundColor: AppColors.himalayaBlue);

          Get.find<CartController>().getDeliveryByUIDandID();

        }

        /*
        if(Platform.isAndroid){
          LocalNotificationService().showNotificationAndroid(delivery);
        }else
        if(Platform.isIOS){
          LocalNotificationService().showNotificationIos(delivery);
        }
        */

      }
    });

    //3.Background
    //cuando la app esta en segundo plano y abre directamente desde la notificación
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? remoteMessage) {
      if(remoteMessage != null){

        final delivery = Deliveries.fromJson(remoteMessage.data);

      }
    });

  }

  Future generateMessagingToken() async{

    await FirebaseMessaging.instance.requestPermission();

    String? registrationToken = await messaging.getToken();

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setString(AppConstants.FIRESTORE_TOKENS, registrationToken!);

    print("FCM Registration Token: ");
    print(registrationToken);

    messaging.subscribeToTopic("allUsers");


  }


}
