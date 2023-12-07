import '../model/BrandModel.dart';

class CartModel {
  int? id;
  int? productId;
  String? name;
  String? subTitle;
  String? price;
  String? currency;
  BrandModel? brand;
  String? salePrice;
  int? quantity;
  String? color;
  String? size;
  String? image;
  bool? isFavorited;
  String? status;

  CartModel({
    this.id,
    this.productId,
    this.name,
    this.subTitle,
    this.price,
    this.currency,
    this.brand,
    this.salePrice,
    this.quantity,
    this.color,
    this.size,
    this.image,
    this.isFavorited,
    this.status,
  });

  CartModel.fromJson(dynamic json) {
    id = json['id'];
    productId = json['product_id'];
    name = json['name'];
    subTitle = json['sub_title'];
    price = json['price'].toString();
    currency = json['currency'];
    brand = json['brand'] != null ? BrandModel.fromJson(json['brand']) : null;
    salePrice = json['sale_price'].toString();
    quantity = json['quantity'];
    color = json['color'];
    size = json['size'];
    image = json['image'];
    isFavorited = json['is_favorited'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['product_id'] = productId;
    map['name'] = name;
    map['sub_title'] = subTitle;
    map['price'] = price;
    map['currency '] = currency;
    if (brand != null) {
      map['brand'] = brand?.toJson();
    }
    map['sale_price'] = salePrice;
    map['quantity'] = quantity;
    map['color'] = color;
    map['size'] = size;
    map['image'] = image;
    map['is_favorited'] = isFavorited;
    map['status'] = status;
    return map;
  }

  bool haveDiscount() {
    String newPrice = salePrice ?? "null";
    return newPrice != "null";
  }

  String get getFavoriteIcon => (isFavorited ?? false)
      ? "assets/images/wishlist_full_icon.png"
      : "assets/images/cart_heart_icon.png";

  String get getFavoriteText =>
      (isFavorited ?? false) ? "Remove from wishlist" : "Move to wishlist";
}
