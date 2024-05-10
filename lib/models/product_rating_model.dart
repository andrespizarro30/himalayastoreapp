class RatingProductList {

  List<RatingProduct> _ratingProduct = [];
  List<RatingProduct> get ratingProduct => _ratingProduct;


  RatingProductList({ratingProduct}){
    this._ratingProduct = ratingProduct;
  }

  RatingProductList.fromJson(Map<String, dynamic> json) {
    if (json['RatingProductList'] != null) {
      _ratingProduct = <RatingProduct>[];
      json['RatingProductList'].forEach((v) {
        _ratingProduct!.add(new RatingProduct.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._ratingProduct != null) {
      data['RatingProductList'] =
          this._ratingProduct!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RatingProduct {
  int? no;
  int? productId;
  int? productStars;
  String? productComment;
  String? buyerUid;
  String? buyerName;
  String? deliveryId;

  RatingProduct(
      {this.no = 0,
        this.productId = 0,
        this.productStars = 0,
        this.productComment = "",
        this.buyerUid = "",
        this.buyerName = "",
        this.deliveryId = ""
      });

  RatingProduct.fromJson(Map<String, dynamic> json) {
    no = json['no'];
    productId = json['product_id'];
    productStars = json['product_stars'];
    productComment = json['product_comment'];
    buyerUid = json['buyer_uid'];
    buyerName = json['buyer_name'];
    deliveryId = json['deliveryId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['no'] = this.no;
    data['product_id'] = this.productId;
    data['product_stars'] = this.productStars;
    data['product_comment'] = this.productComment;
    data['buyer_uid'] = this.buyerUid;
    data['buyer_name'] = this.buyerName;
    data['deliveryId'] = this.deliveryId;
    return data;
  }
}