class HtmlModel {
  int? id;
  String? name;
  String? content;

  HtmlModel({
    this.id,
    this.name,
    this.content,
  });

  HtmlModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['content'] = content;
    return map;
  }
}
