
import 'dart:convert';

import '../../../auth/domain/entities/login.dart';

class EditProfileResponse {
    EditProfileResponse({
        this.user,
        this.status,
        this.message,
    });

    final User? user;
    final bool? status;
    final String? message;

    EditProfileResponse copyWith({
        User? user,
        bool? status,
        String? message,
    }) => 
        EditProfileResponse(
            user: user ?? this.user,
            status: status ?? this.status,
            message: message ?? this.message,
        );

    factory EditProfileResponse.fromRawJson(String str) => EditProfileResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory EditProfileResponse.fromJson(Map<String, dynamic> json) => EditProfileResponse(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "status": status,
        "message": message,
    };
}

// class User {
//     User({
//         this.id,
//         this.name,
//         this.email,
//         this.phone,
//         this.countryId,
//         this.image,
//         this.points,
//         this.code,
//         this.active,
//         this.status,
//     });

//     final int? id;
//     final String? name;
//     final String? email;
//     final String? phone;
//     final int? countryId;
//     final String? image;
//     final int? points;
//     final dynamic code;
//     final int? active;
//     final int? status;

//     User copyWith({
//         int? id,
//         String? name,
//         String? email,
//         String? phone,
//         int? countryId,
//         String? image,
//         int? points,
//         dynamic code,
//         int? active,
//         int? status,
//     }) => 
//         User(
//             id: id ?? this.id,
//             name: name ?? this.name,
//             email: email ?? this.email,
//             phone: phone ?? this.phone,
//             countryId: countryId ?? this.countryId,
//             image: image ?? this.image,
//             points: points ?? this.points,
//             code: code ?? this.code,
//             active: active ?? this.active,
//             status: status ?? this.status,
//         );

//     factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

//     String toRawJson() => json.encode(toJson());

//     factory User.fromJson(Map<String, dynamic> json) => User(
//         id: json["id"],
//         name: json["name"],
//         email: json["email"],
//         phone: json["phone"],
//         countryId: json["country_id"],
//         image: json["image"],
//         points: json["points"],
//         code: json["code"],
//         active: json["active"],
//         status: json["status"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "email": email,
//         "phone": phone,
//         "country_id": countryId,
//         "image": image,
//         "points": points,
//         "code": code,
//         "active": active,
//         "status": status,
//     };
// }
