import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:himalayastoreapp/models/instant_messages_model.dart';
import 'package:himalayastoreapp/push_notifications/local_notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

        final instantMessageModel = InstantMessageModel.fromJson(remoteMessage.data);


      }
    });

    //2.Foreground
    //cuando la app esta abierta y recive una notificación
    FirebaseMessaging.onMessage.listen((RemoteMessage? remoteMessage) {
      if(remoteMessage != null){

        final instantMessageModel = InstantMessageModel.fromJson(remoteMessage.data);

        if(Platform.isAndroid){
          LocalNotificationService().showNotificationAndroid(instantMessageModel);
        }else
        if(Platform.isIOS){
          LocalNotificationService().showNotificationIos(instantMessageModel);
        }

      }
    });

    //3.Background
    //cuando la app esta en segundo plano y abre directamente desde la notificación
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? remoteMessage) {
      if(remoteMessage != null){

        final instantMessageModel = InstantMessageModel.fromJson(remoteMessage.data);

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
