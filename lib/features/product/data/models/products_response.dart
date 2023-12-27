// To parse this JSON data, do
//
//     final productResponse = productResponseFromJson(jsonString);

import 'dart:convert';

import 'package:lechoix/features/product/data/models/product_details.dart';

ProductsResponse productResponseFromJson(String str) =>
    ProductsResponse.fromJson(json.decode(str));

String productResponseToJson(ProductsResponse data) =>
    json.encode(data.toJson());

class ProductsResponse {
  ProductsResponse({
    this.success,
    this.data,
    this.message,
  });

  String? success;
  ProductData? data;
  String? message;

  factory ProductsResponse.fromJson(Map<String, dynamic> json) =>
      ProductsResponse(
        success: json["success"],
        data: json["data"] == [] ? null : ProductData.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
        "message": message,
      };
}

class ProductData {
  ProductData({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  int? currentPage;
  List<Product>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  factory ProductData.fromJson(Map<String, dynamic> json) => ProductData(
        currentPage: json["current_page"],
        data: json["data"] == []
            ? []
            : List<Product>.from(json["data"]!.map((x) => Product.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: json["links"] == null
            ? []
            : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": links == null
            ? []
            : List<dynamic>.from(links!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class Link {
  Link({
    this.url,
    this.label,
    this.active,
  });

  String? url;
  String? label;
  bool? active;

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };
}

class Product {
  Product(
      {this.id,
      this.title,
      this.desc,
      this.price,
      this.salePrice,
      this.optionValuesSumQuantity,
      this.image,
      this.favouried,
      this.category,
      this.categoryId,
      this.brand,
      this.rate,
      this.purchased,
      this.rated,
      this.hasOption,
      this.rates,
      this.date,
      this.time});

  final int? id;
  final String? title;
  final String? desc;
  final String? price;
  final dynamic salePrice;
  final String? optionValuesSumQuantity;
  final String? image;
  final String? time;
  final String? date;
  final bool? favouried;
  final String? category;
  final dynamic categoryId;
  final dynamic brand;
  final dynamic rate;
  final bool? purchased;
  final bool? rated;
  final bool? hasOption;
  final List<Rate>? rates;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        title: json["title"],
        desc: json["desc"],
        price: json["price"],
        salePrice: json["sale_price"] ?? "0" ,
        optionValuesSumQuantity: json["option_values_sum_quantity"],
        image: json["image"],
        favouried: json["favouried"],
        category: json["category"],
        categoryId: json["category_id"],
        brand: json["brand"],
        rate: json["rate"],
        purchased: json["purchased"],
        rated: json["rated"],
        hasOption: json["has_option"],
        date: json["date"] ?? "",
        time: json["time"] ?? "",
        rates: json["rates"] == null
            ? []
            : List<Rate>.from(json["rates"]!.map((x) => Rate.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "desc": desc,
        "price": price,
        "sale_price": salePrice,
        "option_values_sum_quantity": optionValuesSumQuantity,
        "image": image,
        "favouried": favouried,
        "category": category,
        "category_id": categoryId,
        "brand": brand,
        "rate": rate,
        "purchased": purchased,
        "rated": rated,
        "has_option": hasOption,
        "rates": rates == [] ? [] : List<dynamic>.from(rates!.map((x) => x)),
      };
}

ProductsResponseNoPagination productsResponseNoPageFromJson(String str) =>
    ProductsResponseNoPagination.fromJson(json.decode(str));

String productsResponseNoPageToJson(ProductsResponseNoPagination data) =>
    json.encode(data.toJson());

class ProductsResponseNoPagination {
  ProductsResponseNoPagination({
    this.success,
    this.data,
    this.message,
  });

  final String? success;
  final List<Product>? data;
  final String? message;

  factory ProductsResponseNoPagination.fromJson(Map<String, dynamic> json) =>
      ProductsResponseNoPagination(
        success: json["success"],
        data: json["data"] == []
            ? []
            : List<Product>.from(json["data"]!.map((x) => Product.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data":
            data == [] ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
      };
}
