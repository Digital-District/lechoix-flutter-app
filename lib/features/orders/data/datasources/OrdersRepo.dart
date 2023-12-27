import 'package:lechoix/core/base/base_repo.dart';
import 'package:lechoix/core/util/network/endpoints.dart';
import 'package:lechoix/data/Enumeration.dart';
import 'package:lechoix/data/base/BaseResponse.dart';
import 'package:lechoix/data/orders/MyOrdersResponse.dart';
import 'package:lechoix/data/orders/OrderModel.dart';

class OrdersRepo extends BaseRepo {
  Future<BaseResponse<OrderModel>> makeOrder(Map<String, dynamic> data) {
    return networkManager.request<OrderModel>(Endpoints.orders, Method.POST,
        data: data);
  }

  Future<BaseResponse<MyOrdersResponse>> getMyOrders() {
    return networkManager.request<MyOrdersResponse>(
      Endpoints.orders,
      Method.GET,
    );
  }

  Future<BaseResponse<dynamic>> cancelOrder(int orderId) {
    String url = "${Endpoints.orders}/$orderId/cancel";
    return networkManager.request<dynamic>(
      url,
      Method.PATCH,
    );
  }
}
