class DiscountModel {
  String? totalDiscount;

  DiscountModel({
    this.totalDiscount,
  });

  DiscountModel.fromJson(dynamic json) {
    totalDiscount = json['total_discount'].toString();
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total_discount'] = totalDiscount;
    return map;
  }
}
