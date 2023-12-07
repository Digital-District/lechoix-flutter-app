import '../CategoryModel.dart';
import 'Response/DataList.dart';

class FiltrationDataModel {
  int id = 0;
  String name = "";

  String image = "";

  bool isSelected = false;

  FiltrationDataModel.Category(CategoryModel model, List<int> ids) {
    id = model.id ?? 0;
    name = model.name ?? "";
    isSelected = ids.contains(id);
  }

  FiltrationDataModel.FiltrationModel(FiltrationModel model, List<int> ids) {
    id = model.id ?? 0;
    name = model.name ?? "";
    isSelected = ids.contains(id);
  }

  FiltrationDataModel.Color(FiltrationModel model, List<int> ids) {
    id = model.id ?? 0;
    name = model.name ?? "";
    image = model.image ?? "";
    isSelected = ids.contains(id);
  }
}
