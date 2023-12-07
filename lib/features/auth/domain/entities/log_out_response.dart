// To parse this JSON data, do
//
//     final logOutResponse = logOutResponseFromJson(jsonString);

import 'dart:convert';

LogOutResponse logOutResponseFromJson(String str) => LogOutResponse.fromJson(json.decode(str));

String logOutResponseToJson(LogOutResponse data) => json.encode(data.toJson());

class LogOutResponse {
  LogOutResponse({
   required this.message,
    required this.code,
  });

  String message;
  int code;

  factory LogOutResponse.fromJson(Map<String, dynamic> json) => LogOutResponse(
    message: json["message"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "code": code,
  };
}
