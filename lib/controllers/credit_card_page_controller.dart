
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:himalayastoreapp/models/card_info_model.dart';

import '../base/show_custom_message.dart';
import '../data/repositories/credit_card_reposity.dart';
import '../models/user_model.dart';
import '../utils/dimensions.dart';
import 'cart_controller.dart';

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

  bool _isOpenCouponSelectContainer = false;
  bool get isOpenCouponSelectContainer => _isOpenCouponSelectContainer;

  double _couponSelectContainerHeight = 0;
  double get couponSelectContainerHeight => _couponSelectContainerHeight;

  TextEditingController tecCouponText = TextEditingController();

  bool _couponUsed = false;
  bool get couponUsed => _couponUsed;

  double _couponValue = 0;
  double get couponValue => _couponValue;

  List<UsersModel> _currentUserData=[];
  List<UsersModel> get currentUserData => _currentUserData;

  bool _isCouponTextEmpty = false;
  bool get isCouponTextEmpty => _isCouponTextEmpty;

  double _totalCost = 0;
  double get totalCost => _totalCost;


  void openDuesSelectContainer(){

    _isOpenDuesSelectContainer = !_isOpenDuesSelectContainer;

    _duesSelectContainerHeight = _isOpenDuesSelectContainer ? Dimensions.screenHeight * 0.3 : 0;

    update();

  }

  void openCouponSelectContainer(){

    _isOpenCouponSelectContainer = !_isOpenCouponSelectContainer;

    _couponSelectContainerHeight = _isOpenCouponSelectContainer ? Dimensions.screenHeight * 0.6 : 0;

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

  void onChangeTECCoupon(String value){
    if(value.isNotEmpty){
      _isCouponTextEmpty = true;
    }else{
      _isCouponTextEmpty = false;
    }
    tecCouponText.text = value.toUpperCase();
    update();
  }

  Future<void> getCouponData() async{

    Response response = await creditCardRepository.getCouponData(tecCouponText.text);
    _currentUserData = [];
    if(response.statusCode == 200){
      _currentUserData.addAll(UsersListModel.fromJson(response.body).mainUsersList);
    }else{
      _currentUserData=[];
    }

    update();

  }

  Future<void> deletePromoCodeUsed() async {

    Response response = await creditCardRepository.deletePromoCodeUsed();

    if(response.statusCode == 200){
      if(response.body["PromoCodeUsed"] == "OK"){
        String a = "";
      }
    }else{
      _currentUserData=[];
    }

    update();

  }

  void usedCoupon(String promoCode){
    _couponUsed = true;
    String promoCodeStr =  promoCode.substring(promoCode.length-2,promoCode.length);
    _couponValue = Get.find<CartController>().totalAmount * (double.parse(promoCodeStr)/100);
    calculateFinalValue();
  }

  void calculateFinalValue(){
    _totalCost = Get.find<CartController>().totalAmount + 15000 - _couponValue;
    update();
  }

  void clearData(){
    _couponUsed = false;
    _couponValue = 0;
    _currentUserData = [];
    tecCouponText.text = "";
  }

}