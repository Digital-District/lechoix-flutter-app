import 'package:lechoix/core/base/base_repo.dart';
import 'package:lechoix/core/util/network/endpoints.dart';
import 'package:lechoix/data/Enumeration.dart';
import 'package:lechoix/data/base/BaseResponse.dart';

class NotificationRepo extends BaseRepo {
  Future<BaseResponse<dynamic>> updateNotificationToken(
      Map<String, dynamic> param) {
    return networkManager.request<dynamic>(
      Endpoints.updateNotificationToken,
      Method.POST,
      data: param,
    );
  }

  Future<BaseResponse<dynamic>> deleteNotificationToken() {
    return networkManager.request<dynamic>(
      Endpoints.deleteNotificationToken,
      Method.DELETE,
    );
  }
}
