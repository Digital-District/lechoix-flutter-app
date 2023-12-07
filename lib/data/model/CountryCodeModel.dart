import 'package:lechoix/cache/user_cache.dart';

class CountryCodeModel {
  int? id;
  String? nameAr;
  String? nameEn;
  String? regex;
  String? code;
  String? flag;

  String get codeWithName {
    String? name = UserCache.instance.isArabic() ? nameAr : nameEn;
    return "${code ?? ""} ${name ?? ""}".trim();
  }

  CountryCodeModel.fromJson(dynamic json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    code = json['code'];
    flag = json['flag'];
    regex = json['regex'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name_ar'] = nameAr;
    map['name_en'] = nameEn;
    map['code'] = code;
    map['flag'] = flag;
    map['regex'] = regex;
    return map;
  }
}
