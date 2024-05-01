
import 'package:get/get.dart';

import '../../utils/app_constants.dart';
import '../apis/api_client.dart';

class ProductsRepository extends GetxService{

  final ApiClient apiClient;

  ProductsRepository({required this.apiClient});

  Future<Response> getAllProductsList() async {

    return await apiClient.getData(AppConstants.ALL_PRODUCTS_LIST);

  }

  Future<Response> getProductsListByCategory(String product_category) async {

    Map<String,String> data = {};

    data['product_category'] = product_category;

    return await apiClient.getDataWithQuery(AppConstants.PRODUCTS_LIST_BY_CATEGORY,data);

  }

  Future<Response> getProductsCategoriesList() async {

    return await apiClient.getData(AppConstants.PRODUCTS_CATEGORIES_LIST);

  }

  Future<Response> getDeliveryReceiverData() async {

    Map<String,String> data = {};

    data['UserUserType'] = "Tecnico";

    return await apiClient.getDataWithQuery(AppConstants.DELIVERY_RECEIVER_DATA,data);

  }

}