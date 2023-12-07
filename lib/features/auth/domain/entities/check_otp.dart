// import 'dart:convert';

// CheckOtpResponse checkOtpResponseFromJson(String str) =>
//     CheckOtpResponse.fromJson(json.decode(str));

// String checkOtpResponseToJson(CheckOtpResponse data) =>
//     json.encode(data.toJson());

// class CheckOtpResponse {
//   CheckOtpResponse({
//     required this.result,
//     required this.message,
//     required this.code,
//   });

//   Result result;
//   String message;
//   int code;

//   factory CheckOtpResponse.fromJson(Map<String, dynamic> json) =>
//       CheckOtpResponse(
//         result: Result.fromJson(json["result"]),
//         message: json["message"],
//         code: json["code"],
//       );

//   Map<String, dynamic> toJson() => {
//         "result": result.toJson(),
//         "message": message,
//         "code": code,
//       };
// }

// class Result {
//   Result({
//     required this.userId,
//     required this.partnerId,
//     required this.userName,
//     required this.userPhone,
//     required this.userEmail,
//     required this.userOtp,
//     required this.userPhoto,
//   });

//   int userId;
//   int partnerId;
//   String userName;
//   String userPhone;
//   String userEmail;
//   String userOtp;
//   String userPhoto;

//   factory Result.fromJson(Map<String, dynamic> json) => Result(
//         userId: json["user_id"],
//         partnerId: json["partner_id"],
//         userName: json["user_name"],
//         userPhone: json["user_phone"],
//         userEmail: json["user_email"],
//         userOtp: json["user_otp"],
//         userPhoto: json["user_photo"],
//       );

//   Map<String, dynamic> toJson() => {
//         "user_id": userId,
//         "partner_id": partnerId,
//         "user_name": userName,
//         "user_phone": userPhone,
//         "user_email": userEmail,
//         "user_otp": userOtp,
//         "user_photo": userPhoto,
//       };
// }
// To parse this JSON data, do
//
//     final checkOtpResponse = checkOtpResponseFromJson(jsonString);

class CheckOtpResponse {
  CheckOtpResponse({
    required this.result,
    required this.message,
    required this.code,
  });

  final CheckOtpCode result;
  final String message;
  final int code;

  factory CheckOtpResponse.fromJson(Map<String, dynamic> json) =>
      CheckOtpResponse(
        result: CheckOtpCode.fromJson(json["result"]),
        message: json["message"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "result": result.toJson(),
        "message": message,
        "code": code,
      };
}

class CheckOtpCode {
  CheckOtpCode({
    required this.userId,
    required this.partnerId,
    required this.userName,
    required this.userPhone,
    required this.userEmail,
    required this.userOtp,
    required this.companyId,
    required this.userPhoto,
    required this.sex,
    required this.countryId,
    required this.workTypeId,
    required this.stateId,
    required this.employer,
    required this.dateOfBirth,
    required this.licenseTypeId,
    required this.licenseNo,
    required this.passportNo,
  });

  final int userId;
  final int partnerId;
  final String userName;
  final String userPhone;
  final String userEmail;
  final String userOtp;
  final int companyId;
  final String userPhoto;
  final String sex;
  final int countryId;
  final String workTypeId;
  final String stateId;
  final String employer;
  final DateTime dateOfBirth;
  final String licenseTypeId;
  final String licenseNo;
  final String passportNo;

  factory CheckOtpCode.fromJson(Map<String, dynamic> json) => CheckOtpCode(
        userId: json["user_id"],
        partnerId: json["partner_id"],
        userName: json["user_name"],
        userPhone: json["user_phone"],
        userEmail: json["user_email"],
        userOtp: json["user_otp"],
        companyId: json["company_id"],
        userPhoto: json["user_photo"],
        sex: json["sex"],
        countryId: json["country_id"],
        workTypeId: json["work_type_id"],
        stateId: json["state_id"],
        employer: json["employer"],
        dateOfBirth: DateTime.parse(json["date_of_birth"]),
        licenseTypeId: json["license_type_id"],
        licenseNo: json["license_no"],
        passportNo: json["passport_no"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "partner_id": partnerId,
        "user_name": userName,
        "user_phone": userPhone,
        "user_email": userEmail,
        "user_otp": userOtp,
        "company_id": companyId,
        "user_photo": userPhoto,
        "sex": sex,
        "country_id": countryId,
        "work_type_id": workTypeId,
        "state_id": stateId,
        "employer": employer,
        "date_of_birth":
            "${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}",
        "license_type_id": licenseTypeId,
        "license_no": licenseNo,
        "passport_no": passportNo,
      };
}
