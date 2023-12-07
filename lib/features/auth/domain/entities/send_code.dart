class SendCodeForForgetPasswordResponse {
  SendCodeForForgetPasswordResponse({
    required this.result,
    required this.message,
    required this.code,
    required this.userOtp,
  });

  final String result;
  final String message;
  final int code;
  final String userOtp;

  factory SendCodeForForgetPasswordResponse.fromJson(
          Map<String, dynamic> json) =>
      SendCodeForForgetPasswordResponse(
        result: json["result"],
        message: json["message"],
        code: json["code"],
        userOtp: json["user_otp"],
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "code": code,
        "user_otp": userOtp,
      };
}
