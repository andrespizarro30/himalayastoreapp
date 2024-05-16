import 'dart:convert';


import 'package:himalayastoreapp/models/card_info_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/app_constants.dart';

class CreditCardRepository{

  SharedPreferences sharedPreferences;

  CreditCardRepository({
    required this.sharedPreferences
  });

  List<String> cardsSaved = [];

  bool saveCreditCardInfo(CardInfo cardInfo){

    try{
      if(sharedPreferences.containsKey(AppConstants.SAVED_CREDIT_CARDS)){

        cardsSaved = [];

        cardsSaved = sharedPreferences.getStringList(AppConstants.SAVED_CREDIT_CARDS)!;

        cardsSaved.add(json.encode(cardInfo));

        sharedPreferences.remove(AppConstants.SAVED_CREDIT_CARDS);

        sharedPreferences.setStringList(AppConstants.SAVED_CREDIT_CARDS, cardsSaved);

      }else{

        cardsSaved.add(json.encode(cardInfo));

        sharedPreferences.setStringList(AppConstants.SAVED_CREDIT_CARDS, cardsSaved);

      }

      return true;

    }catch(e){
      return false;
    }

  }

  void deleteCreditCard(CardInfo cardInfo){

    if(sharedPreferences.containsKey(AppConstants.SAVED_CREDIT_CARDS)){

      List<CardInfo> cardInfoList = [];

      List<String> savedCardsStringList = sharedPreferences.getStringList(AppConstants.SAVED_CREDIT_CARDS)!;

      savedCardsStringList.forEach((cardInfoString) {
        cardInfoList.add(CardInfo.fromJson(json.decode(cardInfoString)));
      });

      cardsSaved = [];

      cardInfoList.forEach((dataCard) {
        if(dataCard.cardNumber != cardInfo.cardNumber){
          cardsSaved.add(json.encode(dataCard));
        }
      });

      sharedPreferences.remove(AppConstants.SAVED_CREDIT_CARDS);

      sharedPreferences.setStringList(AppConstants.SAVED_CREDIT_CARDS, cardsSaved);

    }

  }

  List<CardInfo> getSavedCreditCards(){

    List<CardInfo> cardInfoList = [];

    if(sharedPreferences.containsKey(AppConstants.SAVED_CREDIT_CARDS)){

      List<String> savedCardsStringList = sharedPreferences.getStringList(AppConstants.SAVED_CREDIT_CARDS)!;

      savedCardsStringList.forEach((cardInfoString) {
        cardInfoList.add(CardInfo.fromJson(json.decode(cardInfoString)));
      });

    }

    return cardInfoList;

  }

  void selectPaymentMethod(String paymentMethod){

    List<CardInfo> cardInfoList = [];

    if(sharedPreferences.containsKey(AppConstants.SAVED_CREDIT_CARDS)){

      List<String> savedCardsStringList = sharedPreferences.getStringList(AppConstants.SAVED_CREDIT_CARDS)!;

      savedCardsStringList.forEach((cardInfoString) {
        cardInfoList.add(CardInfo.fromJson(json.decode(cardInfoString)));
      });

      if(paymentMethod==AppConstants.PSE_PAYMENT_METHOD){
        sharedPreferences.remove(AppConstants.CURRENT_SELECTED_PAYMENT);
        CardInfo cardInfo = CardInfo();
        cardInfo.cardNumber = AppConstants.PSE_PAYMENT_METHOD;
        sharedPreferences.setString(AppConstants.CURRENT_SELECTED_PAYMENT, json.encode(cardInfo.toJson()));
      }else{
        cardInfoList.forEach((dataCard) {
          if(dataCard.cardNumber == paymentMethod){
            sharedPreferences.remove(AppConstants.CURRENT_SELECTED_PAYMENT);
            sharedPreferences.setString(AppConstants.CURRENT_SELECTED_PAYMENT, json.encode(dataCard.toJson()));
          }
        });
      }

    }else{
      if(paymentMethod==AppConstants.PSE_PAYMENT_METHOD){
        sharedPreferences.remove(AppConstants.CURRENT_SELECTED_PAYMENT);
        CardInfo cardInfo = CardInfo();
        cardInfo.cardNumber = AppConstants.PSE_PAYMENT_METHOD;
        sharedPreferences.setString(AppConstants.CURRENT_SELECTED_PAYMENT, json.encode(cardInfo.toJson()));
      }else{
        cardInfoList.forEach((dataCard) {
          if(dataCard.cardNumber == paymentMethod){
            sharedPreferences.remove(AppConstants.CURRENT_SELECTED_PAYMENT);
            sharedPreferences.setString(AppConstants.CURRENT_SELECTED_PAYMENT, json.encode(dataCard.toJson()));
          }
        });
      }
    }

  }

  CardInfo getCurrentSelectedPaymentMethod(){

    CardInfo cardInfo = CardInfo();

    if(sharedPreferences.containsKey(AppConstants.CURRENT_SELECTED_PAYMENT)){
      String cardInfoString = sharedPreferences.getString(AppConstants.CURRENT_SELECTED_PAYMENT)!;
      cardInfo = CardInfo.fromJson(json.decode(cardInfoString));
    }else{
      CardInfo cardInfo = CardInfo();
      cardInfo.cardNumber = AppConstants.PSE_PAYMENT_METHOD;
      sharedPreferences.setString(AppConstants.CURRENT_SELECTED_PAYMENT, json.encode(cardInfo.toJson()));
    }

    return cardInfo;

  }

}