
import 'package:get/get.dart';

import '../../utils/app_constants.dart';
import '../apis/payment_api.dart';

class PSEPaymentFormRepo{

  final PaymentApi paymentApi;

  PSEPaymentFormRepo({
    required this.paymentApi
  });

  Future<Response> getBankList() async{
    return await paymentApi.getData(AppConstants.BANK_LIST);
  }

}