class PSEPaymentSend {
  String? bank;
  String? value;
  String? docType;
  String? docNumber;
  String? name;
  String? lastName;
  String? email;
  String? cellPhone;
  String? ip;
  String? urlResponse;
  String? description;
  String? invoice;
  String? currency;
  String? urlConfirmation;
  String? methodConfimation;
  String? extra1;
  String? extra2;
  String? extra3;
  String? extra4;
  String? extra5;
  String? extra6;
  String? extra7;
  String? extra8;
  String? extra9;
  String? extra10;

  PSEPaymentSend(
      {this.bank = "",
        this.value = "",
        this.docType = "",
        this.docNumber = "",
        this.name = "",
        this.lastName = "",
        this.email = "",
        this.cellPhone = "",
        this.ip = "",
        this.urlResponse = "",
        this.description = "",
        this.invoice = "",
        this.currency = "",
        this.urlConfirmation = "",
        this.methodConfimation = "",
        this.extra1 = "",
        this.extra2 = "",
        this.extra3 = "",
        this.extra4 = "",
        this.extra5 = "",
        this.extra6 = "",
        this.extra7 = "",
        this.extra8 = "",
        this.extra9 = "",
        this.extra10 = "",
      });

  PSEPaymentSend.fromJson(Map<String, dynamic> json) {
    bank = json['bank'];
    value = json['value'];
    docType = json['docType'];
    docNumber = json['docNumber'];
    name = json['name'];
    lastName = json['lastName'];
    email = json['email'];
    cellPhone = json['cellPhone'];
    ip = json['ip'];
    urlResponse = json['urlResponse'];
    description = json['description'];
    invoice = json['invoice'];
    currency = json['currency'];
    urlConfirmation = json['urlConfirmation'];
    methodConfimation = json['methodConfimation'];
    extra1 = json['extra1'];
    extra2 = json['extra2'];
    extra3 = json['extra3'];
    extra4 = json['extra4'];
    extra5 = json['extra5'];
    extra6 = json['extra6'];
    extra7 = json['extra7'];
    extra8 = json['extra8'];
    extra9 = json['extra9'];
    extra10 = json['extra10'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bank'] = this.bank;
    data['value'] = this.value;
    data['docType'] = this.docType;
    data['docNumber'] = this.docNumber;
    data['name'] = this.name;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['cellPhone'] = this.cellPhone;
    data['ip'] = this.ip;
    data['urlResponse'] = this.urlResponse;
    data['description'] = this.description;
    data['invoice'] = this.invoice;
    data['currency'] = this.currency;
    data['urlConfirmation'] = this.urlConfirmation;
    data['methodConfimation'] = this.methodConfimation;
    data['extra1'] = this.extra1;
    data['extra2'] = this.extra2;
    data['extra3'] = this.extra3;
    data['extra4'] = this.extra4;
    data['extra5'] = this.extra5;
    data['extra6'] = this.extra6;
    data['extra7'] = this.extra7;
    data['extra8'] = this.extra8;
    data['extra9'] = this.extra9;
    data['extra10'] = this.extra10;
    return data;
  }
}