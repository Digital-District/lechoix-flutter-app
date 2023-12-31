class SizeModel {
  int? id;
  String? name;

  SizeModel({
    this.id,
    this.name,
  });

  SizeModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    return map;
  }

  @override
  String toString() {
    return name ?? "";
  }
}
