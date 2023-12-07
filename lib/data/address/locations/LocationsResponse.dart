import 'package:collection/collection.dart';

import 'LocationModel.dart';

class LocationsResponse {
  List<LocationModel>? cities;

  LocationsResponse({
    this.cities,
  });

  LocationModel? getCityById(int id) {
    return cities?.where((element) => element.id == id).firstOrNull;
  }

  LocationsResponse.fromJson(dynamic json) {
    if (json['cities'] != null) {
      cities = [];
      json['cities'].forEach((v) {
        cities?.add(LocationModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (cities != null) {
      map['cities'] = cities?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
