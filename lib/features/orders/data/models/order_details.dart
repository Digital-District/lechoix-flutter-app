import 'dart:convert';

OrderDetailsResponse orderDetailsResponseFromJson(String str) =>
    OrderDetailsResponse.fromJson(json.decode(str));

String orderDetailsResponseToJson(OrderDetailsResponse data) =>
    json.encode(data.toJson());

class OrderDetailsResponse {
  OrderDetailsResponse({
    this.order,
    this.tax,
    this.success,
  });

  final OrderDetails? order;
  final int? tax;
  final bool? success;

  factory OrderDetailsResponse.fromJson(Map<String, dynamic> json) =>
      OrderDetailsResponse(
        order:
            json["order"] == null ? null : OrderDetails.fromJson(json["order"]),
        tax:  num.tryParse(json["tax"] ?? "0")!.toInt(),
        // json["tax"],
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "order": order?.toJson(),
        "tax": tax,
        "success": success,
      };
}

class OrderDetails {
  OrderDetails({
    this.status,
    this.id,
    this.orderNumber,
    this.createdAt,
    this.total,
    this.method,
    this.discount,
    this.shippingCost,
    this.firstName,
    this.lastName,
    this.mobile,
    this.address,
    this.cityId,
    this.name,
    this.image,
    this.items,
  });

  final String? status;
  final int? id;
  final String? orderNumber;
  final DateTime? createdAt;
  final int? total;
  final String? method;
  final int? discount;
  final int? shippingCost;
  final String? firstName;
  final String? lastName;
  final String? mobile;
  final String? address;
  final int? cityId;
  final dynamic name;
  final String? image;
  final List<Item>? items;

  factory OrderDetails.fromJson(Map<String, dynamic> json) => OrderDetails(
        status: json["status"],
        id: json["id"],
        orderNumber: json["order_number"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        total: num.tryParse(json["total"] ?? "0")!.toInt(),
        method: json["method"],
        discount: num.tryParse(json["discount"] ?? "0")!.toInt(),
        shippingCost: num.tryParse(json["shipping_cost"] ?? "0")!.toInt(),
        firstName: json["first_name"],
        lastName: json["last_name"],
        mobile: json["mobile"],
        address: json["address"],
        cityId: num.tryParse(json["city_id"] ?? "0")!.toInt(),
        name: json["name"],
        image: json["image"],
        items: json["items"] == null
            ? []
            : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "id": id,
        "order_number": orderNumber,
        "created_at":
            "${createdAt!.year.toString().padLeft(4, '0')}-${createdAt!.month.toString().padLeft(2, '0')}-${createdAt!.day.toString().padLeft(2, '0')}",
        "total": total,
        "method": method,
        "discount": discount,
        "shipping_cost": shippingCost,
        "first_name": firstName,
        "last_name": lastName,
        "mobile": mobile,
        "address": address,
        "city_id": cityId,
        "name": name,
        "image": image,
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}

class Item {
  Item({
    this.orderId,
    this.productId,
    this.quantity,
    this.price,
    this.productoptionvalue,
  });

  final int? orderId;
  final int? productId;
  final int? quantity;
  final int? price;
  final Productoptionvalue? productoptionvalue;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        orderId: num.tryParse(json["order_id"] ?? "0")!.toInt(),
        // json["order_id"],
        productId: num.tryParse(json["product_id"] ?? "0")!.toInt(),
        quantity: num.tryParse(json["quantity"] ?? "0")!.toInt(),
        price: num.tryParse(json["price"] ?? "0")!.toInt(),
        productoptionvalue: json["productoptionvalue"] == null
            ? null
            : Productoptionvalue.fromJson(json["productoptionvalue"]),
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "product_id": productId,
        "quantity": quantity,
        "price": price,
        "productoptionvalue": productoptionvalue?.toJson(),
      };
}

class Productoptionvalue {
  Productoptionvalue({
    this.id,
    this.productId,
    this.productOptionId,
    this.optionId,
    this.optionValueId,
    this.quantity,
    this.price,
    this.points,
    this.weight,
    this.posPrice,
    this.salePrice,
    this.warehouseId,
    this.supplierId,
    this.transferId,
    this.barcode,
    this.sku,
    this.values,
    this.name,
    this.image,
  });

  final int? id;
  final int? productId;
  final int? productOptionId;
  final int? optionId;
  final String? optionValueId;
  final int? quantity;
  final String? price;
  final dynamic points;
  final String? weight;
  final double? posPrice;
  final int? salePrice;
  final int? warehouseId;
  final int? supplierId;
  final dynamic transferId;
  final int? barcode;
  final dynamic sku;
  final List<Value>? values;
  final String? name;
  final String? image;

  factory Productoptionvalue.fromJson(Map<String, dynamic> json) =>
      Productoptionvalue(
        id: json["id"],
        productId: num.tryParse(json["product_id"] ?? "0")!.toInt(),
        productOptionId:
            num.tryParse(json["product_option_id"] ?? "0")!.toInt(),
        optionId: num.tryParse(json["option_id"] ?? "0")!.toInt(),
        optionValueId: json["option_value_id"],
        quantity: num.tryParse(json["quantity"] ?? "0")!.toInt(),
        price: json["price"],
        points: json["points"],
        weight: json["weight"],
        posPrice: num.tryParse(json["pos_price"] ?? "0")!.toDouble(),
        salePrice: json["sale_price"],
        warehouseId: num.tryParse(json["warehouse_id"] ?? "0")!.toInt(),
        supplierId: num.tryParse(json["supplier_id"] ?? "0")!.toInt(),
        transferId: json["transfer_id"],
        barcode: num.tryParse(json["barcode"] ?? "0")!.toInt(),
        sku: json["sku"],
        values: json["values"] == null
            ? []
            : List<Value>.from(json["values"]!.map((x) => Value.fromJson(x))),
        name: json["name"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "product_option_id": productOptionId,
        "option_id": optionId,
        "option_value_id": optionValueId,
        "quantity": quantity,
        "price": price,
        "points": points,
        "weight": weight,
        "pos_price": posPrice,
        "sale_price": salePrice,
        "warehouse_id": warehouseId,
        "supplier_id": supplierId,
        "transfer_id": transferId,
        "barcode": barcode,
        "sku": sku,
        "values": values == null
            ? []
            : List<dynamic>.from(values!.map((x) => x.toJson())),
        "name": name,
        "image": image,
      };
}

class Value {
  Value({
    this.id,
    this.name,
    this.optionId,
    this.optionName,
  });

  final int? id;
  final String? name;
  final int? optionId;
  final String? optionName;

  factory Value.fromJson(Map<String, dynamic> json) => Value(
        id: json["id"],
        name: json["name"],
        optionId: num.tryParse(json["option_id"] ?? "0")!.toInt(),
        optionName: json["option_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "option_id": optionId,
        "option_name": optionName,
      };
}
