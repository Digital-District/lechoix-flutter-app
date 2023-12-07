class TaxModel {
  String? value;
  String? percentage;
  String? taxType;

  TaxModel({
    this.value,
    this.percentage,
    this.taxType,
  });

  TaxModel.fromJson(dynamic json) {
    value = json['value'].toString();
    percentage = json['percentage'].toString();
    taxType = json['tax_type'].toString();
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['value'] = value;
    map['percentage'] = percentage;
    map['tax_type'] = taxType;
    return map;
  }
}
