import 'dart:convert';

import 'package:lechoix/features/auth/domain/entities/auth/AuthResponseModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/response/OnBoardingResponse.dart';
import '../ui/screens/host/host_bloc.dart';

class UserCache {
  static final UserCache _instance = UserCache._private();

  static UserCache get instance => _instance;

  UserCache._private();

  AuthResponseModel? _user;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  late SharedPreferences _prefs;

  // Language
  void setLanguage(String language) {
    _prefs.setString(UserCacheKeys.language, language);
  }

  String getLanguage() {
    return _prefs.getString(UserCacheKeys.language) ?? "en";
  }

  bool isArabic() {
    return getLanguage() == "ar";
  }

  //"Onboarding"
  void setOnboardingStatus(bool isTakeed) {
    _prefs.setBool(UserCacheKeys.onboarding, isTakeed);
  }

  bool takeOnboardingStatus() {
    return _prefs.getBool(UserCacheKeys.onboarding) ?? false;
  }

  // DeviceId
  void setDeviceId(String accessToken) {
    _prefs.setString(UserCacheKeys.deviceId, accessToken);
  }

  String getDeviceId() {
    String deviceId = _prefs.getString(UserCacheKeys.deviceId) ?? "";
    if (deviceId.isEmpty) {
      deviceId = "${DateTime.now().millisecondsSinceEpoch}";
      setDeviceId(deviceId);
    }
    return deviceId;
  }

  //USER
  bool isLoggedIn() => getUser() != null;

  void setUser(AuthResponseModel? model) {
    if (model == null) {
      return;
    }
    String json = jsonEncode(model.toJson());
    _prefs.setString(UserCacheKeys.user, json);
    _user = model;
  }

  AuthResponseModel? getUser() {
    if (_user != null) {
      return _user;
    }

    String? json = _prefs.getString(UserCacheKeys.user);
    if (json == null) {
      return null;
    }
    _user = AuthResponseModel.fromJson(jsonDecode(json));
    return _user;
  }

  String getAccessToken() {
    AuthResponseModel? currentUser = getUser();
    return currentUser?.accessToken ?? "";
  }

  void logout() {
    _prefs.remove(UserCacheKeys.user);
    _prefs.remove(UserCacheKeys.coupon);
    _prefs.remove(UserCacheKeys.cartCount);
    _user = null;
  }

  //COUPON
  void setCoupon(String coupon) {
    _prefs.setString(UserCacheKeys.coupon, coupon);
  }

  String? getCoupon() {
    return _prefs.getString(UserCacheKeys.coupon);
  }

  void removeCoupon() {
    _prefs.remove(UserCacheKeys.coupon);
  }

  //categoryId
  void setCategoryId(int categoryId) {
    _prefs.setInt(UserCacheKeys.categoryId, categoryId);
  }

  int getCategoryId() {
    return _prefs.getInt(UserCacheKeys.categoryId) ?? 1;
  }

  //Cart Count
  void updateCartCount(int count, bool isAdd) {
    int newCount = getCartCount();
    if (isAdd) {
      newCount += 1;
    } else {
      newCount = count;
    }
    _prefs.setInt(UserCacheKeys.cartCount, newCount);
    HostBloc.updateCartCount();
  }

  int getCartCount() {
    return _prefs.getInt(UserCacheKeys.cartCount) ?? 0;
  }

  //FCM
  String getFCMToken() {
    return _prefs.getString(UserCacheKeys.FCM) ?? "";
  }

  void saveFCMToken(String token) {
    _prefs.setString(UserCacheKeys.FCM, token);
  }
 //Allow FCM
  bool getAllowFCMStatus() {
    return _prefs.getBool(UserCacheKeys.AllowFCM) ?? false;
  }

  void setAllowFCMStatus(bool status) {
    _prefs.setBool(UserCacheKeys.AllowFCM, status);
  }
  // onBoarding Screens
  List<OnBoardingModel> onBoardingScreens = [];

  OnBoardingModel getOnBoardingScreen(int index) {
    OnBoardingModel content = OnBoardingModel();
    content = onBoardingScreens[index];
    return content ;
  }

}

class UserCacheKeys {
  static const String user = "User";
  static const String coupon = "Coupon";
  static const String cartCount = "CartCount";

  static const String language = "Language";
  static const String onboarding = "Onboarding";
  static const String deviceId = "DeviceId";
  static const String categoryId = "categoryId";
  static const String FCM = "FCM";
  static const String AllowFCM = "AllowFCM";

}
