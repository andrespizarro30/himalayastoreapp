
import 'dart:convert';

import 'package:get/get.dart';
import 'package:himalayastoreapp/models/deliveries_id_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/app_constants.dart';
import '../apis/api_client.dart';

import 'package:http/http.dart' as http;

class PendingDeliveriesRepo{

  final SharedPreferences sharedPreferences;
  final ApiClient apiClient;

  PendingDeliveriesRepo({
    required this.sharedPreferences,
    required this.apiClient
  });

  Future<Response> getPendingDeliveriesId() async {

    return await apiClient.getData(AppConstants.DELIVERIES_LIST);

  }

  Future<Response> getPendingDeliveriesIdDetails(Deliveries delivery) async {

    Map<String,String> data = {};

    data['DeliveryId'] = delivery.deliveryId!;
    data['DeliveryUID'] = delivery.deliveryUID!;

    return await apiClient.getDataWithQuery(AppConstants.DELIVERIES_DETAIL_LIST,data);

  }

  Future<Response> updateDeliveryIdStatus(Deliveries delivery,String newStatus) async{

    Map<String,String> data = {};

    data['DeliveryId'] = delivery.deliveryId!;
    data['DeliveryUID'] = delivery.deliveryUID!;
    data['DeliveryStatus'] = newStatus;

    return await apiClient.putData(AppConstants.UPDATE_DELIVERY_ID_STATUS, data);
  }

  Future<bool> sendNotificationToUser(Deliveries delivery,String newStatus) async{

    String messageStatus = "";

    if(newStatus == "EN"){
      messageStatus = "Pedido ha sido recibido";
    }else
    if(newStatus == "PR"){
      messageStatus = "Pedido en proceso";
    }else
    if(newStatus == "CA"){
      messageStatus = "Pedido en camino";
    }else
    if(newStatus == "RE"){
      messageStatus = "Pedido entregado";
    }

    final headers = {
      'content-type': 'application/json',
      'Authorization': 'key=${AppConstants.FIREBASE_MESSAGING_AUTH_TOKEN}'
    };

    Map<String,dynamic> body = {
      "notification":{
        "body": messageStatus,
        "title": "Tienda Himalaya"
      },
      "priority": "high",
      "data": {
        "DeliveryStatus": newStatus
      },
      "to": delivery.deliveryToken
    };

    var bodyEncoded = json.encode(body);

    String url="https://fcm.googleapis.com/fcm/send";

    final response = await http.post(Uri.parse(url),headers: headers,body: bodyEncoded,encoding: Encoding.getByName('utf-8'));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }

  }



}