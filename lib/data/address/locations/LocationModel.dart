import 'package:collection/collection.dart';

class LocationModel {
  int? id;
  String? name;
  List<LocationModel>? areas;

  LocationModel({
    this.id,
    this.name,
    this.areas,
  });

  LocationModel? getAreaById(int id) {
    return areas?.where((element) => element.id == id).firstOrNull;
  }

  LocationModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    if (json['areas'] != null) {
      areas = [];
      json['areas'].forEach((v) {
        areas?.add(LocationModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    if (areas != null) {
      map['areas'] = areas?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  @override
  String toString() {
    return name ?? "";
  }
}
