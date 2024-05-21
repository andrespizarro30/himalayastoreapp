class UsersListModel {

  List<UsersModel> _mainUsersList = [];
  List<UsersModel> get mainUsersList => _mainUsersList;

  UsersListModel({required mainUsersList}){
    _mainUsersList = _mainUsersList;
  }

  UsersListModel.fromJson(Map<String, dynamic> json) {
    if (json['MainUsersList'] != null) {
      _mainUsersList = <UsersModel>[];
      json['MainUsersList'].forEach((v) {
        _mainUsersList!.add(new UsersModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._mainUsersList != null) {
      data['MainUsersList'] =
          this._mainUsersList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UsersModel {
  int? id;
  String? userName;
  String? userPhone;
  String? userUserType;
  String? userEmail;
  String? userUID;
  String? userToken;
  String? promoCode;
  String? promoCodeDueDate;
  String? promoCodeDueText;

  UsersModel(
      {this.id = 0,
        this.userName = "",
        this.userPhone = "",
        this.userUserType = "",
        this.userEmail = "",
        this.userUID = "",
        this.userToken = "",
        this.promoCode = "",
        this.promoCodeDueDate = "",
        this.promoCodeDueText = "",
      });

  UsersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['UserName'];
    userPhone = json['UserPhone'];
    userUserType = json['UserUserType'];
    userEmail = json['UserEmail'];
    userUID = json['UserUID'];
    userToken = json['UserToken'];
    promoCode = json['PromoCode'];
    promoCodeDueDate = json['PromoCodeDueDate'];
    promoCodeDueText = json['PromoCodeDueText'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['UserName'] = this.userName;
    data['UserPhone'] = this.userPhone;
    data['UserUserType'] = this.userUserType;
    data['UserEmail'] = this.userEmail;
    data['UserUID'] = this.userUID;
    data['UserToken'] = this.userToken;
    data['PromoCode'] = this.promoCode;
    data['PromoCodeDueDate'] = this.promoCodeDueDate;
    data['PromoCodeDueText'] = this.promoCodeDueText;
    return data;
  }
}