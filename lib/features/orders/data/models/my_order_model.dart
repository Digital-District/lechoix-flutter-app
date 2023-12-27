import 'dart:convert';

MyOrdersResponse myOrdersResponseFromJson(String str) =>
    MyOrdersResponse.fromJson(json.decode(str));

String myOrdersResponseToJson(MyOrdersResponse data) =>
    json.encode(data.toJson());

class MyOrdersResponse {
  MyOrdersResponse({
    this.orders,
    this.success,
  });

  final List<MyOrderData>? orders;
  final bool? success;

  factory MyOrdersResponse.fromJson(Map<String, dynamic> json) =>
      MyOrdersResponse(
        orders: json["orders"] == null
            ? []
            : List<MyOrderData>.from(
                json["orders"]!.map((x) => MyOrderData.fromJson(x))),
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "orders": orders == null
            ? []
            : List<dynamic>.from(orders!.map((x) => x.toJson())),
        "success": success,
      };
}

class MyOrderData {
  MyOrderData({
    this.id,
    this.orderNumber,
    this.total,
    this.createdAt,
    this.status,
    this.image,
    this.name,
  });

  final int? id;
  final String? orderNumber;
  final int? total;
  final DateTime? createdAt;
  final String? status;
  final String? image;
  final dynamic name;

  factory MyOrderData.fromJson(Map<String, dynamic> json) => MyOrderData(
        id: json["id"],
        orderNumber: json["order_number"],
        total:num.tryParse(json["total"])!.toInt() ,
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        status: json["status"],
        image: json["image"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_number": orderNumber,
        "total": total,
        "created_at":
            "${createdAt!.year.toString().padLeft(4, '0')}-${createdAt!.month.toString().padLeft(2, '0')}-${createdAt!.day.toString().padLeft(2, '0')}",
        "status": statusValues.reverse[status],
        "image": image,
        "name": name,
      };
}

enum Status { ORDERED }

final statusValues = EnumValues({
  "ordered": Status.ORDERED,
  "": Status.ORDERED,
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
