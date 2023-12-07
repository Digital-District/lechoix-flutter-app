import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/domain/entities/login.dart';
import '../../features/auth/domain/usecase/login_usecase.dart';
import '../error/exceptions.dart';

const userCacheConst = "user_cache";
const cacheTokenConst = "cache_token";
const loginInfoConst = "login_info";
const registerBodyConst = "register_body_const";

abstract class AuthLocalDataSource {
  Future<void> cacheUserData({required User user});
  Future<User> getCachedUserData();
  Future<void> clearCachedUser();
  Future<void> cacheUserAccessToken({required String token});
  Future<String> getCacheUserAccessToken();
//  Future<String> checkAccessForGuest();
  Future<void> cacheUserLoginInfo({required LoginParams params});
  Future<LoginParams> getCacheUserLoginInfo();
  Future<void> clearData();
}

class AuthLocalDataSourceImpl extends AuthLocalDataSource {
  final SharedPreferences sharedPreference;
  AuthLocalDataSourceImpl({required this.sharedPreference});

  @override
  Future<void> cacheUserData({required User user}) async {
    try {
      await sharedPreference.setString(userCacheConst,jsonEncode(user) );
      log(user.toString());
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<User> getCachedUserData() async {
    try {
      final userShared = sharedPreference.getString(userCacheConst);
      debugPrint(userShared);

      if (userShared != null) {
        final json = jsonDecode(userShared);

        return User.fromJson(json);
      } else {
        throw NoCachedUserException();
      }
    } on NoCachedUserException {
      throw NoCachedUserException();
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> clearCachedUser() async {
    try {
      await sharedPreference.clear();
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheUserAccessToken({required String token}) async {
    try {
      await sharedPreference.setString(cacheTokenConst, token);
    } catch (e) {
      // log(e.toString());
      throw CacheException();
    }
  }

  @override
  Future<String> getCacheUserAccessToken() async {
    try {
      final userShared = sharedPreference.getString(cacheTokenConst);
      if (userShared != null) {
        return userShared;
      } else {
        throw NoCachedUserException();
      }
    } on NoCachedUserException {
      throw NoCachedUserException();
    } catch (e) {
      throw CacheException();
    }
  }

  //
  @override
  Future<void> cacheUserLoginInfo({required LoginParams params}) async {
    try {
      await sharedPreference.setString(
          loginInfoConst, json.encode(params.toMap()));
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<LoginParams> getCacheUserLoginInfo() async {
    try {
      final loginInfo = sharedPreference.getString(loginInfoConst);
      if (loginInfo != null) {
        return LoginParams.fromMap(json.decode(loginInfo));
      } else {
        throw NoCachedUserException();
      }
    } catch (e) {
      throw NoCachedUserException();
    }
  }

  //
  @override
  Future<void> clearData() async {
    try {
      await sharedPreference.clear();
    } catch (e) {
      throw NoCachedUserException();
    }
  }
}
