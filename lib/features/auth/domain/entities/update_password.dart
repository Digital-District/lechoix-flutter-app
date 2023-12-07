class UpdatePasswordResponse {
  UpdatePasswordResponse({
    required this.result,
    required this.message,
    required this.code,
  });

  final String result;
  final String message;
  final int code;

  factory UpdatePasswordResponse.fromJson(Map<String, dynamic> json) =>
      UpdatePasswordResponse(
        result: json["result"],
        message: json["message"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "code": code,
      };
}
