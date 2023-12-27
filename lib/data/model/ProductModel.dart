import 'package:flutter/material.dart';
import 'BrandModel.dart';
import 'ColorModel.dart';
import 'SizeModel.dart';
import 'VariationModel.dart';

class ProductModel {
  int? id;
  String? name;
  String? subTitle;
  String? description;
  String? sizeFit;
  String? price;
  String? salePrice;
  String? sizeGuide;
  String? currency;
  String? image;
  BrandModel? brand;
  bool? isFavorite;
  bool? isNew;
  int? stock;
  List<String>? images;
  List<ColorModel>? colors;
  List<SizeModel>? _sizes;
  List<VariationModel>? variations;
  List<ProductModel>? brandProducts;
  List<ProductModel>? relatedProducts;

  // TODO shippingAndReturns, productCode,
  // TODO price in variation with discount

  List<String> get imageGallery {
    List<String> list = [];
    if (image != null) list.add(image ?? "");
    list.addAll(images ?? []);
    return list;
  }

  bool get isOutOfStock => stock == 0;

  bool get isLimitedNumberRemaining => (stock ?? 0) < 5 && (stock ?? 0) > 0;

  String get getFavoriteIcon => (isFavorite ?? false)
      ? "assets/images/wishlist_full_icon.png"
      : "assets/images/wishlist_empty_icon.png";

  IconData get getFavoriteIconData =>
      (isFavorite ?? false) ? Icons.favorite : Icons.favorite_border;

  bool haseDiscount() {
    String price = salePrice ?? "";

    return price != "null";
  }

  ProductModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    subTitle = json['sub_title'];
    description = json['description'];
    sizeFit = json['size_fit'];
    price = json['price'].toString();
    salePrice = json['sale_price'].toString();
    currency = json['currency'];
    image = json['image'];
    brand = json['brand'] != null ? BrandModel.fromJson(json['brand']) : null;
    isFavorite = json['is_favorited'];
    isNew = json['is_new'];
    stock = json['stock'];
    sizeGuide = json['size_guide'];
    images = json['images'] != null ? json['images'].cast<String>() : [];
    if (json['colors'] != null) {
      colors = [];
      json['colors'].forEach((v) {
        colors?.add(ColorModel.fromJson(v));
      });
    }
    if (json['sizes'] != null) {
      _sizes = [];
      json['sizes'].forEach((v) {
        _sizes?.add(SizeModel.fromJson(v));
      });
    }
    if (json['variations'] != null) {
      variations = [];
      json['variations'].forEach((v) {
        variations?.add(VariationModel.fromJson(v));
      });
    }
    if (json['brand_products'] != null) {
      brandProducts = [];
      json['brand_products'].forEach((v) {
        brandProducts?.add(ProductModel.fromJson(v));
      });
    }
    if (json['related_products'] != null) {
      relatedProducts = [];
      json['related_products'].forEach((v) {
        relatedProducts?.add(ProductModel.fromJson(v));
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
    map['image'] = image;
    map['size_guide'] = sizeGuide ;
    if (brand != null) {
      map['brand'] = brand?.toJson();
    }
    map['is_favorited'] = isFavorite;
    map['is_new'] = isNew;
    map['stock'] = stock;
    if (colors != null) {
      map['colors'] = colors?.map((v) => v.toJson()).toList();
    }
    if (_sizes != null) {
      map['sizes'] = _sizes?.map((v) => v.toJson()).toList();
    }

    if (variations != null) {
      map['variations'] = variations?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  bool haseSizes() {
    return _sizes != null && (_sizes?.isNotEmpty == true);
  }
  SizeModel? getFirstSizeValue(ColorModel? selectedColor) {
    if (selectedColor != null) {
      List<SizeModel> dataList = getAvailableSizes(selectedColor) ?? [];
      if (dataList.isNotEmpty == true) {
        return dataList[0] ;
      }
      return null ;
    }
   else if (_sizes != null && _sizes?.isNotEmpty == true) {
      return _sizes?[0];
    }
    return null;
  }

  List<SizeModel>? getAvailableSizes(ColorModel? selectedColor) {
    if (selectedColor!= null && _sizes != null && variations != null) {
      List<SizeModel> dataList = [];
      variations?.forEach((element) {
        if (element.color?.id == selectedColor.id ) {
          dataList.add(element.size ?? SizeModel());
        }
      });
      return dataList;
    }
    return _sizes;
  }


}


