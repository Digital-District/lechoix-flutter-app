class CouponModel {
  int? id;
  dynamic name;
  String? code;
  String? application;
  String? discountType;
  int? amount;
  int? minOrderAmount;
  int? maxDiscountAmount;
  int? numberOfUsesPerCustomer;
  int? numberOfUses;

  CouponModel({
    this.id,
    this.name,
    this.code,
    this.application,
    this.discountType,
    this.amount,
    this.minOrderAmount,
    this.maxDiscountAmount,
    this.numberOfUsesPerCustomer,
    this.numberOfUses,
  });

  CouponModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    application = json['application'];
    discountType = json['discount_type'];
    amount = json['amount'];
    minOrderAmount = json['min_order_amount'];
    maxDiscountAmount = json['max_discount_amount'];
    numberOfUsesPerCustomer = json['number_of_uses_per_customer'];
    numberOfUses = json['number_of_uses'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['code'] = code;
    map['application'] = application;
    map['discount_type'] = discountType;
    map['amount'] = amount;
    map['min_order_amount'] = minOrderAmount;
    map['max_discount_amount'] = maxDiscountAmount;
    map['number_of_uses_per_customer'] = numberOfUsesPerCustomer;
    map['number_of_uses'] = numberOfUses;
    return map;
  }
}
