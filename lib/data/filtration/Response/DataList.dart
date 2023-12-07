class FiltrationModel {
  int? id;
  String? name;
  String? hex;
  String? image;

  FiltrationModel({
    this.id,
    this.name,
    this.hex,
    this.image,
  });

  FiltrationModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    hex = json['hex'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['hex'] = hex;
    map['image'] = image;
    return map;
  }
}
