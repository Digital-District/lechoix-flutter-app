class ConfigurationModel {
  String? email;
  String? phone;
  String? countyCode;
  String? callStartTime;
  String? callEndTime;
  String? cashOnDeliveryFees;
  String? freeDeliveryAmount;
  String? currency;

  bool? cashOnDelivery;
  bool? cardOnDelivery;
  bool? onlinePayment;

  ConfigurationModel.fromJson(dynamic json) {
    email = "mahmedsalah94@gmail.com";
    phone = "12345678";
    countyCode = json['county_code'];
    callStartTime = json['call_start_time'];
    callEndTime = json['call_end_time'];
    cashOnDeliveryFees = json['cash_on_delivery_fees'].toString();
    cashOnDelivery = json['cash_on_delivery'];
    cardOnDelivery = json['card_on_delivery'];
    onlinePayment = json['online_payment'];
    freeDeliveryAmount = json['free_delivery_amount'].toString();
    currency = json['currency'];
    // email = json['email'];
    // phone = json['phone'];
    // countyCode = json['county_code'];
    // callStartTime = json['call_start_time'];
    // callEndTime = json['call_end_time'];
    // cashOnDeliveryFees = json['cash_on_delivery_fees'].toString();
    // cashOnDelivery = json['cash_on_delivery'];
    // cardOnDelivery = json['card_on_delivery'];
    // onlinePayment = json['online_payment'];
    // freeDeliveryAmount = json['free_delivery_amount'].toString();
    // currency = json['currency'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;
    map['phone'] = phone;
    map['county_code'] = countyCode;
    map['call_start_time'] = callStartTime;
    map['call_end_time'] = callEndTime;
    map['cash_on_delivery_fees'] = cashOnDeliveryFees;
    map['cash_on_delivery'] = cashOnDelivery;
    map['card_on_delivery'] = cardOnDelivery;
    map['online_payment'] = onlinePayment;
    map['currency'] = currency;

    return map;
  }

  String getCashOnDeliveryFees() {
    if (cashOnDeliveryFees == "" || cashOnDeliveryFees == "0") {
      return "";
    }
    return "$cashOnDeliveryFees $currency";
  }
}
