import '../model/ProductModel.dart';
import 'ActionModel.dart';

class HomeItemModel {
  String? image;
  String? title;
  String? subTitle;
  ActionModel? action;
  List<ProductModel>? products;

  HomeItemModel.fromJson(dynamic json) {
    image = json['image'];
    title = json['title'];
    subTitle = json['sub_title'];
    action =
        json['action'] != null ? ActionModel.fromJson(json['action']) : null;
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products?.add(ProductModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['image'] = image;
    map['title'] = title;
    map['sub_title'] = subTitle;
    if (action != null) {
      map['action'] = action?.toJson();
    }

    if (products != null) {
      map['products'] = products?.map((v) => v.toJson()).toList();
    }

    return map;
  }
}
