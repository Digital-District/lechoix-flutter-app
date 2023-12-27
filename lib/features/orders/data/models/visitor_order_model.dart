// To parse this JSON data, do
//
//     final visitorOrderResponse = visitorOrderResponseFromJson(jsonString);

import 'dart:convert';

import 'package:lechoix/features/auth/domain/entities/login.dart';
import 'package:lechoix/features/orders/data/models/order_model.dart';

VisitorOrderResponse visitorOrderResponseFromJson(String str) => VisitorOrderResponse.fromJson(json.decode(str));

String visitorOrderResponseToJson(VisitorOrderResponse data) => json.encode(data.toJson());

class VisitorOrderResponse {
    VisitorOrderResponse({
        this.success,
        this.data,
        this.user,
        this.message,
    });

    String? success;
    OrderData? data;
    VisitorOrderResponseUser? user;
    String? message;

    factory VisitorOrderResponse.fromJson(Map<String, dynamic> json) => VisitorOrderResponse(
        success: json["success"],
        data: json["data"] == null ? null : OrderData.fromJson(json["data"]),
        user: json["user"] == null ? null : VisitorOrderResponseUser.fromJson(json["user"]),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
        "user": user?.toJson(),
        "message": message,
    };
}



class VisitorOrderResponseUser {
    VisitorOrderResponseUser({
        this.user,
        this.success,
        this.message,
        this.token,
    });

   User? user;
    String? success;
    String? message;
    String? token;

    factory VisitorOrderResponseUser.fromJson(Map<String, dynamic> json) => VisitorOrderResponseUser(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        success: json["success"],
        message: json["message"],
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "success": success,
        "message": message,
        "token": token,
    };
}



