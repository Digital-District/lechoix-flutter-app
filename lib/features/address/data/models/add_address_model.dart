
import 'dart:convert';

import 'myAddress_model.dart';

AddAddressResponse addAddressResponseFromJson(String str) => AddAddressResponse.fromJson(json.decode(str));

String addAddressResponseToJson(AddAddressResponse data) => json.encode(data.toJson());

class AddAddressResponse {
    AddAddressResponse({
        this.success,
        this.data,
        this.message,
    });

    final String? success;
    final AddressModel? data;
    final String? message;

    factory AddAddressResponse.fromJson(Map<String, dynamic> json) => AddAddressResponse(
        success: json["success"],
        data: json["data"] == null ? null : AddressModel.fromJson(json["data"]),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
        "message": message,
    };
}

// class Data {
//     Data({
//         this.firstName,
//         this.lastName,
//         this.address,
//         this.mobile,
//         this.dataDefault,
//         this.cityId,
//         this.userId,
//         this.id,
//     });

//     final String? firstName;
//     final String? lastName;
//     final String? address;
//     final String? mobile;
//     final String? dataDefault;
//     final String? cityId;
//     final int? userId;
//     final int? id;

//     factory Data.fromJson(Map<String, dynamic> json) => Data(
//         firstName: json["first_name"],
//         lastName: json["last_name"],
//         address: json["address"],
//         mobile: json["mobile"],
//         dataDefault: json["default"],
//         cityId: json["city_id"],
//         userId: json["user_id"],
//         id: json["id"],
//     );

//     Map<String, dynamic> toJson() => {
//         "first_name": firstName,
//         "last_name": lastName,
//         "address": address,
//         "mobile": mobile,
//         "default": dataDefault,
//         "city_id": cityId,
//         "user_id": userId,
//         "id": id,
//     };
// }
