// To parse this JSON data, do
//
//     final categoriesResponse = categoriesResponseFromJson(jsonString);

import 'dart:convert';

CategoriesResponse categoriesResponseFromJson(String str) => CategoriesResponse.fromJson(json.decode(str));

String categoriesResponseToJson(CategoriesResponse data) => json.encode(data.toJson());

class CategoriesResponse {
    CategoriesResponse({
        this.success,
        this.data,
        this.message,
    });

    final String? success;
    final List<CategoryData>? data;
    final String? message;

    factory CategoriesResponse.fromJson(Map<String, dynamic> json) => CategoriesResponse(
        success: json["success"],
        data: json["data"] == null ? [] : List<CategoryData>.from(json["data"]!.map((x) => CategoryData.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
    };
}

class CategoryData {
    CategoryData({
        this.id,
        this.title,
        this.image,
    });

    final int? id;
    final String? title;
    final String? image;

    factory CategoryData.fromJson(Map<String, dynamic> json) => CategoryData(
        id: json["id"],
        title: json["title"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
    };
}
