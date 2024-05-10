
import 'dart:convert';

import 'package:get/get.dart';

import '../../utils/app_constants.dart';

class PaymentApi extends GetConnect implements GetxService{

  late String token;
  final String appBaseUrl;
  late String PUBLIC_KEY;
  late String PRIVATE_KEY;
  late Map<String,String> requestHeader;
  late Map<String,String> tokenRequestHeader;

  PaymentApi({required this.appBaseUrl}){
    baseUrl = appBaseUrl;
    timeout = Duration(seconds: 30);
    token = AppConstants.TOKEN;
    PUBLIC_KEY = "d0074d61f2bc58ee7821ca359a932ef0";
    PRIVATE_KEY = "fbc92aeea05696ffebae39502eddefee";
    requestHeader={
      'Content-type':'application/json; charset=UTF-8',
      'Authorization':'Bearer $token'
    };
    tokenRequestHeader={
      'Content-type':'application/json; charset=UTF-8',
      'Authorization':'Basic ${base64.encode(utf8.encode("$PUBLIC_KEY:$PRIVATE_KEY"))}'
    };


  }

  void updateHeader(String token){

    this.token = token;

    this.requestHeader={
      'Content-type':'application/json; charset=UTF-8',
      'Authorization':'Bearer $token'
    };
  }

  Future<Response> getData(String uri) async{

    try{
      Response response = await get(uri);
      return response;
    }catch(e){
      return Response(statusCode: 1, statusText: e.toString());
    }

  }

  Future<Response> getDataWithQuery(String uri, dynamic query) async{

    try{
      Response response = await get(uri,query: query);
      return response;
    }catch(e){
      return Response(statusCode: 1, statusText: e.toString());
    }

  }

  Future<Response> getToken(String uri) async{
    try{
      Response response = await post(uri, "", headers: tokenRequestHeader);
      return response;
    }catch(e){
      print(e.toString());
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> postData(String uri, dynamic body) async{
    try{
      Response response = await post(uri, body, headers: requestHeader);
      return response;
    }catch(e){
      print(e.toString());
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

}