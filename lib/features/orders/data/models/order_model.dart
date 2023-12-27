// To parse this JSON data, do
//
//     final orderResponse = orderResponseFromJson(jsonString);

import 'dart:convert';

import 'package:lechoix/features/auth/domain/entities/login.dart';

OrderResponse orderResponseFromJson(String str) =>
    OrderResponse.fromJson(json.decode(str));

String orderResponseToJson(OrderResponse data) => json.encode(data.toJson());

class OrderResponse {
  OrderResponse({
    this.success,
    this.data,
    this.user,
    this.token,
    this.message,
  });

  final String? success;
  final OrderData? data;
  final User? user;
  final String? token;
  final String? message;

  factory OrderResponse.fromJson(Map<String, dynamic> json) => OrderResponse(
        success: json["success"],
        data: json["data"] == null ? null : OrderData.fromJson(json["data"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        token: json["token"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
        "user": user?.toJson(),
        "token": token,
        "message": message,
      };
}

class OrderData {
  OrderData({
    this.orderNumber,
    this.userId,
    this.total,
    this.addressId,
    this.shippingCost,
    this.couponId,
    this.discount,
    this.status,
    this.method,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.image,
    this.name,
  });

  final int? orderNumber;
  final int? userId;
  final String? total;
  final int? addressId;
  final int? shippingCost;
  final String? couponId;
  final String? discount;
  final String? status;
  final String? method;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final int? id;
  final String? image;
  final dynamic name;

  factory OrderData.fromJson(Map<String, dynamic> json) => OrderData(
        orderNumber: json["order_number"],
        userId: json["user_id"],
        total: json["total"],
        addressId: json["address_id"],
        shippingCost: num.tryParse(json["shipping_cost"])!.toInt(),
        couponId: json["coupon_id"],
        discount: json["discount"],
        status: json["status"],
        method: json["method"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        id: json["id"],
        image: json["image"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "order_number": orderNumber,
        "user_id": userId,
        "total": total,
        "address_id": addressId,
        "shipping_cost": shippingCost,
        "coupon_id": couponId,
        "discount": discount,
        "status": status,
        "method": method,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at":
            "${createdAt!.year.toString().padLeft(4, '0')}-${createdAt!.month.toString().padLeft(2, '0')}-${createdAt!.day.toString().padLeft(2, '0')}",
        "id": id,
        "image": image,
        "name": name,
      };
}
