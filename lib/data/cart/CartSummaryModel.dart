import 'package:easy_localization/easy_localization.dart';

import 'CouponModel.dart';
import 'TaxModel.dart';

class CartSummaryModel {
  String? subTotal;
  String? deliveryFees;
  String? totalBeforeDiscount;
  String? total;
  String? discountAmount;
  TaxModel? tax;
  CouponModel? discount;

  CartSummaryModel({
    this.subTotal,
    this.tax,
    this.deliveryFees,
    this.totalBeforeDiscount,
    this.total,
    this.discount,
    this.discountAmount,
  });

  CartSummaryModel.fromJson(dynamic json) {
    subTotal = json['sub_total'].toString();
    deliveryFees = json['delivery_fees'].toString();
    totalBeforeDiscount = json['total_before_discount'].toString();
    total = json['total'].toString();
    discountAmount = json['discount_amount'].toString();
    tax = json['tax'] != null ? TaxModel.fromJson(json['tax']) : null;
    discount = json['discount'] != null
        ? CouponModel.fromJson(json['discount'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['sub_total'] = subTotal;
    if (tax != null) {
      map['tax'] = tax?.toJson();
    }
    map['delivery_fees'] = deliveryFees;
    map['total_before_discount'] = totalBeforeDiscount;
    map['total'] = total;
    map['discount'] = discount;
    map['discount_amount'] = discountAmount;
    return map;
  }

  bool hasCoupon() {
    return discountAmount != "null" && discountAmount != "0";
  }

  String getCouponCode() {
    String code = discount?.code ?? "";
    if (code.isNotEmpty) {
      code = "( $code )";
    }
    return code;
  }

  String getDeliveryFees(String currency) {
    if (deliveryFees == null || deliveryFees == "null" || deliveryFees == "0") {
      return tr("Free");
    }
    return "${deliveryFees ?? ""} $currency";
  }
}
