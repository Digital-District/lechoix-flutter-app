// To parse this JSON data, do
//
//     final citiesResponse = citiesResponseFromJson(jsonString);

import 'dart:convert';

CitiesResponse citiesResponseFromJson(String str) => CitiesResponse.fromJson(json.decode(str));

String citiesResponseToJson(CitiesResponse data) => json.encode(data.toJson());

class CitiesResponse {
    CitiesResponse({
        this.cities,
        this.success,
    });

    final List<City>? cities;
    final bool? success;

    factory CitiesResponse.fromJson(Map<String, dynamic> json) => CitiesResponse(
        cities: json["cities"] == [] ? [] : List<City>.from(json["cities"]!.map((x) => City.fromJson(x))),
        success: json["success"],
    );

    Map<String, dynamic> toJson() => {
        "cities": cities == null ? [] : List<dynamic>.from(cities!.map((x) => x.toJson())),
        "success": success,
    };
}

class City {
    City({
        this.id,
        this.name,
        this.countryId,
        this.shippingCost,
        this.createdAt,
        this.updatedAt,
    });

    final int? id;
    final String? name;
    final int? countryId;
    final int? shippingCost;
    final dynamic createdAt;
    final dynamic updatedAt;

    factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["id"],
        name: json["name"],
        countryId: json["country_id"] !=null ? int.parse(json["country_id"]) :0,
        shippingCost:json["shipping_cost"] !=null ? int.parse(json["shipping_cost"]) :0,
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "country_id": countryId,
        "shipping_cost": shippingCost,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}
