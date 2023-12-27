import 'package:flutter/material.dart';

import '../../base/base_state.dart';

class NavigationUtil {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static GlobalKey<NavigatorState> homeNavigatorKey =
      GlobalKey<NavigatorState>();
  static GlobalKey<NavigatorState> categoriesNavigatorKey =
      GlobalKey<NavigatorState>();
  static GlobalKey<NavigatorState> wishlistNavigatorKey =
      GlobalKey<NavigatorState>();
  static GlobalKey<NavigatorState> bagNavigatorKey =
      GlobalKey<NavigatorState>();
  static GlobalKey<NavigatorState> moreNavigatorKey =
      GlobalKey<NavigatorState>();

  static Future<dynamic> navigateTo(
    BuildContext context,
    Widget screen, {
    bool fullscreenDialog = false,
  }) =>
      Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => screen, fullscreenDialog: fullscreenDialog));

  static Future<dynamic> pushReplacementNamed(
          BuildContext context, String route) =>
      Navigator.of(context).pushReplacementNamed(route);

  static Future<dynamic> pushReplacementAndClear(
          BuildContext context, String route) =>
      Navigator.of(context).pushNamedAndRemoveUntil(route, (r) => false);

  static void pop(BuildContext context, {dynamic res}) =>
      Navigator.pop(context, res);

  static void showSlideDialog(BuildContext context, Widget screen) =>
      showGeneralDialog(
        context: context,
        pageBuilder: (context, anim1, anim2) => screen,
        transitionBuilder: (context, anim1, anim2, child) => SlideTransition(
          position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0))
              .animate(anim1),
          child: child,
        ),
      );
}

extension NavigationExtension on BaseState {
  Future<dynamic> navigateTo(
    Widget screen, {
    bool fullscreenDialog = false,
  }) =>
      NavigationUtil.navigateTo(context, screen,
          fullscreenDialog: fullscreenDialog);

  Future<dynamic> pushReplacementNamed(String route) =>
      NavigationUtil.pushReplacementNamed(context, route);

  Future<dynamic> pushReplacementAndClear(String route) =>
      NavigationUtil.pushReplacementAndClear(context, route);

  void pop({dynamic res}) => NavigationUtil.pop(context, res: res);

  void closeKeyboard() => FocusScope.of(context).requestFocus(FocusNode());
}
