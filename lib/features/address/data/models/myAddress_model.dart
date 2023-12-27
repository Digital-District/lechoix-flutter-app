import 'dart:convert';

MyAddressResponse myAddressResponseFromJson(String str) =>
    MyAddressResponse.fromJson(json.decode(str));

String myAddressResponseToJson(MyAddressResponse data) =>
    json.encode(data.toJson());

class MyAddressResponse {
  MyAddressResponse({
    this.success,
    this.data,
    this.message,
  });

  final String? success;
  final List<AddressModel>? data;
  final String? message;

  factory MyAddressResponse.fromJson(Map<String, dynamic> json) =>
      MyAddressResponse(
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<AddressModel>.from(
                json["data"]!.map((x) => AddressModel.fromJson(x))),
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

class AddressModel {
  AddressModel(
      {this.id,
      this.cityId,
      this.firstName,
      this.lastName,
      this.mobile,
      this.address,
      this.addresDefault,
      this.cityName,
      this.shippingCost,
      this.userId});

  final int? id;
  final int? cityId;
  final String? firstName;
  final String? lastName;
  final String? mobile;
  final String? address;
  final int? addresDefault;
  final String? cityName;
  final int? shippingCost;
  final int? userId;

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        id: json["id"],
        cityId: int.parse("${json["city_id"]}"),
        firstName: json["first_name"],
        lastName: json["last_name"],
        mobile: json["mobile"],
        address: json["address"],
        addresDefault: int.parse("${json["default"]}"),
        cityName: json["city_name"],
        shippingCost: num.tryParse(json["shipping_cost"]??"0")!.toInt(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "city_id": cityId,
        "first_name": firstName,
        "last_name": lastName,
        "mobile": mobile,
        "address": address,
        "default": addresDefault,
        "city_name": cityName,
        "shipping_cost": shippingCost,
      };
}
