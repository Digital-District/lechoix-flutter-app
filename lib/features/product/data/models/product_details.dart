// To parse this JSON ProductDetails, do
//
//     final productsResponse = productsResponseFromJson(jsonString);

import 'dart:convert';

ProductDetailsResponse productsResponseFromJson(String str) =>
    ProductDetailsResponse.fromJson(json.decode(str));

String productsResponseToJson(ProductDetailsResponse data) =>
    json.encode(data.toJson());

class ProductDetailsResponse {
  ProductDetailsResponse({
    this.success,
    this.data,
    this.message,
  });

  final String? success;
  final ProductDetails? data;
  final String? message;

  factory ProductDetailsResponse.fromJson(Map<String, dynamic> json) =>
      ProductDetailsResponse(
        success: json["success"],
        data:
            json["data"] == null ? null : ProductDetails.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
        "message": message,
      };
}

class ProductDetails {
  ProductDetails(
      {this.id,
      this.title,
      this.desc,
      this.price,
      this.salePrice,
      this.brandName,
      this.image,
      this.favouried,
      this.category,
      this.categoryId,
      this.brand,
      this.rate,
      this.purchased,
      this.rated,
      this.hasOption,
      this.images,
      this.rates,
      this.optionValues});

  final int? id;
  final String? title;
  final String? desc;
  final String? price;
  final int? salePrice;
  final String? brandName;
  final String? image;
  final bool? favouried;
  final String? category;
  final String? categoryId;
  final dynamic brand;
  final int? rate;
  final bool? purchased;
  final bool? rated;
  final bool? hasOption;
  final List<ImageData>? images;
  final List<Rate>? rates;
  final List<OptionValue>? optionValues;

  factory ProductDetails.fromJson(Map<String, dynamic> json) => ProductDetails(
        id: json["id"],
        title: json["title"],
        desc: json["desc"],
        price: json["price"],
        salePrice: json["sale_price"],
        brandName: json["brandName"],
        image: json["image"],
        favouried: json["favouried"],
        category: json["category"],
        categoryId: json["category_id"],
        brand: json["brand"],
        rate: json["rate"],
        purchased: json["purchased"],
        rated: json["rated"],
        hasOption: json["has_option"],
        images: json["images"] == []
            ? []
            : List<ImageData>.from(
                json["images"]!.map((x) => ImageData.fromJson(x))),
        rates: json["rates"] == []
            ? []
            : List<Rate>.from(json["rates"]!.map((x) => Rate.fromJson(x))),
        optionValues: json["option_values"] == null
            ? []
            : List<OptionValue>.from(
                json["option_values"]!.map((x) => OptionValue.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "desc": desc,
        "price": price,
        "sale_price": salePrice,
        "brandName": brandName,
        "image": image,
        "favouried": favouried,
        "category": category,
        "category_id": categoryId,
        "brand": brand,
        "rate": rate,
        "purchased": purchased,
        "rated": rated,
        "has_option": hasOption,
        "images": images == null
            ? []
            : List<dynamic>.from(images!.map((x) => x.toJson())),
        "rates": rates == null ? [] : List<dynamic>.from(rates!.map((x) => x)),
        "option_values": optionValues == null
            ? []
            : List<dynamic>.from(rates!.map((x) => x)),
      };
}

class OptionValue {
  OptionValue({
    this.id,
    this.productId,
    this.price,
    this.salePrice,
    this.quantity,
    this.optionValueId,
    this.values,
  });

  final int? id;
  final String? productId;
  final String? price;
  final dynamic salePrice;
  final String? quantity;
  final String? optionValueId;
  final List<Value>? values;

  factory OptionValue.fromJson(Map<String, dynamic> json) => OptionValue(
        id: json["id"],
        productId: json["product_id"],
        price: json["price"],
        salePrice: json["sale_price"],
        quantity: json["quantity"],
        optionValueId: json["option_value_id"],
        values: json["values"] == null
            ? []
            : List<Value>.from(json["values"]!.map((x) => Value.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "price": price,
        "sale_price": salePrice,
        "quantity": quantity,
        "option_value_id": optionValueId,
        "values": values == null
            ? []
            : List<dynamic>.from(values!.map((x) => x.toJson())),
      };
}

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

class ImageData {
  ImageData({
    this.id,
    this.productId,
    this.full,
    this.type,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final int? productId;
  final String? full;
  final String? type;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory ImageData.fromJson(Map<String, dynamic> json) => ImageData(
        id: json["id"],
        productId: json["product_id"],
        full: json["full"],
        type: json["type"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "full": full,
        "type": type,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class Rate {
  Rate({
    this.id,
    this.productId,
    this.userId,
    this.rate,
    this.comment,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final int? productId;
  final int? userId;
  final int? rate;
  final String? comment;
  final String? status;
  final DateTime? createdAt;
  final dynamic updatedAt;

  factory Rate.fromJson(Map<String, dynamic> json) => Rate(
        id: json["id"],
        productId: json["product_id"],
        userId: json["user_id"],
        rate: json["rate"],
        comment: json["comment"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "user_id": userId,
        "rate": rate,
        "comment": comment,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt,
      };
}
