import 'dart:convert';

CouponResponse couponResponseFromJson(String str) => CouponResponse.fromJson(json.decode(str));

String couponResponseToJson(CouponResponse data) => json.encode(data.toJson());

class CouponResponse {
    CouponResponse({
        this.success,
        this.data,
        this.message,
    });

    final String? success;
    final CouponData? data;
    final String? message;

    factory CouponResponse.fromJson(Map<String, dynamic> json) => CouponResponse(
        success: json["success"],
        data: json["data"] == null ? null : CouponData.fromJson(json["data"]),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
        "message": message,
    };
}

class CouponData {
    CouponData({
        this.id,
        this.code,
        this.type,
        this.amount,
        this.endTime,
    });

    final int? id;
    final String? code;
    final String? type;
    final String? amount;
    final DateTime? endTime;

    factory CouponData.fromJson(Map<String, dynamic> json) => CouponData(
        id: json["id"],
        code: json["code"],
        type: json["type"],
        amount: json["amount"],
        endTime: json["end_time"] == null ? null : DateTime.parse(json["end_time"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "type": type,
        "amount": amount,
        "end_time": endTime?.toIso8601String(),
    };
}
