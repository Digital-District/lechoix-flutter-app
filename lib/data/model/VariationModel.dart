import 'ColorModel.dart';
import 'SizeModel.dart';

class VariationModel {
  int? id;
  String? price;
  String? salePrice;
  int? colorId;
  int? sizeId;
  ColorModel? color;
  SizeModel? size;

  VariationModel({
    this.id,
    this.price,
    this.salePrice,
    this.colorId,
    this.sizeId,
    this.color,
    this.size,

  });

  VariationModel.fromJson(dynamic json) {
    id = json['id'];
    price = json['price'].toString();
    salePrice = json['sale_price'].toString();
    colorId = json['color_id'];
    sizeId = json['size_id'];
    color = json['color'] != null ? ColorModel.fromJson(json['color']) : null;
    size = json['size'] != null ? SizeModel.fromJson(json['size']) : null;

  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['price'] = price;
    map['sale_price'] = salePrice;
    map['color_id'] = colorId;
    map['size_id'] = sizeId;
    if (color != null) {
      map['color'] = color?.toJson();
    }
    if (size != null) {
      map['size'] = size?.toJson();
    }
    return map;
  }
}
