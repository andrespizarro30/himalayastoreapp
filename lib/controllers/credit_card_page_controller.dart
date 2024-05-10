
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:himalayastoreapp/models/card_info_model.dart';

import '../base/show_custom_message.dart';
import '../data/repositories/credit_card_reposity.dart';
import '../utils/dimensions.dart';

class CreditCardController extends GetxController{

  CreditCardRepository creditCardRepository;

  CreditCardController({
    required this.creditCardRepository
  });

  TextEditingController tecCardHolderName = TextEditingController();
  TextEditingController tecCardHolderLastName = TextEditingController();
  TextEditingController tecCardNumber = TextEditingController();
  TextEditingController tecValidThru = TextEditingController();
  TextEditingController tecCVVNumber = TextEditingController();

  bool _isCreditCardSaved = false;
  bool get isCreditCardSaved => _isCreditCardSaved;

  List<CardInfo> _cardInfoList = [];
  List<CardInfo> get cardInfoList => _cardInfoList;

  String _selectedPayMethod = "";
  String get selectedPayMethod => _selectedPayMethod;

  CardInfo _currentSelectedPaymentMethod = CardInfo();
  CardInfo get currentSelectedPaymentMethod => _currentSelectedPaymentMethod;

  bool _isOpenDuesSelectContainer = false;
  bool get isOpenDuesSelectContainer => _isOpenDuesSelectContainer;

  double _duesSelectContainerHeight = 0;
  double get duesSelectContainerHeight => _duesSelectContainerHeight;

  int _duesNumber = 1;
  int get duesNumber => _duesNumber;

  void openDuesSelectContainer(){

    _isOpenDuesSelectContainer = !_isOpenDuesSelectContainer;

    _duesSelectContainerHeight = _isOpenDuesSelectContainer ? Dimensions.screenHeight * 0.3 : 0;

    update();

  }

  void onChangeTECCardHolderName(String value){
    tecCardHolderName.text = value.toUpperCase();
    update();
  }

  void onChangeTECCardHolderLastName(String value){
    tecCardHolderLastName.text = value.toUpperCase();
    update();
  }

  void onChangeTECCardNumber(String value){
    tecCardNumber.text = value;
    update();
  }

  void onChangeTECValidThru(String value){
    tecValidThru.text = value;
    update();
  }

  void onChangeTECCVVNumber(String value){
    tecCVVNumber.text = value;
    update();
  }

  void saveCreditCardInfo(){

    if(tecCardHolderName.text==""){
      showCustomSnackBar("Diligencie el nombre en la tarjeta");
      return;
    }

    if(tecCardHolderLastName.text==""){
      showCustomSnackBar("Diligencie el apellido en la tarjeta");
      return;
    }

    if(tecCardNumber.text==""){
      showCustomSnackBar("Diligencie el número de la tarjeta");
      return;
    }

    if(tecValidThru.text==""){
      showCustomSnackBar("Diligencie la fecha de vencimiento");
      return;
    }

    if(tecCVVNumber.text==""){
      showCustomSnackBar("Diligencie el código de seguridad");
      return;
    }


    CardInfo cardInfo = CardInfo();
    cardInfo.cardHolderName = tecCardHolderName.text.toUpperCase();
    cardInfo.cardHolderLastName = tecCardHolderLastName.text.toUpperCase();
    cardInfo.cardNumber = tecCardNumber.text.replaceAll("-", "");
    cardInfo.expYear = tecValidThru.text.split("/")[1];
    cardInfo.expMonth = tecValidThru.text.split("/")[0];
    cardInfo.cvv = tecCVVNumber.text;

    _isCreditCardSaved = creditCardRepository.saveCreditCardInfo(cardInfo);

    getSavedCreditCards();

  }

  void deleteCreditCard(CardInfo cardInfo){
    creditCardRepository.deleteCreditCard(cardInfo);
    getSavedCreditCards();
  }

  void getSavedCreditCards(){
    _cardInfoList = [];
    _cardInfoList = creditCardRepository.getSavedCreditCards();
    update();
  }

  void clearCreditCardSaved(){
    _isCreditCardSaved = false;
    tecCardHolderName.text="";
    tecCardHolderLastName.text="";
    tecCardNumber.text="";
    tecValidThru.text="";
    tecCVVNumber.text="";
  }

  void selectPaymentMethod(String paymentMethod){
    creditCardRepository.selectPaymentMethod(paymentMethod);
    _selectedPayMethod = paymentMethod;
    getCurrentSelectedPaymentMethod();
  }

  void getCurrentSelectedPaymentMethod(){
    _currentSelectedPaymentMethod = creditCardRepository.getCurrentSelectedPaymentMethod();
    update();
  }

  void selectDuesNumber(int dues){
    _duesNumber = dues;
    update();
  }

}