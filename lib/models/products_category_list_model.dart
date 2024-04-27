class ProductsCategoriesListModel {

  List<ProductsCategories> _productsCategoriesList = [];
  List<ProductsCategories> get productsCategoriesList=>_productsCategoriesList;

  ProductsCategoriesListModel({required productsCategoriesList}){
    _productsCategoriesList = productsCategoriesList;
  }

  ProductsCategoriesListModel.fromJson(Map<String, dynamic> json) {
    if (json['ProductsCategoriesList'] != null) {
      _productsCategoriesList = <ProductsCategories>[];
      json['ProductsCategoriesList'].forEach((v) {
        _productsCategoriesList!.add(new ProductsCategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._productsCategoriesList != null) {
      data['ProductsCategoriesList'] =
          this._productsCategoriesList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductsCategories {
  String? productCategory;

  ProductsCategories({this.productCategory});

  ProductsCategories.fromJson(Map<String, dynamic> json) {
    productCategory = json['product_category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_category'] = this.productCategory;
    return data;
  }
}