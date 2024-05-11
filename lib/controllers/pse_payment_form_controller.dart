
import 'package:dart_ipify/dart_ipify.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:himalayastoreapp/base/validator.dart';
import 'package:himalayastoreapp/controllers/cart_controller.dart';
import 'package:himalayastoreapp/data/repositories/pse_payment_form_repository.dart';
import 'package:himalayastoreapp/models/payment_models/pse_payment_send_model.dart';

import '../base/show_custom_message.dart';
import '../models/payment_models/banks_list_response_model.dart';

class PSEPaymentFormController extends GetxController{

  PSEPaymentFormRepo psePaymentRepo;

  PSEPaymentFormController({
    required this.psePaymentRepo
  });

  List<Bank> _banksList = [];
  List<Bank> get banksList => _banksList;

  Bank _currentSelectedBank = Bank();
  Bank get currentSelectedBank => _currentSelectedBank;

  String _docType = "CC";
  String get docType => _docType;

  TextEditingController tecDocNumber = TextEditingController();
  TextEditingController tecName = TextEditingController();
  TextEditingController tecLastName = TextEditingController();
  TextEditingController tecEmail = TextEditingController();
  TextEditingController tecPhone = TextEditingController();

  PSEPaymentSend _paymentSendData = PSEPaymentSend();
  PSEPaymentSend get paymentSendData => _paymentSendData;

  bool _isFinishFilledIn = false;
  bool get isFinishFilledIn => _isFinishFilledIn;

  Future<void> getBankList() async{

    Response response = await psePaymentRepo.getBankList();

    if(response.body["success"]){
      BanksListResponse banksListResponse = BanksListResponse.fromJson(response.body);
      _banksList = banksListResponse.data!;
      _currentSelectedBank = _banksList[0];
    }else{
      _banksList = [];
    }

    update();

  }

  void selectBank(Bank bank){
    _currentSelectedBank = bank;
    update();
  }

  void selectDocType(String docType){
    _docType = docType;
    update();
  }

  Future<bool> continuePSEPaymentProcess() async{

    if(tecDocNumber.text==""){
      showCustomSnackBar("Diligencie el número de documento");
      return false;
    }

    if(tecName.text==""){
      showCustomSnackBar("Diligencie su nombre");
      return false;
    }

    if(tecLastName.text==""){
      showCustomSnackBar("Diligencie su apellido");
      return false;
    }

    if(tecEmail.text==""){
      showCustomSnackBar("Diligencie su e-mail");
      return false;
    }

    if(!tecEmail.text.isValidEmail()){
      showCustomSnackBar("Ingrese un e-mail valido");
      return false;
    }

    if(tecPhone.text==""){
      showCustomSnackBar("Diligencie su número de teléfono");
      return false;
    }

    PSEPaymentSend psePaymentSend = PSEPaymentSend();
    psePaymentSend.bank = _currentSelectedBank.bankCode;
    psePaymentSend.value = "5000";
    psePaymentSend.docType = _docType;
    psePaymentSend.docNumber = tecDocNumber.text;
    psePaymentSend.name = tecName.text;
    psePaymentSend.lastName = tecLastName.text;
    psePaymentSend.email = tecEmail.text;
    psePaymentSend.cellPhone = tecPhone.text;
    psePaymentSend.ip = await Ipify.ipv4();
    psePaymentSend.urlResponse = "www.prueba.com";
    psePaymentSend.description = "Pago en tienda Fitness Himalaya";
    psePaymentSend.invoice = "Hima-${DateTime.now().millisecondsSinceEpoch.toString()}";
    psePaymentSend.currency = "COP";
    psePaymentSend.urlConfirmation = "www.pruebaconfirmacion.com";
    psePaymentSend.methodConfimation = "GET";
    psePaymentSend.extra1 = "";
    psePaymentSend.extra2 = "";
    psePaymentSend.extra3 = "";
    psePaymentSend.extra4 = "";
    psePaymentSend.extra5 = "";
    psePaymentSend.extra6 = "";
    psePaymentSend.extra7 = "";
    psePaymentSend.extra8 = "";
    psePaymentSend.extra9 = "";
    psePaymentSend.extra10 = "";

    int index = 1;
    Get.find<CartController>().getItems.forEach((cartModel) {

      index==1 ?
      psePaymentSend.extra1 = cartModel.name :
      index==2 ?
      psePaymentSend.extra2 = cartModel.name :
      index==3 ?
      psePaymentSend.extra3 = cartModel.name :
      index==4 ?
      psePaymentSend.extra4 = cartModel.name :
      index==5 ?
      psePaymentSend.extra5 = cartModel.name :
      index==6 ?
      psePaymentSend.extra6 = cartModel.name :
      index==7 ?
      psePaymentSend.extra7 = cartModel.name :
      index==8 ?
      psePaymentSend.extra8 = cartModel.name :
      index==9 ?
      psePaymentSend.extra9 = cartModel.name :
      psePaymentSend.extra10 = cartModel.name;

      index += 1;

    });

    _paymentSendData = psePaymentSend;

    _isFinishFilledIn = true;

    return _isFinishFilledIn;

  }

  void clearAfterFinish(){
    _isFinishFilledIn = false;
  }

}