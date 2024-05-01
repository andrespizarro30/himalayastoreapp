class DeliveriesDetailsList {

  List<DeliveriesDetail>? _deliveriesDetailsList;
  List<DeliveriesDetail>? get deliveriesDetailsList => _deliveriesDetailsList;

  DeliveriesDetailsList({required deliveriesDetailsList}){
    _deliveriesDetailsList=deliveriesDetailsList;
  }

  DeliveriesDetailsList.fromJson(Map<String, dynamic> json) {
    if (json['DeliveriesDetailsList'] != null) {
      _deliveriesDetailsList = <DeliveriesDetail>[];
      json['DeliveriesDetailsList'].forEach((v) {
        _deliveriesDetailsList!.add(new DeliveriesDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._deliveriesDetailsList != null) {
      data['DeliveriesDetailsList'] =
          this._deliveriesDetailsList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DeliveriesDetail {
  int? id;
  String? deliveryId;
  String? deliveryUID;
  String? productCategory;
  String? productName;
  int? productPrice;
  int? productQty;
  String? productSent;

  DeliveriesDetail(
      {this.id,
        this.deliveryId,
        this.deliveryUID,
        this.productCategory,
        this.productName,
        this.productPrice,
        this.productQty,
        this.productSent});

  DeliveriesDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    deliveryId = json['DeliveryId'];
    deliveryUID = json['DeliveryUID'];
    productCategory = json['ProductCategory'];
    productName = json['ProductName'];
    productPrice = json['ProductPrice'];
    productQty = json['ProductQty'];
    productSent = json['ProductSent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['DeliveryId'] = this.deliveryId;
    data['DeliveryUID'] = this.deliveryUID;
    data['ProductCategory'] = this.productCategory;
    data['ProductName'] = this.productName;
    data['ProductPrice'] = this.productPrice;
    data['ProductQty'] = this.productQty;
    data['ProductSent'] = this.productSent;
    return data;
  }
}