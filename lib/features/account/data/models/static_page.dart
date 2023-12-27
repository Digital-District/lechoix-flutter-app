// To parse this JSON data, do
//
//     final staticPageResponse = staticPageResponseFromJson(jsonString);

import 'dart:convert';

StaticPageResponse staticPageResponseFromJson(String str) => StaticPageResponse.fromJson(json.decode(str));

String staticPageResponseToJson(StaticPageResponse data) => json.encode(data.toJson());

class StaticPageResponse {
    StaticPageResponse({
        this.success,
        this.data,
        this.message,
    });

    String? success;
    PageData? data;
    String? message;

    factory StaticPageResponse.fromJson(Map<String, dynamic> json) => StaticPageResponse(
        success: json["success"],
        data: json["data"] == null ? null : PageData.fromJson(json["data"]),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
        "message": message,
    };
}

class PageData {
    PageData({
        this.id,
        this.name,
        this.description,
    });

    int? id;
    String? name;
    String? description;

    factory PageData.fromJson(Map<String, dynamic> json) => PageData(
        id: json["id"],
        name: json["name"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
    };
}
