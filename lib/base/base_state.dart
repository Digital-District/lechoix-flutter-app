import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lechoix/cache/user_cache.dart';
import 'package:lechoix/core/util/utils/navigation_util.dart';
import 'package:lechoix/core/util/utils/route_util.dart';
import 'package:lechoix/features/auth/domain/entities/auth/AuthResponseModel.dart';

import '../core/util/utils/toast_util.dart';
import 'base_bloc.dart';
import 'base_view.dart';

abstract class BaseState<T extends StatefulWidget, B extends BaseBloc>
    extends State<T> implements BaseView {
  late B bloc;

  AuthResponseModel? get currentUser => UserCache.instance.getUser();

  bool get isLoggedIn => UserCache.instance.isLoggedIn();

  CancelFunc? cancelFunc;
  bool _loaderVisible = false;

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    return _loaderVisible;
  }

  void initBloc();

  @override
  void initState() {
    super.initState();
    initBloc();
    BackButtonInterceptor.add(myInterceptor);
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    bloc.onDispose();
    super.dispose();
  }

  @override
  void showProgress() {
    closeKeyboard();
    cancelFunc?.call();

    cancelFunc = BotToast.showLoading();
    _loaderVisible = true;
  }

  @override
  void hideProgress() {
    cancelFunc?.call();
    _loaderVisible = false;
  }

  @override
  void showSuccessMsg(String msg) {
    if (msg.isEmpty) return;
    showToast(msg, Icons.check_circle, Colors.black);
  }

  @override
  void showErrorMsg(String msg) {
    if (msg.isEmpty) return;
    showToast(msg, Icons.error, Colors.redAccent);
  }

  @override
  String localize(String key) {
    return tr(key);
  }

  @override
  void handleUnauthenticatedUser() {
    pushReplacementNamed(RouteUtil.login);
  }

  void pop({dynamic res}) => NavigationUtil.pop(context, res: res);

  Future<dynamic> navigateTo(Widget screen,
      {bool fullscreenDialog = false, BuildContext? myContext}) {
    return NavigationUtil.navigateTo(
        myContext ?? NavigationUtil.navigatorKey.currentContext!, screen,
        fullscreenDialog: fullscreenDialog);
  }
}
