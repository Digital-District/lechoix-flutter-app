// To parse this JSON data, do
//
//     final brandsResponse = brandsResponseFromJson(jsonString);

import 'dart:convert';

BrandsResponse brandsResponseFromJson(String str) => BrandsResponse.fromJson(json.decode(str));

String brandsResponseToJson(BrandsResponse data) => json.encode(data.toJson());

class BrandsResponse {
    BrandsResponse({
        this.brands,
        this.success,
    });

    final List<Brand>? brands;
    final bool? success;

    factory BrandsResponse.fromJson(Map<String, dynamic> json) => BrandsResponse(
        brands: json["brands"] == null ? [] : List<Brand>.from(json["brands"]!.map((x) => Brand.fromJson(x))),
        success: json["success"],
    );

    Map<String, dynamic> toJson() => {
        "brands": brands == null ? [] : List<dynamic>.from(brands!.map((x) => x.toJson())),
        "success": success,
    };
}

class Brand {
    Brand({
        this.id,
        this.logo,
        this.name,
    });

    final int? id;
    final String? logo;
    final String? name;

    factory Brand.fromJson(Map<String, dynamic> json) => Brand(
        id: json["id"],
        logo: json["logo"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "logo": logo,
        "name": name,
    };
}
