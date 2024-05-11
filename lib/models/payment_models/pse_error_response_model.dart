class PSEErrorTransaction {
  bool? success;
  String? titleResponse;
  String? textResponse;
  String? lastAction;
  Data? data;

  PSEErrorTransaction(
      {this.success,
        this.titleResponse,
        this.textResponse,
        this.lastAction,
        this.data});

  PSEErrorTransaction.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    titleResponse = json['titleResponse'];
    textResponse = json['textResponse'];
    lastAction = json['lastAction'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['titleResponse'] = this.titleResponse;
    data['textResponse'] = this.textResponse;
    data['lastAction'] = this.lastAction;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  Error? error;

  Data({this.error});

  Data.fromJson(Map<String, dynamic> json) {
    error = json['error'] != null ? new Error.fromJson(json['error']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.error != null) {
      data['error'] = this.error!.toJson();
    }
    return data;
  }
}

class Error {
  int? totalerrores;
  List<Errores>? errores;
  String? idfactura;

  Error({this.totalerrores, this.errores, this.idfactura});

  Error.fromJson(Map<String, dynamic> json) {
    totalerrores = json['totalerrores'];
    if (json['errores'] != null) {
      errores = <Errores>[];
      json['errores'].forEach((v) {
        errores!.add(new Errores.fromJson(v));
      });
    }
    idfactura = json['idfactura'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalerrores'] = this.totalerrores;
    if (this.errores != null) {
      data['errores'] = this.errores!.map((v) => v.toJson()).toList();
    }
    data['idfactura'] = this.idfactura;
    return data;
  }
}

class Errores {
  String? codError;
  String? errorMessage;

  Errores({this.codError, this.errorMessage});

  Errores.fromJson(Map<String, dynamic> json) {
    codError = json['codError'];
    errorMessage = json['errorMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['codError'] = this.codError;
    data['errorMessage'] = this.errorMessage;
    return data;
  }
}