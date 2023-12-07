class AuthRequestModel {
  String? firstName;
  String? lastName;
  String? email;
  int? countryCodeId;
  String? phone;
  String? password;
  bool? receiveAnnouncements;
  String? code;

  AuthRequestModel.register(
      String firstName,
      String lastName,
      String email,
      int countryCodeId,
      String phone,
      String password,
      bool receiveAnnouncements) {
    this.firstName = firstName;
    this.lastName = lastName;
    this.email = email;
    this.countryCodeId = countryCodeId;
    this.phone = phone;
    this.password = password;
    this.receiveAnnouncements = receiveAnnouncements;
  }

  AuthRequestModel.login(String phone, int countryCodeId, String password) {
    this.countryCodeId = countryCodeId;
    this.phone = phone;
    this.password = password;
  }

  AuthRequestModel.verifyPhone(String phone, int countryCodeId, String code) {
    this.countryCodeId = countryCodeId;
    this.phone = phone;
    this.code = code;
  }

  AuthRequestModel.forgetPassword(
    String phone,
    int countryCodeId,
  ) {
    this.countryCodeId = countryCodeId;
    this.phone = phone;
  }

  AuthRequestModel.resetPassword(
      int countryCodeId, String phone, String password, String code) {
    this.countryCodeId = countryCodeId;
    this.phone = phone;
    this.password = password;
    this.code = code;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (firstName != null) {
      map['first_name'] = firstName;
    }
    if (lastName != null) {
      map['last_name'] = lastName;
    }
    if (email != null) {
      map['email'] = email;
    }
    if (countryCodeId != null) {
      map['country_code_id'] = countryCodeId;
    }
    if (phone != null) {
      map['phone'] = phone;
    }
    if (password != null) {
      map['password'] = password;
    }
    if (receiveAnnouncements != null) {
      map['receive_announcements'] = receiveAnnouncements;
    }
    if (code != null) {
      map['code'] = code;
    }
    return map;
  }
}
