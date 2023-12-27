import '../../../../core/base/base_repo.dart';
import '../../../../core/util/network/endpoints.dart';
import '../../../../data/Enumeration.dart';
import '../../../../data/base/BaseResponse.dart';
import '../../../auth/domain/entities/auth/AuthResponseModel.dart';
// import 'package:image_picker/image_picker.dart';

class UserRepo extends BaseRepo {
  Future<BaseResponse<AuthResponseModel>> editProfile(
    String firstName,
    String lastName,
  ) {
    return networkManager.request<AuthResponseModel>(
      Endpoints.profile,
      Method.PATCH,
      data: {
        "first_name": firstName,
        "last_name": lastName,
      },
    );
  }

  // Future<BaseResponse<AuthResponseModel>> changeAvatar(XFile image) async {
  //   return networkManager.request<AuthResponseModel>(
  //     Endpoints.changeAvatar,
  //     Method.postFormData,
  //     data: {
  //       "avatar": await MultipartFile.fromFile(
  //         image.path,
  //         filename: image.name,
  //       ),
  //     },
  //   );
  // }

  Future<BaseResponse<dynamic>> requestChangeEmail(String email) {
    return networkManager.request<dynamic>(
      Endpoints.requestChangeEmail,
      Method.POST,
      data: {"email": email},
    );
  }

  Future<BaseResponse<AuthResponseModel>> changeEmail(
      String email, String code) {
    return networkManager.request<AuthResponseModel>(
      Endpoints.changeEmail,
      Method.PATCH,
      data: {
        "email": email,
        "code": code,
      },
    );
  }

  Future<BaseResponse<dynamic>> requestChangePhone(
      String phone, int phoneCountryCodeId) {
    return networkManager.request<dynamic>(
      Endpoints.requestChangePhone,
      Method.POST,
      data: {"phone": phone, "country_code_id": phoneCountryCodeId},
    );
  }

  Future<BaseResponse<AuthResponseModel>> changePhone(
      String phone, String code, int phoneCountryCodeId) {
    return networkManager.request<AuthResponseModel>(
      Endpoints.changePhone,
      Method.PATCH,
      data: {
        "phone": phone,
        "code": code,
        "country_code_id": phoneCountryCodeId
      },
    );
  }

  Future<BaseResponse<AuthResponseModel>> changePassword(
    String oldPassword,
    String newPassword,
  ) {
    return networkManager.request<AuthResponseModel>(
      Endpoints.changePassword,
      Method.PATCH,
      data: {
        "password": oldPassword,
        "new_password": newPassword,
      },
    );
  }

  Future<BaseResponse<dynamic>> deleteAccount() {
    return networkManager.request<AuthResponseModel>(
      Endpoints.deleteAccount,
      Method.DELETE,
    );
  }
}
