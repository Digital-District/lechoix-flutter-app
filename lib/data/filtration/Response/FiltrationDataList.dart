import 'DataList.dart';

class FiltrationDataList {
  List<FiltrationModel>? dataList;

  FiltrationDataList({
    this.dataList,
  });

  FiltrationDataList.fromJson(dynamic json) {
    if (json['data_list'] != null) {
      dataList = [];
      json['data_list'].forEach((v) {
        dataList?.add(FiltrationModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (dataList != null) {
      map['data_list'] = dataList?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
