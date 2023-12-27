import '../../../../core/base/base_repo.dart';
import '../../../../core/util/network/endpoints.dart';
import '../../../../data/Enumeration.dart';
import '../../../../data/base/BaseResponse.dart';
import '../../../../data/model/HTMLModel.dart';
import '../../domain/entities/auth/AuthRequestModel.dart';
import '../../domain/entities/auth/AuthResponseModel.dart';

class AuthRepo extends BaseRepo {
  Future<BaseResponse<AuthResponseModel>> register(AuthRequestModel model) {
    return networkManager.request<AuthResponseModel>(
        Endpoints.register, Method.POST,
        data: model.toJson());
  }

  Future<BaseResponse<AuthResponseModel>> login(AuthRequestModel model) {
    return networkManager.request<AuthResponseModel>(
        Endpoints.login, Method.POST,
        data: model.toJson());
  }

  Future<BaseResponse<AuthResponseModel>> verifyPhone(AuthRequestModel model) {
    return networkManager.request<AuthResponseModel>(
        Endpoints.verifyPhone, Method.POST,
        data: model.toJson());
  }

  Future<BaseResponse<dynamic>> passwordCheckCode(AuthRequestModel model) {
    return networkManager.request<dynamic>(
        Endpoints.passwordCheckCode, Method.POST,
        data: model.toJson());
  }

  Future<BaseResponse<AuthResponseModel>> forgetPassword(
      AuthRequestModel model) {
    return networkManager.request<AuthResponseModel>(
        Endpoints.forgetPassword, Method.POST,
        data: model.toJson());
  }

  Future<BaseResponse<AuthResponseModel>> resetPassword(
      AuthRequestModel model) {
    return networkManager.request<AuthResponseModel>(
        Endpoints.resetPassword, Method.PATCH,
        data: model.toJson());
  }

  Future<BaseResponse<dynamic>> resendCode(AuthRequestModel model) {
    return networkManager.request<dynamic>(Endpoints.resendCode, Method.POST,
        data: model.toJson());
  }

  Future<BaseResponse<HtmlModel>> getHTMLPage(String page) {
    String url = Endpoints.HTMLPage + page;
    return networkManager.request<HtmlModel>(url, Method.GET);
  }
}
