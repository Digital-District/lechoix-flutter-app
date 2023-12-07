import 'package:lechoix/base/base_repo.dart';
import 'package:lechoix/core/util/network/endpoints.dart';
import 'package:lechoix/data/Enumeration.dart';
import 'package:lechoix/data/base/BaseResponse.dart';
import 'package:lechoix/data/model/HTMLModel.dart';
import 'package:lechoix/features/auth/domain/entities/auth/AuthRequestModel.dart';
import 'package:lechoix/features/auth/domain/entities/auth/AuthResponseModel.dart';

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
