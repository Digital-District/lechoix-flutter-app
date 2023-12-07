class AddAddressRequestModel {
  String? firstName;
  String? lastName;
  String? email;
  String? countryCode;
  String? phone;
  int? cityId;
  int? areaId;
  String? deliveryAddress;
  String? description;
  bool? isDefault;

  AddAddressRequestModel({
    this.firstName,
    this.lastName,
    this.email,
    this.countryCode,
    this.phone,
    this.cityId,
    this.areaId,
    this.deliveryAddress,
    this.description,
    this.isDefault,
  });

  AddAddressRequestModel.fromJson(dynamic json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    countryCode = json['country_code'];
    phone = json['phone'];
    cityId = json['city_id'];
    areaId = json['area_id'];
    deliveryAddress = json['delivery_address'];
    description = json['description'];
    isDefault = json['is_default'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['email'] = email;
    map['country_code'] = countryCode;
    map['phone'] = phone;
    map['city_id'] = cityId;
    map['area_id'] = areaId;
    map['delivery_address'] = deliveryAddress;
    map['description'] = description;
    map['is_default'] = isDefault;
    return map;
  }
}
