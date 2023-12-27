// To parse this JSON data, do
//
//     final notificationsResponse = notificationsResponseFromJson(jsonString);

import 'dart:convert';

NotificationsResponse notificationsResponseFromJson(String str) => NotificationsResponse.fromJson(json.decode(str));

String notificationsResponseToJson(NotificationsResponse data) => json.encode(data.toJson());

class NotificationsResponse {
    NotificationsResponse({
        this.notifications,
        this.success,
    });

    List<NotificationModel>? notifications;
    bool? success;

    factory NotificationsResponse.fromJson(Map<String, dynamic> json) => NotificationsResponse(
        notifications: json["notifications"] == null ? [] : List<NotificationModel>.from(json["notifications"]!.map((x) => NotificationModel.fromJson(x))),
        success: json["success"],
    );

    Map<String, dynamic> toJson() => {
        "notifications": notifications == null ? [] : List<dynamic>.from(notifications!.map((x) => x.toJson())),
        "success": success,
    };
}

class NotificationModel {
    NotificationModel({
        this.id,
        this.name,
        this.desc,
        this.createdAt,
    });

    int? id;
    String? name;
    String? desc;
    String? createdAt;

    factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
        id: json["id"],
        name: json["name"],
        desc: json["desc"],
        createdAt: json["created_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "desc": desc,
        "created_at": createdAt,
    };
}
