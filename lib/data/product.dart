import 'model/BrandModel.dart';

class Product {
  int? id;
  String? name;
  String? subTitle;
  String? description;
  String? sizeFit;
  int? price;
  String? salePrice;
  String? currency;
  bool? isNew;
  bool? isFavorited;
  List<String>? images;
  List<Colors>? colors;
  List<Sizes>? sizes;
  BrandModel? brand;
  List<Variations>? variations;

  Product({
    this.id,
    this.name,
    this.subTitle,
    this.description,
    this.sizeFit,
    this.price,
    this.salePrice,
    this.currency,
    this.isNew,
    this.isFavorited,
    this.images,
    this.colors,
    this.sizes,
    this.brand,
    this.variations,
  });

  Product.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    subTitle = json['sub_title'];
    description = json['description'];
    sizeFit = json['size_fit'];
    price = json['price'];
    salePrice = json['sale_price'].toString();
    currency = json['currency'];
    isNew = json['is_new'];
    isFavorited = json['is_favorited'];
    images = json['images'] != null ? json['images'].cast<String>() : [];
    if (json['colors'] != null) {
      colors = [];
      json['colors'].forEach((v) {
        colors?.add(Colors.fromJson(v));
      });
    }
    if (json['sizes'] != null) {
      sizes = [];
      json['sizes'].forEach((v) {
        sizes?.add(Sizes.fromJson(v));
      });
    }
    brand = json['brand'] != null ? BrandModel.fromJson(json['brand']) : null;
    if (json['variations'] != null) {
      variations = [];
      json['variations'].forEach((v) {
        variations?.add(Variations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['sub_title'] = subTitle;
    map['description'] = description;
    map['size_fit'] = sizeFit;
    map['price'] = price;
    map['sale_price'] = salePrice;
    map['currency'] = currency;
    map['is_new'] = isNew;
    map['is_favorited'] = isFavorited;
    map['images'] = images;
    if (colors != null) {
      map['colors'] = colors?.map((v) => v.toJson()).toList();
    }
    if (sizes != null) {
      map['sizes'] = sizes?.map((v) => v.toJson()).toList();
    }
    if (brand != null) {
      map['brand'] = brand?.toJson();
    }
    if (variations != null) {
      map['variations'] = variations?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Variations {
  Variations({
    this.id,
    this.price,
    this.colorId,
    this.sizeId,
  });

  Variations.fromJson(dynamic json) {
    id = json['id'];
    price = json['price'];
    colorId = json['color_id'];
    sizeId = json['size_id'];
  }

  int? id;
  int? price;
  int? colorId;
  int? sizeId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['price'] = price;
    map['color_id'] = colorId;
    map['size_id'] = sizeId;
    return map;
  }
}

class Sizes {
  Sizes({
    this.id,
    this.name,
  });

  Sizes.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }

  int? id;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    return map;
  }
}

class Colors {
  Colors({
    this.id,
    this.name,
    this.hexaCode,
    this.image,
    this.images,
  });

  Colors.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    hexaCode = json['hexa_code'];
    image = json['image'];
    images = json['images'] != null ? json['images'].cast<String>() : [];
  }

  int? id;
  String? name;
  String? hexaCode;
  String? image;
  List<String>? images;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['hexa_code'] = hexaCode;
    map['image'] = image;
    map['images'] = images;
    return map;
  }
}
