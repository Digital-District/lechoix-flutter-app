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
      String this.firstName,
      String this.lastName,
      String this.email,
      int this.countryCodeId,
      String this.phone,
      String this.password,
      bool this.receiveAnnouncements);

  AuthRequestModel.login(
      String this.phone, int this.countryCodeId, String this.password);

  AuthRequestModel.verifyPhone(
      String this.phone, int this.countryCodeId, String this.code);

  AuthRequestModel.forgetPassword(
    String this.phone,
    int this.countryCodeId,
  );

  AuthRequestModel.resetPassword(int this.countryCodeId, String this.phone,
      String this.password, String this.code);

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
