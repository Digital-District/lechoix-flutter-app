import 'package:lechoix/core/util/network/endpoints.dart';
import 'package:lechoix/data/Enumeration.dart';

import '../../../../core/base/base_repo.dart';
import '../../../../data/base/BaseResponse.dart';
import '../../../../data/filtration/Response/FiltrationDataList.dart';

class FiltrationRepo extends BaseRepo {
  Future<BaseResponse<FiltrationDataList>> getFiltrationData(
      FiltrationType type, Map<String, dynamic> param) {
    String url = Endpoints.brands;
    if (type == FiltrationType.colors) {
      url = Endpoints.colors;
    } else if (type == FiltrationType.clothingSize) {
      url = Endpoints.sizes;
    } else if (type == FiltrationType.priceRange) {
      url = Endpoints.priceRanges;
    }
    return networkManager.request<FiltrationDataList>(url, Method.GET,
        data: param);
  }
}
