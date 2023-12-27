import 'package:lechoix/data/Enumeration.dart';

import '../../../../core/base/base_repo.dart';
import '../../../../core/util/network/endpoints.dart';
import '../../../../data/address/AddAddressRequestModel.dart';
import '../../../../data/address/AddressResponse.dart';
import '../../../../data/base/BaseResponse.dart';

class AddressRepo extends BaseRepo {
  Future<BaseResponse<AddressResponse>> getMyAddress() {
    return networkManager.request<AddressResponse>(
      Endpoints.addresses,
      Method.GET,
    );
  }

  Future<BaseResponse<dynamic>> addAddress(AddAddressRequestModel model) {
    return networkManager.request<dynamic>(Endpoints.addresses, Method.POST,
        data: model.toJson());
  }

  Future<BaseResponse<dynamic>> updateAddress(
      AddAddressRequestModel model, int addressId) {
    String url = "${Endpoints.addresses}/$addressId";
    return networkManager.request<dynamic>(url, Method.PATCH,
        data: model.toJson());
  }

  Future<BaseResponse<dynamic>> setDefault(int addresseId) {
    String url = "${Endpoints.addresses}/$addresseId/set-default";
    return networkManager.request<dynamic>(
      url,
      Method.PATCH,
    );
  }

  Future<BaseResponse<dynamic>> deleteAddress(int addressId) {
    String url = "${Endpoints.addresses}/$addressId";
    return networkManager.request<dynamic>(
      url,
      Method.DELETE,
    );
  }
}
