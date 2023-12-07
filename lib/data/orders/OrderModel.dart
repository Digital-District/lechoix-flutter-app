import 'package:easy_localization/easy_localization.dart';
import 'package:lechoix/data/address/AddressModel.dart';

import '../Enumeration.dart';
import '../cart/CartModel.dart';
import '../cart/CartSummaryModel.dart';

class OrderModel {
  int? id;
  String? orderNumber;
  int? paymentMethod;
  String? status;
  String? estimatedDelivery;
  String? createdAt;
  AddressModel? address;
  List<CartModel>? cart;
  CartSummaryModel? cartSummary;
  int? statusId;

  OrderModel({
    this.id,
    this.orderNumber,
    this.address,
    this.cart,
    this.cartSummary,
    this.paymentMethod,
    this.status,
    this.estimatedDelivery,
    this.createdAt,
    this.statusId,
  });

  OrderModel.fromJson(dynamic json) {
    id = json['id'];
    orderNumber = json['order_number'];
    paymentMethod = json['payment_method'];
    status = json['status'];
    estimatedDelivery = json['estimated_delivery'];
    createdAt = json['created_at'];

    address =
        json['address'] != null ? AddressModel.fromJson(json['address']) : null;
    cartSummary = json['cart_summary'] != null
        ? CartSummaryModel.fromJson(json['cart_summary'])
        : null;
    if (json['cart'] != null) {
      cart = [];
      json['cart'].forEach((v) {
        cart?.add(CartModel.fromJson(v));
      });
    }
    statusId = json['status_id'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['order_number'] = orderNumber;
    if (address != null) {
      map['address'] = address?.toJson();
    }
    if (cart != null) {
      map['cart'] = cart?.map((v) => v.toJson()).toList();
    }
    if (cartSummary != null) {
      map['cart_summary'] = cartSummary?.toJson();
    }
    map['payment_method'] = paymentMethod;
    map['status'] = status;
    map['estimated_delivery'] = estimatedDelivery;
    map['created_at'] = createdAt;
    map['status_id'] = statusId;

    return map;
  }

  String getPaymentDetails() {
    String payment = PaymentMethod.cashOnDelivery.getName(paymentMethod ?? 0);
    String totalPrice = cartSummary?.total ?? "";
    String currency = cart?[0].currency ?? "";

    return "${tr(payment)}, $totalPrice $currency";
  }
}
