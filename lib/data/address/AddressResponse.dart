import 'AddressModel.dart';

class AddressResponse {
  List<AddressModel>? addresses;

  AddressResponse({
    this.addresses,
  });

  AddressResponse.fromJson(dynamic json) {
    if (json['addresses'] != null) {
      addresses = [];
      json['addresses'].forEach((v) {
        addresses?.add(AddressModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (addresses != null) {
      map['addresses'] = addresses?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
