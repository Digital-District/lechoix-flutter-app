// To parse this JSON data, do
//
//     final homeSliderResponse = homeSliderResponseFromJson(jsonString);

import 'dart:convert';

HomeSliderResponse homeSliderResponseFromJson(String str) => HomeSliderResponse.fromJson(json.decode(str));

String homeSliderResponseToJson(HomeSliderResponse data) => json.encode(data.toJson());

class HomeSliderResponse {
    HomeSliderResponse({
        this.success,
        this.data,
        this.message,
    });

    final String? success;
    final List<SliderImage>? data;
    final String? message;

    factory HomeSliderResponse.fromJson(Map<String, dynamic> json) => HomeSliderResponse(
        success: json["success"],
        data: json["data"] == [] ? [] : List<SliderImage>.from(json["data"]!.map((x) => SliderImage.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data == null ? [] : List<SliderImage>.from(data!.map((x) => x.toJson())),
        "message": message,
    };
}

class SliderImage {
    SliderImage({
        this.id,
        this.name,
        this.image,
    });

    final int? id;
    final String? name;
    final String? image;

    factory SliderImage.fromJson(Map<String, dynamic> json) => SliderImage(
        id: json["id"],
        name: json["name"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
    };
}
