class DeliveriesList {

  List<Deliveries>? _deliveriesList;
  List<Deliveries>? get deliveriesList => _deliveriesList;


  DeliveriesList({required deliveriesList}){
    _deliveriesList=deliveriesList;
  }

  DeliveriesList.fromJson(Map<String, dynamic> json) {
    if (json['DeliveriesList'] != null) {
      _deliveriesList = <Deliveries>[];
      json['DeliveriesList'].forEach((v) {
        _deliveriesList!.add(new Deliveries.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._deliveriesList != null) {
      data['DeliveriesList'] =
          this._deliveriesList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Deliveries {
  int? id;
  String? deliveryUserName;
  String? deliveryUID;
  String? deliveryAddress;
  String? deliveryDetailAddress;
  String? deliveryReferenceAddress;
  String? deliveryCity;
  String? deliveryPosition;
  String? deliveryDate;
  String? deliveryToken;
  String? deliveryId;
  String? deliverySent;

  Deliveries(
      {this.id,
        this.deliveryUserName,
        this.deliveryUID,
        this.deliveryAddress,
        this.deliveryDetailAddress,
        this.deliveryReferenceAddress,
        this.deliveryCity,
        this.deliveryPosition,
        this.deliveryDate,
        this.deliveryToken,
        this.deliveryId,
        this.deliverySent});

  Deliveries.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    deliveryUserName = json['DeliveryUserName'];
    deliveryUID = json['DeliveryUID'];
    deliveryAddress = json['DeliveryAddress'];
    deliveryDetailAddress = json['DeliveryDetailAddress'];
    deliveryReferenceAddress = json['DeliveryReferenceAddress'];
    deliveryCity = json['DeliveryCity'];
    deliveryPosition = json['DeliveryPosition'];
    deliveryDate = json['DeliveryDate'];
    deliveryToken = json['DeliveryToken'];
    deliveryId = json['DeliveryId'];
    deliverySent = json['DeliverySent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['DeliveryUserName'] = this.deliveryUserName;
    data['DeliveryUID'] = this.deliveryUID;
    data['DeliveryAddress'] = this.deliveryAddress;
    data['DeliveryDetailAddress'] = this.deliveryDetailAddress;
    data['DeliveryReferenceAddress'] = this.deliveryReferenceAddress;
    data['DeliveryCity'] = this.deliveryCity;
    data['DeliveryPosition'] = this.deliveryPosition;
    data['DeliveryDate'] = this.deliveryDate;
    data['DeliveryToken'] = this.deliveryToken;
    data['DeliveryId'] = this.deliveryId;
    data['DeliverySent'] = this.deliverySent;
    return data;
  }
}