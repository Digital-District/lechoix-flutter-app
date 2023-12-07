import 'package:easy_localization/easy_localization.dart';

import 'navigation_util.dart';

class LocaleHelper {
  static String getCurrentLocale() {
    String? locale;
    if (NavigationUtil.navigatorKey.currentState?.context != null) {
      locale =
          EasyLocalization.of(NavigationUtil.navigatorKey.currentState!.context)
              ?.currentLocale
              ?.languageCode;
    }
    return locale ?? "ar";
  }
}

extension LocalExtension on String {
  String localize({List<String>? args}) => this.tr(args: args);
}
