import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
    LoginResponse({
        this.success,
        this.data,
        this.token,
        this.message,
    });

    final String? success;
     User? data;
    final String? token;
    final String? message;

    factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        success: json["success"],
        data: json["data"] == null ? null : User.fromJson(json["data"]),
        token: json["token"],
        message: json["message"],
    );
    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
        "token": token,
        "message": message,
    };
}

class User {
    User({
        this.id,
        this.name,
        this.email,
        this.phone,
        this.countryId,
        this.image,
        this.points,
        this.code,
        this.active,
        this.status,
    });

    final int? id;
    final dynamic name;
    final String? email;
    final String? phone;
    final dynamic countryId;
    final String? image;
    final String? points;
    final dynamic code;
    final String? active;
    final String? status;

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        countryId: json["country_id"],
        image: json["image"],
        points: json["points"],
        code: json["code"],
        active: json["active"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "country_id": countryId,
        "image": image,
        "points": points,
        "code": code,
        "active": active,
        "status": status,
    };
}
