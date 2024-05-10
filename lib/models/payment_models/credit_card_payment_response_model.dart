class CreditCardPaymentResponse {
  bool? success;
  String? titleResponse;
  String? textResponse;
  String? lastAction;
  Data? data;

  CreditCardPaymentResponse(
      {this.success,
        this.titleResponse,
        this.textResponse,
        this.lastAction,
        this.data});

  CreditCardPaymentResponse.fromJson(Map<String, dynamic> json) {
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
  Transaction? transaction;
  TokenCard? tokenCard;

  Data({this.transaction, this.tokenCard});

  Data.fromJson(Map<String, dynamic> json) {
    transaction = json['transaction'] != null
        ? new Transaction.fromJson(json['transaction'])
        : null;
    tokenCard = json['tokenCard'] != null
        ? new TokenCard.fromJson(json['tokenCard'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.transaction != null) {
      data['transaction'] = this.transaction!.toJson();
    }
    if (this.tokenCard != null) {
      data['tokenCard'] = this.tokenCard!.toJson();
    }
    return data;
  }
}

class Transaction {
  bool? status;
  bool? success;
  String? type;
  CCData? data;
  String? object;

  Transaction({this.status, this.success, this.type, this.data, this.object});

  Transaction.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    type = json['type'];
    data = json['data'] != null ? new CCData.fromJson(json['data']) : null;
    object = json['object'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['success'] = this.success;
    data['type'] = this.type;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['object'] = this.object;
    return data;
  }
}

class CCData {
  int? refPayco;
  String? factura;
  String? descripcion;
  int? valor;
  int? iva;
  int? ico;
  int? baseiva;
  int? valorneto;
  String? moneda;
  String? banco;
  String? estado;
  String? respuesta;
  String? autorizacion;
  String? recibo;
  String? fecha;
  String? franquicia;
  int? codRespuesta;
  String? codError;
  String? ip;
  int? enpruebas;
  String? tipoDoc;
  String? documento;
  String? nombres;
  String? apellidos;
  String? email;
  String? ciudad;
  String? direccion;
  String? indPais;
  String? countryCard;
  Extras? extras;
  bool? ccNetworkResponse;
  ExtrasEpayco? extrasEpayco;

  CCData(
      {this.refPayco,
        this.factura,
        this.descripcion,
        this.valor,
        this.iva,
        this.ico,
        this.baseiva,
        this.valorneto,
        this.moneda,
        this.banco,
        this.estado,
        this.respuesta,
        this.autorizacion,
        this.recibo,
        this.fecha,
        this.franquicia,
        this.codRespuesta,
        this.codError,
        this.ip,
        this.enpruebas,
        this.tipoDoc,
        this.documento,
        this.nombres,
        this.apellidos,
        this.email,
        this.ciudad,
        this.direccion,
        this.indPais,
        this.countryCard,
        this.extras,
        this.ccNetworkResponse,
        this.extrasEpayco});

  CCData.fromJson(Map<String, dynamic> json) {
    refPayco = json['ref_payco'];
    factura = json['factura'];
    descripcion = json['descripcion'];
    valor = json['valor'];
    iva = json['iva'];
    ico = json['ico'];
    baseiva = json['baseiva'];
    valorneto = json['valorneto'];
    moneda = json['moneda'];
    banco = json['banco'];
    estado = json['estado'];
    respuesta = json['respuesta'];
    autorizacion = json['autorizacion'];
    recibo = json['recibo'];
    fecha = json['fecha'];
    franquicia = json['franquicia'];
    codRespuesta = json['cod_respuesta'];
    codError = json['cod_error'];
    ip = json['ip'];
    enpruebas = json['enpruebas'];
    tipoDoc = json['tipo_doc'];
    documento = json['documento'];
    nombres = json['nombres'];
    apellidos = json['apellidos'];
    email = json['email'];
    ciudad = json['ciudad'];
    direccion = json['direccion'];
    indPais = json['ind_pais'];
    countryCard = json['country_card'];
    extras =
    json['extras'] != null ? new Extras.fromJson(json['extras']) : null;
    ccNetworkResponse = json['cc_network_response'];
    extrasEpayco = json['extras_epayco'] != null
        ? new ExtrasEpayco.fromJson(json['extras_epayco'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ref_payco'] = this.refPayco;
    data['factura'] = this.factura;
    data['descripcion'] = this.descripcion;
    data['valor'] = this.valor;
    data['iva'] = this.iva;
    data['ico'] = this.ico;
    data['baseiva'] = this.baseiva;
    data['valorneto'] = this.valorneto;
    data['moneda'] = this.moneda;
    data['banco'] = this.banco;
    data['estado'] = this.estado;
    data['respuesta'] = this.respuesta;
    data['autorizacion'] = this.autorizacion;
    data['recibo'] = this.recibo;
    data['fecha'] = this.fecha;
    data['franquicia'] = this.franquicia;
    data['cod_respuesta'] = this.codRespuesta;
    data['cod_error'] = this.codError;
    data['ip'] = this.ip;
    data['enpruebas'] = this.enpruebas;
    data['tipo_doc'] = this.tipoDoc;
    data['documento'] = this.documento;
    data['nombres'] = this.nombres;
    data['apellidos'] = this.apellidos;
    data['email'] = this.email;
    data['ciudad'] = this.ciudad;
    data['direccion'] = this.direccion;
    data['ind_pais'] = this.indPais;
    data['country_card'] = this.countryCard;
    if (this.extras != null) {
      data['extras'] = this.extras!.toJson();
    }
    data['cc_network_response'] = this.ccNetworkResponse;
    if (this.extrasEpayco != null) {
      data['extras_epayco'] = this.extrasEpayco!.toJson();
    }
    return data;
  }
}

class Extras {
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

  Extras(
      {this.extra1,
        this.extra2,
        this.extra3,
        this.extra4,
        this.extra5,
        this.extra6,
        this.extra7,
        this.extra8,
        this.extra9,
        this.extra10});

  Extras.fromJson(Map<String, dynamic> json) {
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

class ExtrasEpayco {
  String? extra5;

  ExtrasEpayco({this.extra5});

  ExtrasEpayco.fromJson(Map<String, dynamic> json) {
    extra5 = json['extra5'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['extra5'] = this.extra5;
    return data;
  }
}

class TokenCard {
  String? email;
  String? cardTokenId;
  String? customerId;

  TokenCard({this.email, this.cardTokenId, this.customerId});

  TokenCard.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    cardTokenId = json['cardTokenId'];
    customerId = json['customerId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['cardTokenId'] = this.cardTokenId;
    data['customerId'] = this.customerId;
    return data;
  }
}