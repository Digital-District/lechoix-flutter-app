class AddToCartRequestModel {
  int? productId;
  int? colorId;
  int? sizeId;

  AddToCartRequestModel({
    this.productId,
    this.colorId,
    this.sizeId,
  });

  AddToCartRequestModel.fromJson(dynamic json) {
    productId = json['product_id'];
    colorId = json['color_id'];
    sizeId = json['size_id'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['product_id'] = productId;
    map['color_id'] = colorId;
    map['size_id'] = sizeId;
    return map;
  }
}
