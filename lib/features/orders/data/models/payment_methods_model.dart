// To parse this JSON data, do
//
//     final paymentMethodResponse = paymentMethodResponseFromJson(jsonString);

import 'dart:convert';

PaymentMethodResponse paymentMethodResponseFromJson(String str) => PaymentMethodResponse.fromJson(json.decode(str));

String paymentMethodResponseToJson(PaymentMethodResponse data) => json.encode(data.toJson());

class PaymentMethodResponse {
    PaymentMethodResponse({
        this.success,
        this.data,
        this.message,
    });

    final String? success;
    final List<MethodData>? data;
    final String? message;

    factory PaymentMethodResponse.fromJson(Map<String, dynamic> json) => PaymentMethodResponse(
        success: json["success"],
        data: json["data"] == null ? [] : List<MethodData>.from(json["data"]!.map((x) => MethodData.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
    };
}

class MethodData {
    MethodData({
        this.id,
        this.paymentName,
        this.available,
        this.gateway,
    });

    final int? id;
    final String? paymentName;
    final String? available;
    final String? gateway;

    factory MethodData.fromJson(Map<String, dynamic> json) => MethodData(
        id: json["id"],
        paymentName: json["payment_name"],
        available: json["available"],
        gateway: json["gateway"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "payment_name": paymentName,
        "available": available,
        "gateway": gateway,
    };
}
