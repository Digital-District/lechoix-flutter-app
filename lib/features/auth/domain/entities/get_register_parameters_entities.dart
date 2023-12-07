// class GetRegisterParametersResponse {
//   GetRegisterParametersResponse({
//     required this.result,
//     required this.message,
//     required this.code,
//   });

//   Result result;
//   String message;
//   int code;

//   factory GetRegisterParametersResponse.fromJson(Map<String, dynamic> json) =>
//       GetRegisterParametersResponse(
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
//     required this.countries,
//     required this.workType,
//     required this.licenseType,
//   });

//   List<Country> countries;
//   List<WorkType> workType;
//   List<LicenseType> licenseType;

//   factory Result.fromJson(Map<String, dynamic> json) => Result(
//         countries: List<Country>.from(
//             json["countries"].map((x) => Country.fromJson(x))),
//         workType: List<WorkType>.from(
//             json["work_type"].map((x) => WorkType.fromJson(x))),
//         licenseType: List<LicenseType>.from(
//             json["license_type"].map((x) => LicenseType.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "countries": List<dynamic>.from(countries.map((x) => x.toJson())),
//         "work_type": List<dynamic>.from(workType.map((x) => x.toJson())),
//         "license_type": List<dynamic>.from(licenseType.map((x) => x.toJson())),
//       };
// }

// class Country {
//   Country({
//     required this.countryId,
//     required this.countryName,
//     required this.code,
//   });

//   int countryId;
//   String countryName;
//   String code;

//   factory Country.fromJson(Map<String, dynamic> json) => Country(
//         countryId: json["country_id"],
//         countryName: json["country_name"],
//         code: json["code"],
//       );

//   Map<String, dynamic> toJson() => {
//         "country_id": countryId,
//         "country_name": countryName,
//         "code": code,
//       };
// }

// class LicenseType {
//   LicenseType({
//     required this.licenseTypeId,
//     required this.licenseTypeName,
//   });

//   int licenseTypeId;
//   String licenseTypeName;

//   factory LicenseType.fromJson(Map<String, dynamic> json) => LicenseType(
//         licenseTypeId: json["license_type_id"],
//         licenseTypeName: json["license_type_name"],
//       );

//   Map<String, dynamic> toJson() => {
//         "license_type_id": licenseTypeId,
//         "license_type_name": licenseTypeName,
//       };
// }

// class WorkType {
//   WorkType({
//     required this.workTypeId,
//     required this.workTypeName,
//   });

//   int workTypeId;
//   String workTypeName;

//   factory WorkType.fromJson(Map<String, dynamic> json) => WorkType(
//         workTypeId: json["work_type_id"],
//         workTypeName: json["work_type_name"],
//       );

//   Map<String, dynamic> toJson() => {
//         "work_type_id": workTypeId,
//         "work_type_name": workTypeName,
//       };
// }
