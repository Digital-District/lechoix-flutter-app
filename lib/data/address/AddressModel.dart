import 'locations/LocationModel.dart';

class AddressModel {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  int? countryCodeId;
  LocationModel? city;
  LocationModel? area;
  String? deliveryAddress;
  String? description;
  bool? isDefault;

  AddressModel({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.countryCodeId,
    this.city,
    this.area,
    this.deliveryAddress,
    this.description,
    this.isDefault,
  });

  AddressModel.fromJson(dynamic json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phone = json['phone'];
    countryCodeId = json['country_code_id'];
    deliveryAddress = json['delivery_address'];
    description = json['description'];
    isDefault = json['is_default'];
    city = json['city'] != null ? LocationModel.fromJson(json['city']) : null;
    area = json['area'] != null ? LocationModel.fromJson(json['area']) : null;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['email'] = email;
    map['phone'] = phone;
    map['country_code_id'] = countryCodeId;
    map['delivery_address'] = deliveryAddress;
    map['description'] = description;
    map['is_default'] = isDefault;
    if (city != null) {
      map['city'] = city?.toJson();
    }
    if (area != null) {
      map['area'] = area?.toJson();
    }
    return map;
  }

  String getName() {
    return "$firstName $lastName";
  }

  String getFullAddress() {
    return "$deliveryAddress, $description";
  }

  String getLocation() {
    return "${city?.name} - ${area?.name}";
  }

  String getDetailAddress() {
    String data = "";
    data += getName();
    data += "\n";
    data += getFullAddress();
    data += "\n";
    data += getLocation();
    data += "\n";
    data += phone ?? "";
    return data;
  }
}
