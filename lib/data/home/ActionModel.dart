import '../CategoryModel.dart';
import '../model/BrandModel.dart';

class ActionModel {
  String? text;
  String? type;
  int? id;
  BrandModel? brand;
  CategoryModel? category;

  ActionModel.fromJson(dynamic json) {
    text = json['text'];
    type = json['type'];
    id = json['id'];
    brand = json['brand'] != null ? BrandModel.fromJson(json['brand']) : null;
    category = json['category'] != null ? CategoryModel.fromJson(json['category']) : null;

  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['text'] = text;
    map['type'] = type;
    map['id'] = id;
    if (brand != null) {
      map['brand'] = brand?.toJson();
    }
    if (category != null) {
      map['category'] = category?.toJson();
    }
    return map;
  }
}
