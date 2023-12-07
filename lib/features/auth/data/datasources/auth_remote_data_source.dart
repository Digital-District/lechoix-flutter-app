import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/util/api_basehelper.dart';
import '../../domain/entities/check_otp.dart';
import '../../domain/entities/forget_password_response.dart';
import '../../domain/entities/login.dart';
import '../../domain/entities/register.dart';
import '../../domain/entities/send_code.dart';
import '../../domain/entities/update_password.dart';
import '../../domain/usecase/check_otp.dart';
import '../../domain/usecase/forget_password_usecase.dart';
import '../../domain/usecase/login_usecase.dart';
import '../../domain/usecase/register_usecase.dart';
import '../../domain/usecase/send_code_usecase.dart';
import '../../domain/usecase/update_password.dart';

//login
const loginApi = "login";
const logoutApi = "logout";
const deleteAccountApi = "user/delete";
const checkOtpApi = 'send_check_otp';
const sendCodeApi = 'forget_password';
const forgetPasswordApi = 'forget_password_update';
//register
const registerApi = "register";
//update password
const updatePasswordApi = "reset_password";

abstract class AuthRemoteDataSource {
  Future<String> logout();
  Future<String> deleteAccount();
  Future<LoginResponse> login({required LoginParams params});

  Future<RegisterResponse> register({required CompleteRegisterParams params});
  Future<CheckOtpResponse> checkOtp({required CheckOtpParams params});
  Future<UpdatePasswordResponse> updatePassword(
      {required UpdatePasswordParams params});
  Future<SendCodeForForgetPasswordResponse> sendCode(
      {required SendCodeParams params});
  Future<ForgetPasswordResponse> forgetPassword(
      {required ForgetPassowrdParams params});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiBaseHelper helper;
  AuthRemoteDataSourceImpl({
    required this.helper,
  });

  //register
  @override
  Future<RegisterResponse> register(
      {required CompleteRegisterParams params}) async {
    try {
      final response =
          await helper.post(url: registerApi, body: params.toMap());
      if (response["success"] == "true") {
        debugPrint("rgisterResponse======200}");
        final rgisterResponse = RegisterResponse.fromJson(response);
        debugPrint("rgisterResponse=======${rgisterResponse.data.toString()}");
        return rgisterResponse;
      } else {
        debugPrint("else rgisterResponse=======${response.toString()}");
        Map error = response['message'];
        String? errorMessage;
        error.forEach((key, value) {
          errorMessage = "$key ${value[0]}";
          log(errorMessage.toString());
        });
        throw ServerException(message: errorMessage ?? "Unvalid Fields");
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<LoginResponse> login({required LoginParams params}) async {
    try {
      String? fcmToken = await FirebaseMessaging.instance.getToken();
      debugPrint('FCM Token: $fcmToken');

      final response = await helper.post(url: loginApi, body: {
        "password": params.userPassword,
        "phone": params.userPhone,
        "fcm_token": fcmToken
      });
      if (response["success"] == "true") {
        LoginResponse loginResponse = LoginResponse.fromJson(response);
        return loginResponse;
      } else {
        throw ServerException(message: response['message']);
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<String> logout() async {
    try {
      final response = await helper.post(url: logoutApi, body: {});
      // if (response["status"] == true) {
      return "logout successfuly";
      // } else {
      //   throw ServerException(message: "no Token");
      // }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<CheckOtpResponse> checkOtp({required CheckOtpParams params}) async {
    try {
      final response = await helper.get(
        url: '$checkOtpApi&user_id=${params.userID}',
      );
      log("logout====$response");
      if (response['code'] == 200) {
        return CheckOtpResponse.fromJson(response);
      } else {
        throw UnauthorizedException(message: "خطأ في  بيانات تسجيل الدخول");
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<UpdatePasswordResponse> updatePassword(
      {required UpdatePasswordParams params}) async {
    try {
      final response = await helper.get(
          url:
              '$updatePasswordApi&user_id=${params.userId}&user_password=${params.userPassword}');
      log("logout====$response");
      if (response["code"] == 200) {
        return UpdatePasswordResponse.fromJson(response);
      } else {
        throw ServerException(message: response['message']);
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<SendCodeForForgetPasswordResponse> sendCode(
      {required SendCodeParams params}) async {
    try {
      final response =
          await helper.get(url: '$sendCodeApi&user_phone=${params.phone}');
      log("SendCodeForForgetPasswordResponse====$response");
      if (response["code"] == 200) {
        return SendCodeForForgetPasswordResponse.fromJson(response);
      } else {
        throw ServerException(message: response['message']);
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<ForgetPasswordResponse> forgetPassword(
      {required ForgetPassowrdParams params}) async {
    try {
      final response = await helper.get(
          url:
              '$forgetPasswordApi&user_phone=${params.phone}&user_password=${params.newPassword}&user_otp=${params.verificationCode}');
      log("ForgetPasswordResponse====$response");
      if (response["code"] == 200) {
        return ForgetPasswordResponse.fromJson(response);
      } else {
        throw ServerException(message: response['message']);
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<String> deleteAccount() async {
    try {
      final response = await helper.post(url: deleteAccountApi, body: {});
      // if (response["status"] == true) {
      return "Account Deleted successfuly";
      // } else {
      //   throw ServerException(message: "no Token");
      // }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }
}
