class AuthResponseModel {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  int? countryCodeId;
  String? localization;
  bool? isPhoneVerified;
  String? accessToken;
  String? avatar;

  AuthResponseModel(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.phone,
      this.countryCodeId,
      this.localization,
      this.isPhoneVerified,
      this.accessToken,
      this.avatar});

  AuthResponseModel.fromJson(dynamic json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phone = json['phone'];
    countryCodeId = json['country_code_id'];
    localization = json['localization'];
    isPhoneVerified = json['is_phone_verified'];
    accessToken = json['access_token'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['email'] = email;
    map['phone'] = phone;
    map['country_code_id'] = countryCodeId;
    map['localization'] = localization;
    map['is_phone_verified'] = isPhoneVerified;
    map['access_token'] = accessToken;
    map['avatar'] = avatar;
    return map;
  }
}
