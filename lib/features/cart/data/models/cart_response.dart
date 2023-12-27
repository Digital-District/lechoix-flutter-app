// To parse this JSON data, do
//
//     final cartResponse = cartResponseFromJson(jsonString);

import 'dart:convert';

import '../../../product/data/models/products_response.dart';

CartResponse cartResponseFromJson(String str) =>
    CartResponse.fromJson(json.decode(str));

String cartResponseToJson(CartResponse data) => json.encode(data.toJson());

class CartResponse {
  CartResponse({
    this.success,
    this.data,
    this.totalPrice,
    this.tax,
    this.type,
    this.message,
  });

  final String? success;
  final List<CartData>? data;
  final int? totalPrice;
  final String? tax;
  final String? type;
  final String? message;

  factory CartResponse.fromJson(Map<String, dynamic> json) => CartResponse(
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<CartData>.from(
                json["data"]!.map((x) => CartData.fromJson(x))),
        totalPrice: json["totalPrice"],
        tax: json["tax"],
        type: json["type"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data":
            data == [] ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "totalPrice": totalPrice,
        "tax": tax,
        "type": type,
        "message": message,
      };
}

class CartData {
  CartData({
    this.id,
    this.price,
    this.salePrice,
    this.quantity,
    this.productId,
    this.optionValueId,
    this.values,
    this.product,
  });

  final int? id;
  final String? price;
  final dynamic salePrice;
  final String? quantity;
  final String? productId;
  final String? optionValueId;
  final List<Value>? values;
  final Product? product;

  factory CartData.fromJson(Map<String, dynamic> json) => CartData(
        id: json["id"],
        price: json["price"],
        salePrice: json["sale_price"],
        quantity: json["quantity"],
        productId: json["product_id"],
        optionValueId: json["option_value_id"],
        values: json["values"] == null
            ? []
            : List<Value>.from(json["values"]!.map((x) => Value.fromJson(x))),
        product:
            json["product"] == null ? null : Product.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "price": price,
        "sale_price": salePrice,
        "quantity": quantity,
        "product_id": productId,
        "option_value_id": optionValueId,
        "values": values == null
            ? []
            : List<dynamic>.from(values!.map((x) => x.toJson())),
        "product": product?.toJson(),
      };
}

// class Product {
//   Product({
//     this.title,
//     this.id,
//     this.image,
//     this.favouried,
//     this.category,
//     this.categoryId,
//     this.brand,
//     this.rate,
//     this.purchased,
//     this.rated,
//     this.hasOption,
//   });
//
//   final String? title;
//   final int? id;
//   final String? image;
//   final bool? favouried;
//   final String? category;
//   final int? categoryId;
//   final dynamic brand;
//   final int? rate;
//   final bool? purchased;
//   final bool? rated;
//   final bool? hasOption;
//
//   factory Product.fromJson(Map<String, dynamic> json) => Product(
//     title: json["title"],
//     id: json["id"],
//     image: json["image"],
//     favouried: json["favouried"],
//     category: json["category"],
//     categoryId: json["category_id"],
//     brand: json["brand"],
//     rate: json["rate"],
//     purchased: json["purchased"],
//     rated: json["rated"],
//     hasOption: json["has_option"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "title": title,
//     "id": id,
//     "image": image,
//     "favouried": favouried,
//     "category": category,
//     "category_id": categoryId,
//     "brand": brand,
//     "rate": rate,
//     "purchased": purchased,
//     "rated": rated,
//     "has_option": hasOption,
//   };
// }

class Value {
  Value({
    this.id,
    this.name,
    this.optionId,
    this.optionName,
  });

  final int? id;
  final String? name;
  final String? optionId;
  final String? optionName;

  factory Value.fromJson(Map<String, dynamic> json) => Value(
        id: json["id"],
        name: json["name"],
        optionId: json["option_id"],
        optionName: json["option_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "option_id": optionId,
        "option_name": optionName,
      };
}
