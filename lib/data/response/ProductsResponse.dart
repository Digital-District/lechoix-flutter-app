import '../model/PaginationModel.dart';
import '../model/ProductModel.dart';

class ProductsResponse {
  List<ProductModel>? products;
  PaginationModel? pagination;
  String productsCount = "0";

  ProductsResponse.fromJson(dynamic json) {
    productsCount = json['products_count'].toString();
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products?.add(ProductModel.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? PaginationModel.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (products != null) {
      map['products'] = products?.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      map['pagination'] = pagination?.toJson();
    }
    return map;
  }
}
