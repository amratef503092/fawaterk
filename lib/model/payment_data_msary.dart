class MsaaryModel {
  String status;
  Data data;

  MsaaryModel({required this.status, required this.data});
  factory MsaaryModel.fromJson(Map<String, dynamic> json) {
    return MsaaryModel(
      status: json['status'],
      data: Data.fromJson(json),
    );
  }
}

class Data 
{
  int invoiceID;
  String invoiceKey;
  PaymentData paymentData;

  Data(
      {required this.invoiceID,
      required this.invoiceKey,
      required this.paymentData});

  Data.fromJson(Map<String, dynamic> json)
      : invoiceID = json['data']['invoice_id'],
        invoiceKey = json['data']['invoice_key'],
        paymentData = PaymentData.fromJson(json['data']['payment_data']);
}

class PaymentData {
  int masaryCode;

  PaymentData({required this.masaryCode});

  PaymentData.fromJson(Map<String, dynamic> json)
      : masaryCode = json['masaryCode'];
}
