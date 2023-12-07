class ColorModel {
  int? id;
  String? name;
  String? hexCode;
  String? image;
  List<String>? images;

  ColorModel({
    this.id,
    this.name,
    this.hexCode,
    this.image,
    this.images,
  });

  List<String>? get imagesOrNull {
    if (images == null || (images?.isEmpty == true)) {
      return null;
    }
    return images;
  }

  ColorModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    hexCode = json['hexa_code'];
    image = json['image'];
    images = json['images'] != null ? json['images'].cast<String>() : [];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['hexa_code'] = hexCode;
    map['image'] = image;
    map['images'] = images;
    return map;
  }

  @override
  String toString() {
    return name ?? "";
  }
}
