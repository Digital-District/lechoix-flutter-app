class CategoryResponse {
  List<CategoryModel>? dataList;

  CategoryResponse({
    this.dataList,
  });

  CategoryResponse.fromJson(dynamic json) {
    if (json['categories'] != null) {
      dataList = [];
      json['categories'].forEach((v) {
        dataList?.add(CategoryModel.fromJson(v));
      });
    }
  }
}

class CategoryModel {
  int? id;
  String? name;
  String? image;
  String? cover;
  List<CategoryModel> subcategories = [];
  int? productCount;

  CategoryModel({
    this.id,
    this.name,
    this.image,
    this.cover,
    this.productCount,
  });

  CategoryModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    cover = json['cover'];
    if (json['subcategories'] != null) {
      subcategories = [];
      json['subcategories'].forEach((v) {
        subcategories.add(CategoryModel.fromJson(v));
      });
    }
    productCount = json['products_count'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['image'] = image;
    map['cover'] = cover;
    map['subcategories'] = subcategories.map((v) => v.toJson()).toList();
    map['products_count'] = productCount;
    return map;
  }
}
