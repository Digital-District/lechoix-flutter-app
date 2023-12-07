import 'HomeItemModel.dart';

class HomeResponse {
  List<HomeItemModel>? section1;
  HomeItemModel? section2;
  List<HomeItemModel>? section3;
  HomeItemModel? section4;
  HomeItemModel? section5;

  HomeResponse.fromJson(dynamic json) {
    if (json['section_1'] != null) {
      section1 = [];
      json['section_1'].forEach((v) {
        section1?.add(HomeItemModel.fromJson(v));
      });
    }

    section2 = json['section_2'] != null
        ? HomeItemModel.fromJson(json['section_2'])
        : null;

    if (json['section_3'] != null) {
      section3 = [];
      json['section_3'].forEach((v) {
        section3?.add(HomeItemModel.fromJson(v));
      });
    }
    section4 = json['section_4'] != null
        ? HomeItemModel.fromJson(json['section_4'])
        : null;
    section5 = json['section_5'] != null
        ? HomeItemModel.fromJson(json['section_5'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (section1 != null) {
      map['section_1'] = section1?.map((v) => v.toJson()).toList();
    }

    if (section2 != null) {
      map['section_2'] = section2?.toJson();
    }

    if (section3 != null) {
      map['section_3'] = section3?.map((v) => v.toJson()).toList();
    }
    if (section4 != null) {
      map['section_4'] = section4?.toJson();
    }
    if (section5 != null) {
      map['section_5'] = section5?.toJson();
    }
    return map;
  }

  List<HomeItemModel> getFirstBrandSection() {
    List<HomeItemModel>? brands = [];
    brands.addAll(section3 ?? []);
    if (brands.length > 1) {
      brands.removeLast();
    }
    return brands;
  }

  List<HomeItemModel> getLastBrandSection() {
    List<HomeItemModel>? brands = [];
    int originListCount = section3?.length ?? 0;
    if (originListCount > 1) {
      brands.add(section3!.last);
    }
    return brands;
  }
}
