import 'dart:async';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:lechoix/cache/user_cache.dart';
import 'package:lechoix/core/util/network/status_codes.dart';
import 'package:lechoix/data/base/ErrorModel.dart';

import 'base_view.dart';

abstract class BaseBloc {
  late BaseView view;
  final UserCache userCache = UserCache.instance;

  BaseBloc(this.view);

  void handleStreamError(dynamic e, StreamController controller) {
    if (e != null) {
      if (!controller.isClosed) controller.addError(e);
      handleError(e);
    }
  }

  void handleError(dynamic e) {
    ErrorResponse errorModel = ErrorResponse();
    print(e);
    if (e is DioException && e.type == DioExceptionType.cancel) return;
    try {
      if (e is DioException && e.response != null) {
      Response? response = e.response;
        errorModel.errorCode = response?.statusCode ?? 0;
        if (errorModel.errorCode >= StatusCodes.serverError) {
          errorModel.message = tr("Internal Server error");
        } else if (errorModel.errorCode == StatusCodes.unauthenticated) {
          errorModel.message =
              tr("Your session has expired please sign-in again");
          view.handleUnauthenticatedUser();
        } else {
          errorModel.message = response?.data["message"];
          errorModel.setErrors(response?.data);
        }
      } else {}
    } catch (_) {}

    onError(errorModel);
  }

  void onError(ErrorResponse errorModel) {
    view.hideProgress();
    view.showErrorMsg(errorModel.message ?? "");
  }

  void onDispose();

  

}
