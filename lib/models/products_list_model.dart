
class ProductsListModel {

  List<ProductModel> _productsList = [];
  List<ProductModel> get productsList => _productsList;


  ProductsListModel({required productsList}){
    _productsList = productsList;
  }

  ProductsListModel.fromJson(Map<String, dynamic> json) {
    if (json['ProductsList'] != null) {
      _productsList = <ProductModel>[];
      json['ProductsList'].forEach((v) {
        _productsList!.add(new ProductModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._productsList != null) {
      data['ProductsList'] = this._productsList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductModel {
  int? id;
  String? productName;
  String? productDescription;
  int? productPrice;
  String? productCategory;
  int? productStars;
  String? productImage;
  String? productImage2;
  String? mainTitle;
  String? introductionTitle;
  String? subTitle1;
  String? paragraph1;
  String? subTitle2;
  String? paragraph2;
  String? subTitle3;
  String? paragraph3;
  String? subTitle4;
  String? paragraph4;
  String? subTitle5;
  String? paragraph5;
  String? subTitle6;
  String? paragraph6;
  String? subTitle7;
  String? paragraph7;
  String? subTitle8;
  String? paragraph8;
  String? subTitle9;
  String? paragraph9;
  String? subTitle10;
  String? paragraph10;
  String? subTitle11;
  String? paragraph11;
  String? subTitle12;
  String? paragraph12;
  String? subTitle13;
  String? paragraph13;

  ProductModel(
      {this.id = 0,
        this.productName = "",
        this.productDescription = "",
        this.productPrice = 0,
        this.productCategory = "",
        this.productStars = 0,
        this.productImage = "",
        this.productImage2 = "",
        this.mainTitle = "",
        this.introductionTitle = "",
        this.subTitle1 = "",
        this.paragraph1 = "",
        this.subTitle2 = "",
        this.paragraph2 = "",
        this.subTitle3 = "",
        this.paragraph3 = "",
        this.subTitle4 = "",
        this.paragraph4 = "",
        this.subTitle5 = "",
        this.paragraph5 = "",
        this.subTitle6 = "",
        this.paragraph6 = "",
        this.subTitle7 = "",
        this.paragraph7 = "",
        this.subTitle8 = "",
        this.paragraph8 = "",
        this.subTitle9 = "",
        this.paragraph9 = "",
        this.subTitle10 = "",
        this.paragraph10 = "",
        this.subTitle11 = "",
        this.paragraph11 = "",
        this.subTitle12 = "",
        this.paragraph12 = "",
        this.subTitle13 = "",
        this.paragraph13 = ""
      });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['product_name'];
    productDescription = json['product_description'];
    productPrice = json['product_price'];
    productCategory = json['product_category'];
    productStars = json['product_stars'];
    productImage = json['product_image'];
    productImage2 = json['Product_Image_2'];
    mainTitle = json['Main_Title'];
    introductionTitle = json['Introduction_Title'];
    subTitle1 = json['Sub_Title_1'];
    paragraph1 = json['Paragraph_1'];
    subTitle2 = json['Sub_Title_2'];
    paragraph2 = json['Paragraph_2'];
    subTitle3 = json['Sub_Title_3'];
    paragraph3 = json['Paragraph_3'];
    subTitle4 = json['Sub_Title_4'];
    paragraph4 = json['Paragraph_4'];
    subTitle5 = json['Sub_Title_5'];
    paragraph5 = json['Paragraph_5'];
    subTitle6 = json['Sub_Title_6'];
    paragraph6 = json['Paragraph_6'];
    subTitle7 = json['Sub_Title_7'];
    paragraph7 = json['Paragraph_7'];
    subTitle8 = json['Sub_Title_8'];
    paragraph8 = json['Paragraph_8'];
    subTitle9 = json['Sub_Title_9'];
    paragraph9 = json['Paragraph_9'];
    subTitle10 = json['Sub_Title_10'];
    paragraph10 = json['Paragraph_10'];
    subTitle11 = json['Sub_Title_11'];
    paragraph11 = json['Paragraph_11'];
    subTitle12 = json['Sub_Title_12'];
    paragraph12 = json['Paragraph_12'];
    subTitle13 = json['Sub_Title_13'];
    paragraph13 = json['Paragraph_13'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_name'] = this.productName;
    data['product_description'] = this.productDescription;
    data['product_price'] = this.productPrice;
    data['product_category'] = this.productCategory;
    data['product_stars'] = this.productStars;
    data['product_image'] = this.productImage;
    data['Product_Image_2'] = this.productImage2;
    data['Main_Title'] = this.mainTitle;
    data['Introduction_Title'] = this.introductionTitle;
    data['Sub_Title_1'] = this.subTitle1;
    data['Paragraph_1'] = this.paragraph1;
    data['Sub_Title_2'] = this.subTitle2;
    data['Paragraph_2'] = this.paragraph2;
    data['Sub_Title_3'] = this.subTitle3;
    data['Paragraph_3'] = this.paragraph3;
    data['Sub_Title_4'] = this.subTitle4;
    data['Paragraph_4'] = this.paragraph4;
    data['Sub_Title_5'] = this.subTitle5;
    data['Paragraph_5'] = this.paragraph5;
    data['Sub_Title_6'] = this.subTitle6;
    data['Paragraph_6'] = this.paragraph6;
    data['Sub_Title_7'] = this.subTitle7;
    data['Paragraph_7'] = this.paragraph7;
    data['Sub_Title_8'] = this.subTitle8;
    data['Paragraph_8'] = this.paragraph8;
    data['Sub_Title_9'] = this.subTitle9;
    data['Paragraph_9'] = this.paragraph9;
    data['Sub_Title_10'] = this.subTitle10;
    data['Paragraph_10'] = this.paragraph10;
    data['Sub_Title_11'] = this.subTitle11;
    data['Paragraph_11'] = this.paragraph11;
    data['Sub_Title_12'] = this.subTitle12;
    data['Paragraph_12'] = this.paragraph12;
    data['Sub_Title_13'] = this.subTitle13;
    data['Paragraph_13'] = this.paragraph13;
    return data;
  }
}