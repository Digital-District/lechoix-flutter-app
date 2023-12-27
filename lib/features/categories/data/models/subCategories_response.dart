// To parse this JSON data, do
//
//     final subCategoriesByCatResponse = subCategoriesByCatResponseFromJson(jsonString);

import 'dart:convert';

SubCategoriesByCatResponse subCategoriesByCatResponseFromJson(String str) =>
    SubCategoriesByCatResponse.fromJson(json.decode(str));

String subCategoriesByCatResponseToJson(SubCategoriesByCatResponse data) =>
    json.encode(data.toJson());

class SubCategoriesByCatResponse {
  String? success;
  List<SubCategory>? data;
  String? message;

  SubCategoriesByCatResponse({
    this.success,
    this.data,
    this.message,
  });

  factory SubCategoriesByCatResponse.fromJson(Map<String, dynamic> json) =>
      SubCategoriesByCatResponse(
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<SubCategory>.from(
                json["data"]!.map((x) => SubCategory.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
      };
}

class SubCategory {
  int? id;
  String? title;
  String? image;

  SubCategory({
    this.id,
    this.title,
    this.image,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
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
