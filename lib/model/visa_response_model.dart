class VisaResponseModel {
  String? status;
  Data? data;

  VisaResponseModel({this.status, this.data});

  VisaResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? invoiceId;
  String? invoiceKey;
  PaymentData? paymentData;

  Data({this.invoiceId, this.invoiceKey, this.paymentData});

  Data.fromJson(Map<String, dynamic> json) {
    invoiceId = json['invoice_id'];
    invoiceKey = json['invoice_key'];
    paymentData = json['payment_data'] != null
        ? new PaymentData.fromJson(json['payment_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['invoice_id'] = this.invoiceId;
    data['invoice_key'] = this.invoiceKey;
    if (this.paymentData != null) {
      data['payment_data'] = this.paymentData!.toJson();
    }
    return data;
  }
}

class PaymentData {
  String? redirectTo;

  PaymentData({this.redirectTo});

  PaymentData.fromJson(Map<String, dynamic> json) {
    redirectTo = json['redirectTo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['redirectTo'] = this.redirectTo;
    return data;
  }
}
