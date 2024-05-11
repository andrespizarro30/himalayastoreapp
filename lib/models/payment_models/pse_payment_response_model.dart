class PSEPaymentResponse {
  bool? success;
  String? titleResponse;
  String? textResponse;
  String? lastAction;
  Data? data;

  PSEPaymentResponse(
      {this.success,
        this.titleResponse,
        this.textResponse,
        this.lastAction,
        this.data});

  PSEPaymentResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    titleResponse = json['titleResponse'];
    textResponse = json['textResponse'];
    lastAction = json['lastAction'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : Data();
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
  int? refPayco;
  String? factura;
  String? descripcion;
  int? valor;
  int? iva;
  int? ico;
  int? baseiva;
  String? moneda;
  String? estado;
  String? respuesta;
  int? codRespuesta;
  int? codError;
  String? autorizacion;
  String? ciudad;
  String? recibo;
  String? fecha;
  String? urlbanco;
  String? transactionID;
  String? ticketId;
  Extras? extras;
  String? ciclo;

  Data(
      {this.refPayco = 0,
        this.factura = "",
        this.descripcion = "",
        this.valor = 0,
        this.iva = 0,
        this.ico = 0,
        this.baseiva = 0,
        this.moneda = "",
        this.estado = "",
        this.respuesta = "",
        this.codRespuesta = 0,
        this.codError = 0,
        this.autorizacion = "",
        this.ciudad = "",
        this.recibo = "",
        this.fecha = "",
        this.urlbanco = "",
        this.transactionID = "",
        this.ticketId = "",
        this.extras,
        this.ciclo = ""});

  Data.fromJson(Map<String, dynamic> json) {
    refPayco = json['ref_payco'];
    factura = json['factura'];
    descripcion = json['descripcion'];
    valor = json['valor'];
    iva = json['iva'];
    ico = json['ico'];
    baseiva = json['baseiva'];
    moneda = json['moneda'];
    estado = json['estado'];
    respuesta = json['respuesta'];
    codRespuesta = json['cod_respuesta'];
    codError = json['cod_error'];
    autorizacion = json['autorizacion'];
    ciudad = json['ciudad'];
    recibo = json['recibo'];
    fecha = json['fecha'];
    urlbanco = json['urlbanco'];
    transactionID = json['transactionID'];
    ticketId = json['ticketId'];
    extras =
    json['extras'] != null ? new Extras.fromJson(json['extras']) : null;
    ciclo = json['ciclo'];
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
    data['moneda'] = this.moneda;
    data['estado'] = this.estado;
    data['respuesta'] = this.respuesta;
    data['cod_respuesta'] = this.codRespuesta;
    data['cod_error'] = this.codError;
    data['autorizacion'] = this.autorizacion;
    data['ciudad'] = this.ciudad;
    data['recibo'] = this.recibo;
    data['fecha'] = this.fecha;
    data['urlbanco'] = this.urlbanco;
    data['transactionID'] = this.transactionID;
    data['ticketId'] = this.ticketId;
    if (this.extras != null) {
      data['extras'] = this.extras!.toJson();
    }
    data['ciclo'] = this.ciclo;
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