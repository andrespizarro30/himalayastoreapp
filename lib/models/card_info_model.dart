class CardInfo {
  String? cardHolderName;
  String? cardHolderLastName;
  String? cardNumber;
  String? expYear;
  String? expMonth;
  String? cvv;

  CardInfo(
      {this.cardHolderName = "",
        this.cardHolderLastName = "",
        this.cardNumber = "",
        this.expYear = "",
        this.expMonth = "",
        this.cvv = ""
      });

  CardInfo.fromJson(Map<String, dynamic> json) {
    cardHolderName = json['cardHolderFullName'];
    cardHolderLastName = json['cardHolderLastName'];
    cardNumber = json['cardNumber'];
    expYear = json['expYear'];
    expMonth = json['expMonth'];
    cvv = json['cvv'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cardHolderFullName'] = this.cardHolderName;
    data['cardHolderLastName'] = this.cardHolderLastName;
    data['cardNumber'] = this.cardNumber;
    data['expYear'] = this.expYear;
    data['expMonth'] = this.expMonth;
    data['cvv'] = this.cvv;
    return data;
  }
}