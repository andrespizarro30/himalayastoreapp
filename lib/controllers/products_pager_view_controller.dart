
import 'package:get/get.dart';

import '../data/repositories/products_repository.dart';
import '../models/products_category_list_model.dart';
import '../models/products_list_model.dart';

class ProductPagerViewController extends GetxController{

  final ProductsRepository productsRepository;

  ProductPagerViewController({required this.productsRepository});

  Map<String,List<ProductModel>> _productMap={};
  Map<String,List<ProductModel>> get productMap => _productMap;

  List<ProductModel> _productsList=[];
  List<ProductModel> get productsList => _productsList;

  Map<String,bool> _isLoaded = {};
  Map<String,bool> get isLoaded => _isLoaded;

  int _productIndexSelected = -1;
  int get productIndexSelected => _productIndexSelected;

  Future<void> getProductsListByCategory(String product_category)async{

    if(!_isLoaded.containsKey(product_category)){
      _isLoaded.putIfAbsent(product_category, (){
        return true;
      });
    }else{
      _isLoaded.update(product_category, (value){
        return true;
      });
    }

    update();

    Response response = await productsRepository.getProductsListByCategory(product_category);

    if(response.statusCode == 200){
      _productsList=[];
      _productsList.addAll(ProductsListModel.fromJson(response.body).productsList);

      if(!_productMap.containsKey(product_category)){
        _productMap.putIfAbsent(product_category, (){
          return _productsList;
        });
      }else{
        _productMap.update(product_category, (value){
          return _productsList;
        });
      }

    }else{

    }

    if(!_isLoaded.containsKey(product_category)){
      _isLoaded.putIfAbsent(product_category, (){
        return false;
      });
    }else{
      _isLoaded.update(product_category, (value){
        return false;
      });
    }

    update();

  }

  Future<void> clearIsLoadedMap() async{

    _productMap.clear();

    _isLoaded = {};

  }

  void selectCurrentProduct(int index){
    _productIndexSelected = index;
    update();
  }

  void unSelectCurrentProduct(){
    _productIndexSelected = -1;
  }

}