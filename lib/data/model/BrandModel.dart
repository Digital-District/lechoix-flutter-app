class BrandModel {
  int? id;
  String? name;
  String? description;
  int? deliveryDurationDays;
  String? image;
  String? country;

  BrandModel({
    this.id,
    this.name,
    this.description,
    this.deliveryDurationDays,
    this.country,
  });

  BrandModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    deliveryDurationDays = json['delivery_duration_days'];
    image = json['image'];
    country = json['country'].toString();
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['description'] = description;
    map['delivery_duration_days'] = deliveryDurationDays;
    map['image'] = image;
    map['country'] = country;
    return map;
  }
}
