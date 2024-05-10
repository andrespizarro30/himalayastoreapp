class CreditCardPaymentSend {
  String? value;
  String? docType;
  String? docNumber;
  String? name;
  String? lastName;
  String? email;
  String? cellPhone;
  String? phone;
  String? cardNumber;
  String? cardExpYear;
  String? cardExpMonth;
  String? cardCvc;
  String? dues;

  CreditCardPaymentSend(
      {this.value = "",
        this.docType = "",
        this.docNumber = "",
        this.name = "",
        this.lastName = "",
        this.email = "",
        this.cellPhone = "",
        this.phone = "",
        this.cardNumber = "",
        this.cardExpYear = "",
        this.cardExpMonth = "",
        this.cardCvc = "",
        this.dues = ""});

  CreditCardPaymentSend.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    docType = json['docType'];
    docNumber = json['docNumber'];
    name = json['name'];
    lastName = json['lastName'];
    email = json['email'];
    cellPhone = json['cellPhone'];
    phone = json['phone'];
    cardNumber = json['cardNumber'];
    cardExpYear = json['cardExpYear'];
    cardExpMonth = json['cardExpMonth'];
    cardCvc = json['cardCvc'];
    dues = json['dues'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['docType'] = this.docType;
    data['docNumber'] = this.docNumber;
    data['name'] = this.name;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['cellPhone'] = this.cellPhone;
    data['phone'] = this.phone;
    data['cardNumber'] = this.cardNumber;
    data['cardExpYear'] = this.cardExpYear;
    data['cardExpMonth'] = this.cardExpMonth;
    data['cardCvc'] = this.cardCvc;
    data['dues'] = this.dues;
    return data;
  }
}