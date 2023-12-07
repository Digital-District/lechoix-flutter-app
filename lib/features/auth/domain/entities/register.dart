import 'dart:convert';

RegisterResponse RegisterResponseFromJson(String str) =>
    RegisterResponse.fromJson(json.decode(str));

String RegisterResponseToJson(RegisterResponse data) =>
    json.encode(data.toJson());

class RegisterResponse {
  RegisterResponse({
    this.success,
    this.data,
    this.token,
    this.message,
  });

  final dynamic success;
  final RegisterData? data;
  final String? token;
  final String? message;

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      RegisterResponse(
        success: json["success"],
        data: json["data"] == null ? null : RegisterData.fromJson(json["data"]),
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

class RegisterData {
  RegisterData({
    this.name,
    this.email,
    this.phone,
    this.id,
  });

  final String? name;
  final String? email;
  final String? phone;
  final int? id;

  factory RegisterData.fromJson(Map<String, dynamic> json) => RegisterData(
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "phone": phone,
        "id": id,
      };
}
