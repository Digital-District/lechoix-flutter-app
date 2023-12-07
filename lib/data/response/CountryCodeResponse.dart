import 'package:lechoix/data/model/CountryCodeModel.dart';

class CountryCodeResponse {
  List<CountryCodeModel>? countryCodes;

  CountryCodeResponse.fromJson(dynamic json) {
    if (json['country_codes'] != null) {
      countryCodes = [];
      json['country_codes'].forEach((v) {
        countryCodes?.add(CountryCodeModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (countryCodes != null) {
      map['country_codes'] = countryCodes?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
