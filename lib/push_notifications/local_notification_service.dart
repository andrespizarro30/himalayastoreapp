import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:himalayastoreapp/models/deliveries_id_model.dart';
import 'package:himalayastoreapp/models/instant_messages_model.dart';

class LocalNotificationService {

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static late Deliveries deliveryNotification;


  static void notificationTapBackground(NotificationResponse notificationResponse) {


  }

  Future<void> init() async {
    // Initialize native android notification
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    // Initialize native Ios Notifications
    const DarwinInitializationSettings initializationSettingsIOS =
    DarwinInitializationSettings();

    const InitializationSettings initializationSettings =
    InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );
  }

  void showNotificationAndroid(Deliveries instantMessageModel) async {

    LocalNotificationService.deliveryNotification = instantMessageModel;

    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails('channel_id', 'Channel Name',
        channelDescription: 'Channel Description',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');

    int notification_id = 1;
    const NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails);

    await flutterLocalNotificationsPlugin
        .show(notification_id, "Nuevo pedido recibido", "${deliveryNotification.deliveryUserName}-${deliveryNotification.deliveryCity}", notificationDetails, payload: 'Not present');
  }


  void showNotificationIos(Deliveries chatMessageModel) async {

    LocalNotificationService.deliveryNotification = chatMessageModel;

    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
    DarwinNotificationDetails(
        presentAlert: true,  // Present an alert when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)
        presentBadge: true,  // Present the badge number when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)
        presentSound: true,  // Play a sound when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)// Specifics the file path to play (only from iOS 10 onwards)
        subtitle: "App Notification", //Secondary description  (only from iOS 10 onwards)
    );

    int notification_id = 1;

    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(iOS: iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin
        .show(notification_id, "Nuevo pedido recibido", "${deliveryNotification.deliveryUserName}-${deliveryNotification.deliveryCity}", platformChannelSpecifics, payload: 'Not present');
  }

}