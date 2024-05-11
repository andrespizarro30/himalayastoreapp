class BanksListResponse {

  bool? success;
  String? titleResponse;
  String? textResponse;
  String? lastAction;
  List<Bank>? data;

  BanksListResponse(
      {this.success,
        this.titleResponse,
        this.textResponse,
        this.lastAction,
        this.data});

  BanksListResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    titleResponse = json['titleResponse'];
    textResponse = json['textResponse'];
    lastAction = json['lastAction'];
    if (json['data'] != null) {
      data = <Bank>[];
      json['data'].forEach((v) {
        data!.add(new Bank.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['titleResponse'] = this.titleResponse;
    data['textResponse'] = this.textResponse;
    data['lastAction'] = this.lastAction;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Bank {
  String? bankCode;
  String? bankName;

  Bank({this.bankCode, this.bankName});

  Bank.fromJson(Map<String, dynamic> json) {
    bankCode = json['bankCode'].toString();
    bankName = json['bankName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bankCode'] = this.bankCode;
    data['bankName'] = this.bankName;
    return data;
  }
}